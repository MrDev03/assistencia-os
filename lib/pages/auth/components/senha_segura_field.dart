import 'package:flutter/material.dart';
import '../../../custom_widgets/text_field.dart';

class SenhaSeguraField extends StatefulWidget {
  final TextEditingController controller;
  final Function(bool, String) onValidacaoMudou;

  const SenhaSeguraField({
    super.key,
    required this.controller,
    required this.onValidacaoMudou,
  });

  @override
  SenhaSeguraFieldState createState() => SenhaSeguraFieldState();
}

class SenhaSeguraFieldState extends State<SenhaSeguraField> {
  bool _ocultarSenha = true;

  bool _temTamanhoMinimo = false;
  bool _temLetraMaiuscula = false;
  bool _temLetraMinuscula = false;
  bool _temNumero = false;
  bool _temCaractereEspecial = false;

  @override
  void initState() {
    super.initState();
    // Escuta tudo o que for digitado no controller sem precisar do "onChanged" no TextField
    widget.controller.addListener(_validarSenha);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validarSenha);
    super.dispose();
  }

  void _validarSenha() {
    String valor = widget.controller.text;

    setState(() {
      _temTamanhoMinimo = valor.length >= 8;
      _temLetraMaiuscula = valor.contains(RegExp(r'[A-Z]'));
      _temLetraMinuscula = valor.contains(RegExp(r'[a-z]'));
      _temNumero = valor.contains(RegExp(r'[0-9]'));
      _temCaractereEspecial = valor.contains(RegExp(r'[!@#\$&*~_.,\-]'));
    });

    bool todasRegrasAtendidas = _temTamanhoMinimo &&
        _temLetraMaiuscula &&
        _temLetraMinuscula &&
        _temNumero &&
        _temCaractereEspecial;

    // Avisa a tela principal se está válido ou não
    widget.onValidacaoMudou(todasRegrasAtendidas, valor);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Usando o SEU CustomTextField para não quebrar seu design!
        CustomTextField(
          hintText: "Crie uma senha forte",
          labelText: "Nova Senha",
          controller: widget.controller,
          prefixIcon: const Icon(Icons.lock_outline),
          obscureText: _ocultarSenha,
          maxLines: 1,
          suffixIcon: IconButton(
            icon: Icon(_ocultarSenha ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _ocultarSenha = !_ocultarSenha;
              });
            },
          ),
          validator: (v) => v!.isEmpty ? "Informe a senha" : null,
        ),

        const SizedBox(height: 12),

        // Regras de validação com animação sutil
        const Text(
          'Sua senha deve conter:',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        _construirRegra('Pelo menos 8 caracteres', _temTamanhoMinimo),
        _construirRegra('Uma letra maiúscula', _temLetraMaiuscula),
        _construirRegra('Uma letra minúscula', _temLetraMinuscula),
        _construirRegra('Um número', _temNumero),
        _construirRegra('Um caractere especial (!@#\$&*)', _temCaractereEspecial),
      ],
    );
  }

  Widget _construirRegra(String texto, bool regraAtendida) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style: TextStyle(
          color: regraAtendida ? Colors.green : Colors.grey[600],
          fontSize: 13,
          decoration: regraAtendida ? TextDecoration.lineThrough : null,
        ),
        child: Row(
          children: [
            Icon(
              regraAtendida ? Icons.check_circle : Icons.radio_button_unchecked,
              color: regraAtendida ? Colors.green : Colors.grey[400],
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(texto),
          ],
        ),
      ),
    );
  }
}