import 'package:assistencia_os/pages/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// Importe onde você definiu a função signInWithGoogle e sua HomePage
// import 'package:seu_projeto/auth_service.dart';
// import 'package:seu_projeto/home_page.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? const CircularProgressIndicator()
          : OutlinedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
          setState(() {
            _isSigningIn = true;
          });

          // Chama a função lógica que criamos anteriormente
          UserCredential? userCredential = await signInWithGoogle();

          if (userCredential != null) {
            // Se o login for bem sucedido, navega para a Home
            if (context.mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AuthGate(),
                ),
              );
            }
          } else {
            // Caso o usuário cancele ou ocorra erro
            if (mounted) {
              setState(() {
                _isSigningIn = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Falha ao fazer login com Google')),
              );
            }
          }
        },
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Você pode usar uma imagem da logo do Google aqui
              Icon(Icons.login, color: Colors.blue),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Entrar com Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Inicializa a instância do Google Sign-In (Obrigatório na nova versão)
      // Se no futuro você precisar de acesso à agenda ou drive, é aqui que define os "scopes"
      await GoogleSignIn.instance.initialize();

      // 2. Iniciar o processo de autenticação (Abre o popup do Google)
      // Note que agora usamos .authenticate() em vez de .signIn()
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

      // 3. Obter os detalhes de autenticação do pedido
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // 4. Criar uma nova credencial para o Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      // 5. Fazer o login no Firebase com essa credencial e devolver o resultado
      return await FirebaseAuth.instance.signInWithCredential(credential);

    } catch (e) {
      print("Erro no Google Sign-In: $e");
      return null;
    }
  }

}