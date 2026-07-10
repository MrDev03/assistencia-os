// Usando as importações da API V2
const { onRequest, onCall } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");

admin.initializeApp();

// 1. Aponta para o segredo que você criou no terminal
const stripeSecretKey = defineSecret('STRIPE_SECRET_KEY');

// ============================================================================
// WEBHOOK DO STRIPE
// ============================================================================
// 2. Na v2, passamos os segredos como um objeto de opções { secrets: [...] }
exports.stripeWebhook = onRequest(
  { secrets: [stripeSecretKey] },
  async (req, res) => {

  // 3. Inicializa o Stripe AQUI DENTRO usando o .value() do segredo
  const stripe = require('stripe')(stripeSecretKey.value());

  const sig = req.headers["stripe-signature"];
  const endpointSecret = "whsec_fpxADXZipCMynQDedZXvFmg6UwI8SLGw";

  let event;

  try {
    event = stripe.webhooks.constructEvent(req.rawBody, sig, endpointSecret);
  } catch (err) {
    console.error(`Erro de assinatura do Webhook: ${err.message}`);
    return res.status(400).send(`Webhook Error: ${err.message}`);
  }

  try {
    // 1️⃣ QUANDO O USUÁRIO COMPRA A ASSINATURA PELA PRIMEIRA VEZ
    if (event.type === "checkout.session.completed") {
      const session = event.data.object;

      const firebaseUid = session.client_reference_id;
      const stripeCustomerId = session.customer;

      if (firebaseUid) {
        // Salva o Customer ID
        await admin.firestore().collection("users").doc(firebaseUid).set({
          stripeCustomerId: stripeCustomerId
        }, { merge: true });

        // Ativa a assinatura
        await admin.firestore().collection("users").doc(firebaseUid).collection("subscription").doc("info").set({
          active: true,
          platform: "windows_stripe",
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        }, { merge: true });
      }
    }

    // 2️⃣ QUANDO A ASSINATURA É CANCELADA, PAUSADA OU EXPIRA
    if (event.type === "customer.subscription.deleted" || event.type === "customer.subscription.updated") {
      const subscription = event.data.object;
      const stripeCustomerId = subscription.customer;

      const usersSnapshot = await admin.firestore()
        .collection("users")
        .where("stripeCustomerId", "==", stripeCustomerId)
        .get();

      if (!usersSnapshot.empty) {
        const firebaseUid = usersSnapshot.docs[0].id;
        // Substitua a linha antiga por esta:
        const isActive = subscription.status === "active" || subscription.status === "trialing";

        await admin.firestore().collection("users").doc(firebaseUid).collection("subscription").doc("info").set({
          active: isActive,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        }, { merge: true });
      }
    }

    res.json({ received: true });

  } catch (error) {
    console.error("Erro ao processar o webhook:", error);
    res.status(500).send("Internal Server Error");
  }
});

// ============================================================================
// FUNÇÃO ONCALL (CHAMADA PELO FLUTTER)
// ============================================================================
exports.verifySubscriptionStatus = onCall(
  { secrets: [stripeSecretKey] },
  async (request) => {

  // Inicializa o Stripe AQUI DENTRO usando o .value()
  const stripe = require('stripe')(stripeSecretKey.value());

  // Na v2, o context de onCall mudou para request.auth e request.data
  if (!request.auth) {
    throw new admin.firestore.FirestoreError('unauthenticated', 'User not logged in.');
  }

  const uid = request.auth.uid;
  const email = request.data.email;

  if (!email) {
      throw new admin.firestore.FirestoreError('invalid-argument', 'Email is required.');
  }

  try {
    let isPro = false;
    let subscriptionData = null;

    const customers = await stripe.customers.list({ email: email });

    if (customers.data.length > 0) {
      for (const customer of customers.data) {

        // 🟢 CORREÇÃO AQUI: Traz 'all' (todas as assinaturas) ao invés de apenas as 'active'
        const subscriptions = await stripe.subscriptions.list({
          customer: customer.id,
          status: 'all',
        });

        if (subscriptions.data.length > 0) {

          // 🟢 CORREÇÃO AQUI: Filtra manualmente procurando por 'active' ou 'trialing'
          const activeOrTrialingSub = subscriptions.data.find(
            sub => sub.status === 'active' || sub.status === 'trialing'
          );

          if (activeOrTrialingSub) {
            isPro = true;

            subscriptionData = {
                expirationDate: activeOrTrialingSub.current_period_end ? new Date(activeOrTrialingSub.current_period_end * 1000) : null,
                lastPurchaseDate: activeOrTrialingSub.current_period_start ? new Date(activeOrTrialingSub.current_period_start * 1000) : null,
            };

            break; // Sai do loop de customers, pois já encontrou uma assinatura válida
          }
        }
      }
    }

    const docRef = admin.firestore().collection('users').doc(uid).collection('subscription').doc('info');

    // 🟢 CORREÇÃO: Só salva no banco se for VERDADEIRO.
        // Se for falso, não escrevemos nada para não apagar a assinatura do RevenueCat.
        if (isPro) {
          await docRef.set({
            active: true, // Garante que é true
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            platform: 'windows_stripe',
            ...subscriptionData,
          }, { merge: true });
        }

        // Retorna o resultado para o Flutter (que vai checar o RevenueCat se isPro for falso)
        return { isPro: isPro };

  } catch (error) {
    console.error("Error verifying subscription:", error);
    throw new admin.firestore.FirestoreError('internal', 'Failed to verify subscription.');
  }
});