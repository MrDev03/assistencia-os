import 'package:flutter/material.dart';


class BrandSelectorField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Map<String, String> brandsMap; // Única fonte de dados: {'Nome': 'CaminhoLogo'}
  final Function(String) onChanged;

  const BrandSelectorField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.brandsMap,
    required this.onChanged,
  });

  @override
  State<BrandSelectorField> createState() => _BrandSelectorFieldState();
}

class _BrandSelectorFieldState extends State<BrandSelectorField> {
  String? _currentLogo;

  @override
  void initState() {
    super.initState();
    _updateLogo(widget.controller.text);
    widget.controller.addListener(() {
      _updateLogo(widget.controller.text);
    });
  }

  void _updateLogo(String text) {
    // Busca no mapa (case insensitive)
    final match = widget.brandsMap.entries.firstWhere(
          (entry) => entry.key.toLowerCase() == text.toLowerCase(),
      orElse: () => const MapEntry('', ''),
    );

    if (mounted) {
      setState(() {
        _currentLogo = match.value.isNotEmpty ? match.value : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Extraímos as chaves (Nomes das marcas) para usar no Autocomplete
    final List<String> brandOptions = widget.brandsMap.keys.toList();

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Autocomplete<String>(
            initialValue: TextEditingValue(text: widget.controller.text),

            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return brandOptions.where((String option) {
                return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
              });
            },

            onSelected: (String selection) {
              widget.controller.text = selection;
              _updateLogo(selection);
              widget.onChanged(selection);
              FocusScope.of(context).unfocus();
            },

            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).cardColor,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                      maxWidth: 250
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = options.elementAt(index);
                        // Busca a logo direto do mapa único
                        final String? logoPath = widget.brandsMap[option];

                        return ListTile(
                          visualDensity: VisualDensity.compact,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          leading: logoPath != null
                              ? Image.asset(logoPath, width: 35, height: 35)
                              : const Icon(Icons.featured_play_list, size: 24),
                          title: Text(option,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface
                            ),
                          ),
                          onTap: () {
                            onSelected(option);
                            widget.onChanged(option);
                          }
                        );
                      },
                    ),
                  ),
                ),
              );
            },

            fieldViewBuilder: (context, textController, focusNode, onEditingComplete) {
              textController.addListener(() {
                if (widget.controller.text != textController.text) {
                  widget.controller.text = textController.text;
                }
              });

              if (textController.text != widget.controller.text) {
                textController.text = widget.controller.text;
                textController.selection = TextSelection.collapsed(offset: textController.text.length);
              }

              return TextField(
                controller: textController,
                focusNode: focusNode,
                onEditingComplete: onEditingComplete,
                maxLength: 20,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  //contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  counterText: '',
                  labelText: widget.labelText,
                  //prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 0),
                  prefixIcon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _currentLogo != null
                        ? Image.asset(
                      _currentLogo!,
                      key: ValueKey(_currentLogo),
                      width: 24,
                      height: 24,
                    ) : const Icon(Icons.search, key: ValueKey('icon')),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}