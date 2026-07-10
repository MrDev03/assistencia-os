import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/dialog.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../custom_widgets/loading_widget.dart';
import '../../custom_widgets/top_msg.dart';
import '../auth/components/senha_segura_field.dart';
import '../home/home.dart';

class GerenciarContaScreen extends StatefulWidget {
  final bool configPage;
  const GerenciarContaScreen({
    super.key,
    this.configPage = false,
  });

  @override
  State<GerenciarContaScreen> createState() => _GerenciarContaScreenState();
}

class _GerenciarContaScreenState extends State<GerenciarContaScreen> {

  final _senhaAtualController = TextEditingController();
  final _novaSenhaController = TextEditingController();
  bool _carregando = false;
  bool _isSenhaValida = false;
  String _erro = '';
  final isUpdate = ValueNotifier<int>(0);

  final User? usuarioLogado = FirebaseAuth.instance.currentUser;

  Future<bool?> _abrirModalAlterarSenha() async {

    final isButtonEnabled = ValueNotifier<bool>(_isSenhaValida);

    return CustomDialog2.show<bool>(
      context: context,
      title: 'Alterar Senha',
      cancelText: 'Cancelar',
      validar: isButtonEnabled,
      onConfirm: () {
        _atualizarSenha();
        isUpdate.value++;
      },
      content: ValueListenableBuilder<int>(
        valueListenable: isUpdate,
        builder: (context, value, child) {
          return Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Campo Senha Atual
                  CustomTextField(
                    controller: _senhaAtualController,
                    hintText: 'Senha atual',
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  const SizedBox(height: 16),

                  // Campo Nova Senha
                  SenhaSeguraField(
                    controller: _novaSenhaController, // Passamos o seu controller
                    onValidacaoMudou: (bool ehValida, String senha) {
                      // Atualiza a tela principal avisando se a senha passou nas regras
                      setState(() {
                        _isSenhaValida = ehValida;
                      });
                    },
                  ),

                  // _buildTextField(
                  //   controller: _novaSenhaController,
                  //   hint: 'Nova senha',
                  //   icon: Icons.lock_reset,
                  // ),

                  if (_erro.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3), width: 1.5),
                      ),
                      child: Text(
                        _erro, style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Future<void> _atualizarSenha() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingWidget(
        message: ['Atualizando', 'Sincronizando', 'Aguarde...'],
      ),
    );
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) return;

    final senhaAtual = _senhaAtualController.text.trim();
    final novaSenha = _novaSenhaController.text.trim();

    if (senhaAtual.isEmpty || novaSenha.isEmpty) {
      setState(() => _erro = 'Preencha ambos os campos.');
      return;
    }

    if (novaSenha.length < 6) {
      setState(() => _erro = 'A nova senha deve ter no mínimo 6 caracteres.');
      return;
    }

    setState(() {
      _carregando = true;
      _erro = '';
    });

    try {
      // SUBSTITUA A REAUTENTICAÇÃO POR UM LOGIN DIRETO:
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email!,
        password: senhaAtual,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Tempo limite esgotado no Login.'),
      );

      debugPrint("Token renovado. Atualizando senha...");

      // 2. Atualizar para a nova senha
      await user.updatePassword(novaSenha).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Tempo limite esgotado ao trocar senha.'),
      );

      // 3. Fechar o modal e mostrar uma mensagem de sucesso
      if (!mounted) return;
      Navigator.pop(context); // Fecha o modal
      AppFlushbar.success('Senha alterada com sucesso!');

    } on FirebaseAuthException catch (e) {
      debugPrint("ERRO FIREBASE AUTH: ${e.code} - ${e.message}");
      setState(() {
        if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
          _erro = 'A senha atual está incorreta. Verifique e tente novamente.';
        } else {
          _erro = 'Erro ao atualizar: ${e.message}';
        }
      });
      isUpdate.value++;
    } catch (e) {
      if (!_isSenhaValida) {
        _erro = 'Senha Ivalida';
      }
      setState(() => _erro = 'Ocorreu um erro inesperado.');
      isUpdate.value++;
    } finally {
      if (mounted) setState(() => _carregando = false);
      isUpdate.value++;
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final email = usuarioLogado?.email ?? 'carregando...';
    final uid = usuarioLogado?.uid ?? 'carregando...';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: widget.configPage && context.isDesktop ? null : AppBar(
        title: const Text('Minha Conta'),
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // ============ FUNDO GRADIENTE ============
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 30),
          
                _card(
                  child: Column(
                    children: [
                      _buildInfoRow(Icons.email_outlined, 'E-mail', email),
                      Divider(color: Colors.grey.withValues(alpha: 0.5), height: 1),
                      _buildInfoRow(Icons.badge_outlined, 'ID do Usuário', uid,
                        ontap: () {
                          Clipboard.setData(ClipboardData(text: uid));
                          AppFlushbar.success('Id copiado com sucesso!');
                        }
                      ),
                      Divider(color: Colors.grey.withValues(alpha: 0.5), height: 1),
                      _buildInfoRow(Icons.lock_outline, 'Senha', '••••••••'),
                    ],
                  ),
                ),
          
                const SizedBox(height: 40),
          
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary, //Colors.white.withOpacity(0.15),
                      foregroundColor: Colors.white,
                      elevation: 0,
                    ),
                    onPressed: null, //_abrirModalAlterarSenha,
                    child: const Text(
                      'Indisponível',//'Alterar Senha',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value, {VoidCallback? ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(/**color: Colors.white54**/ color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(/**color: Colors.white**/ fontSize: 16, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget do Modal de Senha com a lógica de reautenticação
// class _GlassPasswordModal extends StatefulWidget {
//   const _GlassPasswordModal();
//
//   @override
//   State<_GlassPasswordModal> createState() => _GlassPasswordModalState();
// }
//
// class _GlassPasswordModalState extends State<_GlassPasswordModal> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       child: _card(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//
//
//                 const SizedBox(height: 24),
//
//                 // Botões
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: Text('Cancelar', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
//                     ),
//                     const SizedBox(width: 8),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Theme.of(context).colorScheme.primary,
//                         foregroundColor: Colors.white,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                       onPressed: _carregando || !_isSenhaValida ? null : _atualizarSenha,
//                       child: _carregando
//                           ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                           : const Text('Salvar'),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _senhaAtualController.dispose();
//     _novaSenhaController.dispose();
//     super.dispose();
//   }
// }
//
  // Widget auxiliar
  Widget _card ({required Widget child}) {
    return CustomCard(
      child: child,
    );
  }