import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/dropdown_button_formfield.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:assistencia_os/pages/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../db_helper/cargo_helper.dart';
import '../../db_helper/empresa_helper.dart';
import '../../db_helper/premium_helper.dart';
import '../../models/empresa_model/empresa_model.dart';
import '../../providers/mobile_premium_provider.dart';
import '../../sync/modules/empresa_sync.dart';
import 'components/senha_segura_field.dart';
import 'forgot_password_screen.dart';

class LoginPage extends StatefulWidget {
  final Empresa? empresa;

  const LoginPage({
    super.key,
    this.empresa,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nomeEmpresaController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final syncEmpresa = EmpresaSync();

  // Estados
  bool _loading = false;
  String? _erro;
  bool _isLogin = true;
  bool _isPasswordVisible = true; // Movido para fora do build
  String? cargoSelecionado;
  bool _isSenhaValida = false;

  //final syncService = SyncService(DatabaseHelper.isar);
  final premium = PremiumProvider();

  // Opções do Dropdown
  final List<DropdownMenuItem<String>> _cargosItems = [
    const DropdownMenuItem(
      value: "atendente",
      child: Row(children: [Icon(Icons.person, size: 18), SizedBox(width: 10), Text("Atendente")]),
    ),
    const DropdownMenuItem(
      value: "tecnico",
      child: Row(children: [Icon(Icons.build, size: 18), SizedBox(width: 10), Text("Técnico")]),
    ),
    const DropdownMenuItem(
      value: "admin",
      child: Row(children: [Icon(Icons.admin_panel_settings, size: 18), SizedBox(width: 10), Text("Administrador")]),
    ),
  ];

  Widget _menuOptions ({
    required IconData icon,
    required String tittle,
    required String subtitle,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(tittle),
            Text(subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey
              ),
            )
          ],
        )
      ]
    );
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }
  // --- Lógica de Negócio ---

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _erro = null;
    });

    try {
      if (_isLogin) {

        if (cargoSelecionado == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Por favor, selecione um cargo.'),
            ),
          );
          return;
        }

        // Salvar cargo no banco local
        await CargoHelper.salvarCargo(cargoSelecionado!);
        //_salvarCargoLocal(cargoSelecionado!);

        // Auth
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _senhaController.text.trim(),
        );

      } else {
        // Cadastro
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _senhaController.text.trim(),
        );

        await CargoHelper.salvarCargo('admin');

        await EmpresaHelper.salvarNomeEmpresa(widget.empresa?.nome ?? _nomeEmpresaController.text.trim());

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Cadastro realizado com sucesso!'),
            ),
          );
        }
      }


    } on FirebaseAuthException catch (e) {

      print('code: ${e.code}');
      print('message: ${e.message}');

      String msg;

      switch (e.code) {

        case 'email-already-in-use':
          msg = "Este e-mail já está cadastrado. Tente fazer login ou use outro e-mail.";
          break;

        case 'user-not-found':
          msg = "Usuário não encontrado.";
          break;

        case 'wrong-password':
          msg = "Senha incorreta.";
          break;

        case 'invalid-credential':
          msg = "E-mail ou senha incorretos.";
          break;

        case 'weak-password':
          msg = "A senha fornecida é muito fraca.";
          break;

        case 'invalid-email':
          msg = "O formato do e-mail é inválido.";
          break;

        default:
          msg = "Erro ao autenticar. Verifique se o e-mail e a senha estão corretos.";
          print("Erro Firebase: ${e.code} | ${e.message}");
      }

      setState(() => _erro = msg);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _entrarComoVisitante() async {

    // Salvar cargo no banco local
    await CargoHelper.salvarCargo('Visitante');
    await PremiumHelper.salvarPremium(false);

    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
  }

  // --- UI Builders ---

  @override
  Widget build(BuildContext context) {


    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (event) {
        if (event.physicalKey == PhysicalKeyboardKey.enter && !_loading) {
          _submit();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light
          ),
          backgroundColor: Colors.transparent,
          toolbarHeight: 10,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Se a tela for maior que 900px, usa layout desktop (Split View)
            if (constraints.maxWidth > 900) {
              return _buildDesktopLayout();
            } else {
              return _buildMobileLayout();
            }
          },
        ),
      ),
    );
  }

  // Layout para Mobile (Vertical com Header Curvo)
  Widget _buildMobileLayout() {
    final theme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        // Fundo Superior
        Container(
          height: 350,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.primary, theme.primary.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 5),
                _buildLogo(100),
                const SizedBox(height: 10),
                const Text(
                  'Assistência OS',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                //const SizedBox(height: 5),
                const Text(
                  'Gerencie sua assistência técnica com eficiência.',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
        // Formulário Flutuante
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 250, left: 20, right: 20, bottom: 20),
            child: _buildFormCard(),
          ),
        ),
      ],
    );
  }

  // Layout para Desktop/Web (Split View)
  Widget _buildDesktopLayout() {
    final theme = Theme.of(context).colorScheme;
    return Row(
      children: [
        // Lado Esquerdo (Branding)
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.primary, theme.primary.withValues(alpha: 0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(150),
                const SizedBox(height: 20),
                const Text(
                  'Assistência OS',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Gerencie sua assistência técnica com eficiência.',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
        // Lado Direito (Formulário)
        Expanded(
          flex: 4,
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isLogin ? "Bem-vindo!" : "Crie sua conta",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: theme.primary),
                      ),
                      const SizedBox(height: 30),
                      _buildFormContent(), // Conteúdo do formulário sem o Card em volta (mais limpo no desktop)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Componente de Logo
  Widget _buildLogo(double size) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 2))],
      ),
      child: Image.asset(
        'assets/icons/icon_windows.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack);
  }

  // O Card que envolve o formulário (usado no Mobile)
  Widget _buildFormCard() {
    return SafeArea(
      child: CustomCard(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: _buildFormContent(),
        ),
      ).animate().slideY(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOut),
    );
  }

  // O conteúdo do formulário (Campos e Botões)
  Widget _buildFormContent() {
    final theme = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Alternar Login/Cadastro Title (apenas no mobile, desktop tem title fora)
          if (MediaQuery.of(context).size.width <= 900)
            Center(
              child: Text(
                _isLogin ? "Acessar Conta" : "Crie sua conta",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: theme.primary),
              ),
            ),
          if (MediaQuery.of(context).size.width <= 900) const SizedBox(height: 25),

          // Nome da Empresa (Cadastro)
          AnimatedSize(
            duration: 300.ms,
            child: !_isLogin
                ? Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CustomTextField(
                hintText: "Nome da empresa",
                labelText: "Nome da assistência",
                prefixIcon: const Icon(Icons.business_outlined),
                controller: _nomeEmpresaController,
                validator: (v) => v!.isEmpty ? "Campo obrigatório" : null,
              ),
            )
                : const SizedBox.shrink(),
          ),

          // Dropdown Cargo (Login)
          AnimatedSize(
            duration: 300.ms,
            child: _isLogin
                ? Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CustomDBFF(
                hintText: "Selecione um cargo",
                labelText: "Entrar como",
                items: _cargosItems,
                onChanged: (val) => setState(() => cargoSelecionado = val), suffixIcon: null,
              ),
            )
                : const SizedBox.shrink(),
          ),

          // Email
          CustomTextField(
            hintText: "Email",
            labelText: "Email",
            prefixIcon: const Icon(Icons.email_outlined),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => v!.isEmpty ? "Informe o email" : null,
          ),
          const SizedBox(height: 15),

          // Senha

          // === CAMPO DE SENHA MODIFICADO ===
          if (_isLogin)
          // 1. Se for Login, usa o campo normal sem regras embaixo
            CustomTextField(
              hintText: "Senha",
              labelText: "Senha",
              controller: _senhaController,
              prefixIcon: const Icon(Icons.lock_outline),
              obscureText: _isPasswordVisible,
              maxLines: 1,
              suffixIcon: IconButton(
                onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
              ),
              validator: (v) => v!.isEmpty ? "Informe a senha" : null,
            )
          else
          // 2. Se for Cadastro, usa o nosso componente inteligente
            SenhaSeguraField(
              controller: _senhaController, // Passamos o seu controller
              onValidacaoMudou: (bool ehValida, String senha) {
                // Atualiza a tela principal avisando se a senha passou nas regras
                setState(() {
                  _isSenhaValida = ehValida;
                });
              },
            ),

          Visibility(
            visible: _isLogin,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 160,
                child: TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen())),
                  child: const Text('Esqueceu a senha?'),
                ),
              ),
            ),
          ),

          // Mensagem de Erro
          if (_erro != null) ...[
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text(_erro!, style: const TextStyle(color: Colors.red, fontSize: 13))),
                ],
              ),
            ),
          ],

          const SizedBox(height: 25),

          // Botão Principal
          _loading
              ? Center(child: LoadingAnimationWidget.staggeredDotsWave(color: theme.primary, size: 40))
              : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: (_isLogin || _isSenhaValida) ? () => _submit() : null,
            child: Text(
              _isLogin ? "ENTRAR" : "CRIAR CONTA",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
            ),
          ),

          const SizedBox(height: 20),

          // Alternar Login/Cadastro
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_isLogin ? "Não tem conta?" : "Já possui conta?"),
              TextButton(
                onPressed: () => setState(() {
                  _isLogin = !_isLogin;
                  _erro = null;
                }),
                child: Text(
                  _isLogin ? "Cadastre-se" : "Faça Login",
                  style: TextStyle(fontWeight: FontWeight.bold, color: theme.primary),
                ),
              ),
            ],
          ),

          //const GoogleSignInButton(),

          const Divider(height: 30),

          // Botão Visitante
          TextButton.icon(
            onPressed: _entrarComoVisitante,
            icon: const Icon(Icons.login, size: 18, color: Colors.grey),
            label: const Text(
              "Continuar sem login (Modo Visitante)",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }



}