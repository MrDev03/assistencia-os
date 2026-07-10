import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../custom_widgets/text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage('Por favor, introduza o seu email.', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Método nativo do Firebase para enviar o email de reset
      await _auth.sendPasswordResetEmail(email: email);

      AppFlushbar.success('Email de recuperação enviado! Verifique a sua caixa de entrada.');
      //_showMessage('Email de recuperação enviado! Verifique a sua caixa de entrada.');

      // Opcional: Voltar para a tela de login após o envio com sucesso
      if (mounted) {
        Navigator.pop(context);
      }

    } on FirebaseAuthException catch (e) {
      // Tratamento de erros comuns do Firebase
      String errorMessage = 'Ocorreu um erro ao tentar enviar o email.';

      if (e.code == 'user-not-found') {
        errorMessage = 'Não existe nenhuma conta com este email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O formato do email é inválido.';
      }

      _showMessage(errorMessage, isError: true);
    } catch (e) {
      _showMessage('Erro inesperado: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
        centerTitle: true,
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 600
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomCard(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Icon(
                            Icons.lock_reset,
                            size: 80,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const Text(
                          'Esqueceu-se da senha?',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Introduza o seu email abaixo e enviaremos um link para redefinir a sua senha.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CustomTextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'Email',
                            hintText: 'Digite seu email',
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
              
                      label: _isLoading
                          ? LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: 35)
                          : Text(
                        'Enviar Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}