
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String content;
  final Function()? onPressedLeft;
  final Function()? onPressedRight;
  final String leftButtonText;
  final String rightButtonText;
  final Color? colorRight;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressedLeft,
    required this.onPressedRight,
    this.leftButtonText = '',
    required this.rightButtonText,
    this.colorRight,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        backgroundColor: theme.surface,
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(
            maxWidth: 300
          ),
          decoration: BoxDecoration(
            // border: Border.all(
            //   color: theme.primary,
            //   width: 2,
            // ),
            color: theme.surface.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Flexible(
                child: SingleChildScrollView(
                  child: Text(widget.content,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.leftButtonText != '')
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ElevatedButton(
                        onPressed: widget.onPressedLeft,
                        style: TextButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.grey.withValues(alpha: 0.6),
                        ),
                        child: Text(widget.leftButtonText,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: widget.colorRight ?? theme.primary,
                        ),
                        onPressed: widget.onPressedRight,
                        child: Text(widget.rightButtonText,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ).animate().scale(duration: 200.ms),
    );
  }
}


class CustomDialog2 {
  /// Exibe um Dialog animado e customizável.
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? description, // Use para textos simples
    Widget? content,     // Use para passar formulários, imagens, listas, etc.
    String confirmText = 'OK',
    String? cancelText,  // Se preenchido, o dialog se torna interativo (2 botões)
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    IconData? icon,
    bool isDestructive = false, // Se true, o botão de confirmar fica vermelho
    ValueNotifier<bool>? validar,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true, // Permite fechar clicando fora
      barrierLabel: 'Fechar',
      barrierColor: Colors.black.withValues(alpha: 0.4), // Fundo escurecido
      transitionDuration: const Duration(milliseconds: 350),

      // 🟢 A MÁGICA DA ANIMAÇÃO ESTILO iOS / ONE UI
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Efeito de mola: ele cresce um pouquinho além de 100% e volta
        final curvedValue = Curves.easeOutBack.transform(animation.value);
        return Transform.scale(
          scale: curvedValue,
          child: Opacity(
            opacity: animation.value,
            // Opcional: Adiciona um blur no fundo de toda a tela enquanto o dialog está aberto
            child: child,
          ),
        );
      },

      pageBuilder: (context, animation, secondaryAnimation) {
        final theme = Theme.of(context).colorScheme;
        final bool isInteractive = cancelText != null;

        return Dialog(
          backgroundColor: Colors.transparent, // Transparente para o Container desenhar a UI
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(
              maxWidth: 320
            ),
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: theme.outlineVariant.withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- ÍCONE OPCIONAL ---
                if (icon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDestructive
                          ? theme.error.withValues(alpha: 0.1)
                          : theme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 32,
                      color: isDestructive ? theme.error : theme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // --- TÍTULO ---
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),

                // --- CORPO (TEXTO OU WIDGET) ---
                if (content != null)
                  content
                else if (description != null)
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: theme.onSurfaceVariant,
                    ),
                  ),

                const SizedBox(height: 32),

                // --- BOTÕES (1 ou 2) ---
                Row(
                  children: [
                    // Botão Cancelar (Só aparece se o cancelText for passado)
                    if (isInteractive) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (onCancel != null) {
                              onCancel();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            side: BorderSide(
                              color: theme.outlineVariant,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            cancelText,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: theme.onSurface,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],

                    // Botão Confirmar (Aparece sempre, e pode ocupar 100% da largura se estiver sozinho)
                    Expanded(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: validar ?? ValueNotifier<bool>(true),
                        builder: (context, value, child) {
                          return FilledButton(
                            onPressed: value == false ? null : () {
                              // primeiro
                              if (onConfirm != null) {
                                onConfirm();
                              } else {
                                Navigator.pop(context); // Fecha o modal
                              }
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: isDestructive ? theme.error : theme.primary,
                              foregroundColor: isDestructive ? theme.onError : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              confirmText,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
