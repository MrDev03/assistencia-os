import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomDBFF<T> extends StatefulWidget {
  final String labelText;
  final Widget? suffixIcon;
  final Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final T? initialValue;
  final String? Function(T?)? validator;
  final Function()? onTap;
  final Color? labelColor;
  final String? hintText;
  final Widget? prefixIcon;
  final bool? enabled;
  final AutovalidateMode? autovalidateMode;

  const CustomDBFF({
    super.key,
    required this.labelText,
    this.suffixIcon,
    required this.onChanged,
    required this.items,
    this.initialValue,
    this.validator,
    this.onTap,
    this.labelColor,
    this.hintText,
    this.prefixIcon,
    this.enabled,
    this.autovalidateMode,
  });

  @override
  State<CustomDBFF<T>> createState() => _CustomDBFFState<T>();
}

class _CustomDBFFState<T> extends State<CustomDBFF<T>> {
  bool _isOpen = false;

  void _toggleMenu() {
    final isEnabled = widget.enabled ?? true;
    if (!isEnabled) return;

    widget.onTap?.call();
    setState(() {
      _isOpen = !_isOpen;
    });
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isEnabled = widget.enabled ?? true;

    Color _getCorDeFundo(FormFieldState<T> field) {
      if (!isEnabled) {
        return theme.surface.withValues(alpha: 0.5); // Desativado
      }

      if (field.hasError) {
        return Colors.red.withValues(alpha: 0.2); // Com Erro
      }

      if (_isOpen) {
        return theme.primary.withValues(alpha: 0.1); // Aberto/Em Foco
      }

      // Padrão / Fechado
      return theme.surfaceContainerHighest.withValues(alpha: 0.3);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      // O FormField garante que o validator e o initialValue continuem funcionando!
      child: FormField<T>(
        initialValue: widget.initialValue,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
        builder: (FormFieldState<T> field) {

          // Encontra qual é o Widget (geralmente um Text) que o usuário selecionou
          Widget? selectedChild;
          if (field.value != null && widget.items != null) {
            try {
              selectedChild = widget.items!.firstWhere((item) => item.value == field.value).child;
            } catch (e) {
              selectedChild = null;
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. O CAMPO PRINCIPAL (BOTÃO)
              InkWell(
                onTap: _toggleMenu,
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: _getCorDeFundo(field),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: field.hasError
                          ? theme.error // Borda vermelha se der erro na validação
                          : (_isOpen
                          ? theme.primary.withValues(alpha: 0.5)
                          : Colors.white.withValues(alpha: 0.2)),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (widget.prefixIcon != null) ...[
                        widget.prefixIcon!,
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Label no estilo "Floating"
                            Text(
                              widget.labelText,
                              style: TextStyle(
                                fontSize: 12,
                                color: widget.labelColor ?? (field.hasError ? theme.error : theme.primary),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            // Valor selecionado ou Hint
                            selectedChild ??
                                Text(
                                  widget.hintText ?? 'Selecione...',
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.withValues(alpha: 0.7),
                                  ),
                                ),
                          ],
                        ),
                      ),
                      // Suffix Icon customizado ou a Setinha animada padrão
                      if (field.value != null && isEnabled)
                        IconButton(
                          style: IconButton.styleFrom(
                            foregroundColor: Colors.red,
                            shadowColor: Colors.red,
                          ),
                          onPressed: () {
                            field.didChange(null);
                            widget.onChanged?.call(null);
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.red,
                          ),
                          visualDensity: VisualDensity.compact,
                        ).animate().scale(),
                      //const SizedBox(width: 4),
                      widget.suffixIcon ??
                          AnimatedRotation(
                            turns: _isOpen ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: isEnabled
                                  ? (_isOpen ? theme.primary : Colors.grey)
                                  : Colors.grey.withValues(alpha: 0.5),
                            ),
                          ),
                    ],
                  ),
                ),
              ),

              // 2. TEXTO DE ERRO DA VALIDAÇÃO (Se houver)
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    field.errorText!,
                    style: TextStyle(
                      color: theme.error,
                      fontSize: 12,
                    ),
                  ),
                ),

              // 3. A LISTA DE OPÇÕES ANIMADA (Sanfona)
              AnimatedSize(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.topCenter,
                child: _isOpen && widget.items != null && widget.items!.isNotEmpty
                    ? Container(
                  margin: const EdgeInsets.only(top: 8),
                  constraints: const BoxConstraints(maxHeight: 260), // Evita que cresça infinitamente
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: theme.onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    itemCount: widget.items!.length,
                    itemBuilder: (context, index) {
                      final item = widget.items![index];
                      final isSelected = item.value == field.value;

                      return InkWell(
                        onTap: () {
                          field.didChange(item.value); // Atualiza o validador interno
                          if (widget.onChanged != null) {
                            widget.onChanged!(item.value); // Atualiza o seu state externo
                          }
                          _toggleMenu(); // Fecha a lista
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 10 ,10),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                // Renderiza o mesmo Widget que você passou no DropdownMenuItem (geralmente um Text)
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? theme.primary : theme.onSurface,
                                  ),
                                  child: item.child,
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: theme.primary,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ) : const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}


