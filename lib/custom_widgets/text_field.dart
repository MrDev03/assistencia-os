import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {

  final String? labelText;
  final String hintText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final int? maxLenght;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final String? counterText;
  final int? maxLines;
  final bool expands;
  final TextCapitalization capitalization;
  final FocusNode? focusNode;
  final String? requiredTxt;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? labelColor;
  final Color? hintColor;
  final EdgeInsetsGeometry? padding;
  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
  final String? initialValue;
  final AutovalidateMode? autovalidateMode;

  const CustomTextField({
    super.key,
    this.labelText,
    required this.hintText,
    this.prefix,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.maxLenght,
    this.inputFormatters,
    this.enabled = true,
    this.counterText,
    this.maxLines,
    this.expands = false,
    this.capitalization = TextCapitalization.none,
    this.focusNode,
    this.requiredTxt,
    this.prefixIcon,
    this.backgroundColor,
    this.borderRadius,
    this.labelColor,
    this.hintColor,
    this.onSubmitted,
    this.onEditingComplete,
    this.padding,
    this.initialValue,
    this.autovalidateMode
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(top: 16),
      child: TextFormField(
        autovalidateMode: widget.autovalidateMode,
        initialValue: widget.initialValue,
        expands: widget.expands,
        maxLines: widget.maxLines,
        controller: widget.controller,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLenght,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.capitalization,
        onEditingComplete: widget.onEditingComplete,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.backgroundColor,
          // WidgetStateColor.resolveWith((Set<WidgetState> states) {
          //   final isDark = Theme.of(context).brightness == Brightness.dark;
          //   // Se o validador falhou e o campo está com erro
          //   if (states.contains(WidgetState.error)) {
          //     return Colors.red.withValues(alpha: 0.2); // Fundo avermelhado suave
          //   }
          //
          //   // Se o usuário clicou no campo (focado)
          //   // if (states.contains(WidgetState.focused)) {
          //   //   return Colors.white;
          //
          //   // // Se o campo estiver desativado (enabled: false)
          //   // if (states.contains(WidgetState.disabled)) {
          //   //   return theme.surface.withValues(alpha: 0.5);
          //   // }
          //
          //   // Cor padrão (fechado e sem erro)
          //   return isDark ? Colors.black : const Color(0xFFF2F5F9);
          // }),
          counterText: widget.counterText,
          label: widget.labelText == null ? null : RichText(
            text: TextSpan(
              text: widget.labelText,
              style: TextStyle(
                color: widget.labelColor ?? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: widget.requiredTxt,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]
            ),
          ),
          hintText: widget.hintText,
          prefix: widget.prefix,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          enabled: widget.enabled,
        )
      ),
    );
  }
}

