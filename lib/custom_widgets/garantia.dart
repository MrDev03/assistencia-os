import 'package:assistencia_os/pages/service_registration/models/data_cadastro.dart';
import 'package:flutter/material.dart';

import 'dropdown_button_formfield.dart';

class GarantiaSelector extends StatefulWidget {
  //final TextEditingController controller;
  final String labelText;
  final Function(String) onChanged;
  final DataCadastro data;

  const GarantiaSelector({
    super.key,
    //required this.controller,
    this.labelText = 'Garantia',
    required this.onChanged,
    required this.data
  });

  @override
  State<GarantiaSelector> createState() => _GarantiaSelectorState();
}

class _GarantiaSelectorState extends State<GarantiaSelector> {
  int? _selectedValue;
  String? _selectedUnit;

  // Lista base (funciona como a "chave" de estado interno)
  final List<String> _units = ['Dias', 'Semanas', 'Meses', 'Anos'];

  // Mapa para facilitar a conversão para singular
  final Map<String, String> _singularMap = {
    'Dias': 'Dia',
    'Semanas': 'Semana',
    'Meses': 'Mês',
    'Anos': 'Ano',
  };

  @override
  void initState() {
    super.initState();
    _parseInitialValue();
  }

  // Tenta ler o valor atual do controller (ex: "1 Mês" ou "3 Meses")
  void _parseInitialValue() {
    if (widget.data.garantia.isEmpty) return;

    try {
      final parts = widget.data.garantia.split(' ');
      if (parts.length >= 2) {
        setState(() {
          _selectedValue = int.tryParse(parts[0]);

          String unitText = parts[1].toLowerCase();

          // Busca de forma mais segura qual é a unidade correspondente
          if (unitText.contains('dia')) {
            _selectedUnit = 'Dias';
          } else if (unitText.contains('semana')) {
            _selectedUnit = 'Semanas';
          } else if (unitText.contains('mês') || unitText.contains('mes')) {
            _selectedUnit = 'Meses';
          } else if (unitText.contains('ano')) {
            _selectedUnit = 'Anos';
          } else {
            _selectedUnit = 'Meses'; // Fallback
          }
        });
      }
    } catch (e) {
      _selectedValue = null;
      _selectedUnit = null;
    }
  }

  void _updateController() {
    if (_selectedValue != null && _selectedUnit != null) {
      // Pega o nome no singular se o valor for 1, senão usa a chave base (plural)
      String unitFinal = _selectedValue == 1
          ? _singularMap[_selectedUnit!]!
          : _selectedUnit!;

      //widget.controller.text = ;
      widget.onChanged("$_selectedValue $unitFinal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Garantia:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- DROPDOWN NÚMEROS (1 a 100) ---
              Expanded(
                flex: 1,
                child: CustomDBFF<int>(
                  labelText: 'Prazo',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  //menuMaxHeight: 300,
                  initialValue: _selectedValue,
                  items: List.generate(100, (index) => index + 1).map((number) {
                    return DropdownMenuItem(
                      value: number,
                      child: Text(number.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                      _updateController();
                    });
                  },
                  // ✅ VALIDAÇÃO DO NÚMERO
                  validator: (value) {
                    if (value == null && _selectedUnit != null) {
                      return 'Informe o prazo'; // Erro se tem unidade mas não tem número
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(width: 10),

              // --- DROPDOWN UNIDADES ---
              Expanded(
                flex: 2,
                child: CustomDBFF<String>(
                  labelText: 'Período',
                  // 🟢 O SEGREDO AQUI: A chave reage à mudança do número
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _selectedUnit,
                  items: _units.map((unit) {
                    // Dinamicamente escolhe o texto que será exibido no Dropdown
                    String displayLabel = _selectedValue == 1
                        ? _singularMap[unit]!
                        : unit;

                    return DropdownMenuItem(
                      value: unit, // O "value" continua plural para manter o controle de estado
                      child: Text(displayLabel),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedUnit = value;
                      _updateController();
                      //print(widget.controller.text);
                    });
                  },
                  // ✅ VALIDAÇÃO DA UNIDADE
                  validator: (value) {
                    if (value == null && _selectedValue != null) {
                      return 'Informe o período'; // Erro se tem número mas não tem unidade
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}