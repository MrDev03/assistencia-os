import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'lateral_iconbutom.dart';

class SG extends StatefulWidget {

  final List<String> sugestoes;
  final List<String> selecionados;
  final Function()? onAdd;
  final String labelText;
  final String hintText;
  final String? initialValue;
  final String? Function(List<String>?)? validator;
  final String? requiredTxt;
  final AutovalidateMode? autovalidateMode;

  const SG({
    super.key,
    required this.sugestoes,
    required this.selecionados,
    required this.labelText,
    required this.hintText,
    this.onAdd,
    this.validator,
    this.initialValue,
    this.requiredTxt,
    this.autovalidateMode,
  });

  @override
  State<SG> createState() => _SGState();
}

class _SGState extends State<SG> {

  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Função para adicionar à lista
  void _adicionarModelo(FormFieldState<List<String>> state) {
    final texto = controller.text.trim();
    if (texto.isNotEmpty && !widget.selecionados.contains(texto)) {
      widget.selecionados.add(texto);
      controller.clear(); // Limpa o campo após adicionar
      // AVISA O FORM QUE MUDOU (Para limpar o erro se tiver)
      state.didChange(widget.selecionados);
      widget.onAdd?.call();
      // setState(() {
      //
      // });
    }
    // if (widget.selecionados.contains(texto)) {
    //   AppFlushbar.error("Modelo já adicionado!");
    // }
  }

// Função para remover da lista
  void _removerModelo(String modelo, FormFieldState<List<String>> state) {
    widget.selecionados.remove(modelo);
    // AVISA O FORM QUE MUDOU (Para limpar o erro se tiver)
    state.didChange(widget.selecionados);
    widget.onAdd?.call();
    // setState(() {
    //
    // });
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: FormField<List<String>>(
        initialValue: widget.selecionados,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
        builder: (FormFieldState<List<String>> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //_buildSectionTitle(theme, 'Modelos Compatíveis'),

              // 1. O Campo de Input com Autocomplete
              // LayoutBuilder garante que o dropdown tenha a largura correta
              LayoutBuilder(
                  builder: (context, constraints) {
                    return Autocomplete<String>(
                      // A. Lógica de Filtro
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return widget.sugestoes.where((String option) {
                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                        });
                      },

                      // B. O que acontece ao clicar na sugestão
                      onSelected: (String selection) {
                        // Atualiza o texto e chama a função de adicionar
                        controller.text = selection;
                        _adicionarModelo(state);
                      },

                      // C. O Campo de Texto (Seu CustomTextField)
                      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {

                        // Sincroniza o controller do Autocomplete com o seu controller manual
                        // para garantir que o botão "Add" funcione
                        textEditingController.addListener(() {
                          if (controller.text != textEditingController.text) {
                            controller.text = textEditingController.text;
                          }
                          // if (widget.sugestoes.contains(textEditingController.text)) {
                          //   controller.clear();
                          // }
                        });

                        return Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textEditingController, // Usa o controller do Autocomplete
                                focusNode: focusNode, // Usa o focusNode do Autocomplete
                                decoration: InputDecoration(
                                  label: RichText(
                                    text: TextSpan(
                                        text: widget.labelText,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                                          fontSize: 15,
                                        ),
                                        children: [
                                          if (widget.requiredTxt != null)
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
                                  suffixIcon: textEditingController.text.isNotEmpty ? IconButton(
                                    onPressed: () {
                                      textEditingController.clear();
                                    },
                                    icon: const Icon(Icons.close,
                                      color: Colors.red,
                                    ),
                                  ) : null,
                                ),
                                onFieldSubmitted: (_) {
                                  onFieldSubmitted(); // Fecha o menu
                                  _adicionarModelo(state); // Adiciona o chip
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Botão de Adicionar (Reativo)
                            ValueListenableBuilder(
                                valueListenable: textEditingController,
                                builder: (context, value, child) {
                                  //final texto = controller.text.trim();
                                  // bool valid () {
                                  //   if (texto.isNotEmpty && widget.selecionados.contains(texto)) return true;
                                  //   return false;
                                  // }
                                  return LateralIconbutom(
                                    onPressed: value.text.isNotEmpty
                                        ? () {
                                      // Adiciona e limpa o campo do autocomplete
                                      _adicionarModelo(state);
                                      textEditingController.clear();
                                    } : null,
                                    backgroundColor: theme.primary,
                                    foregroundColor: Colors.white,
                                    icon: const Icon(
                                      Icons.add
                                    ),
                                    tooltip: '+ Adicionar',
                                  );
                                }
                            ),
                          ],
                        );
                      },

                      // D. Design do Dropdown de Sugestões
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(16),
                            color: theme.surface, // Cor de fundo do dropdown
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight: 200,
                                  maxWidth: constraints.maxWidth - 60 // Ajusta largura (subtrai o botão add)
                              ),
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: options.length,
                                separatorBuilder: (_,__) => Divider(height: 1, color: theme.outlineVariant.withValues(alpha: 0.5)),
                                itemBuilder: (BuildContext context, int index) {
                                  final String option = options.elementAt(index);
                                  return ListTile(
                                    title: Text(option),
                                    onTap: () {
                                      onSelected(option);
                                      controller.clear();
                                      FocusScope.of(context).unfocus();
                                    },
                                    visualDensity: VisualDensity.compact,
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
              ),

              // 2. A Área de Chips (Mantida igual)
              //if (widget.selecionados.isNotEmpty)

              Visibility(
                visible: widget.selecionados.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: widget.selecionados.map((modelo) {
                      return Animate(
                        effects: const [
                          ScaleEffect()
                        ],
                        child: InputChip(
                          elevation: 0,
                          label: Text(modelo),
                          labelStyle: TextStyle(
                            color: theme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          backgroundColor: theme.primaryContainer.withValues(alpha: 0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide.none,
                          ),
                          side: BorderSide.none,
                          deleteIcon: Icon(Icons.close, size: 16, color: theme.onPrimaryContainer),
                          onDeleted: () => _removerModelo(modelo, state),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // else
              //   Padding(
              //     padding: const EdgeInsets.only(left: 4.0),
              //     child: Text(
              //       'Nenhum modelo adicionado.',
              //       style: TextStyle(color: theme.outline, fontSize: 12),
              //     ),
              //   ),
              // --- EXIBIÇÃO DO ERRO ---

              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only( left: 12.0),
                  child: Text(
                    state.errorText ?? "",
                    style: TextStyle(
                      color: theme.error,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          );
        }
      ),
    );
  }
}
