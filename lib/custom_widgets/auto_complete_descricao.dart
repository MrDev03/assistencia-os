import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import '../models/estoque_pecas_model/estoque_pecas_model.dart';
import '../pages/listas.dart';

class AutoCompleteDescricao extends StatelessWidget {
  final TextEditingController tipoController;
  final TextEditingController descricaoController;
  final String? Function(String?)? validator;

  const AutoCompleteDescricao({
    required this.tipoController,
    required this.descricaoController,
    this.validator,
    super.key,
  });


  String removerAcentos(String str) {
    var comAcento = 'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ';
    var semAcento = 'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN';

    for (int i = 0; i < comAcento.length; i++) {
      str = str.replaceAll(comAcento[i], semAcento[i]);
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<TipoPecaDefinition>(
      initialValue: TextEditingValue(
        text: tipoController.text,
        selection: TextSelection.collapsed(offset: tipoController.text.length),
      ),
      // 1. Como transformar o Objeto em Texto para o input? (Só queremos o nome)
      displayStringForOption: (TipoPecaDefinition option) => option.nome,

      // 2. Lógica de Busca (Procura no nome OU na descrição)
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<TipoPecaDefinition>.empty();
        }

        // 1. Limpa o que o usuário digitou (remove acentos e põe em minúsculo)
        final inputLimpo = removerAcentos(textEditingValue.text.toLowerCase());

        return tiposDePecaLista.where((TipoPecaDefinition option) {
          // 2. Limpa o nome da opção da lista
          final nomeOpcaoLimpo = removerAcentos(option.nome.toLowerCase());

          // 3. Compara as versões limpas
          // Assim, "modulo" encontra "Módulo" e "câmera" encontra "Camera"
          return nomeOpcaoLimpo.contains(inputLimpo);
        });
      },

      // 3. Ao selecionar, salvamos o NOME no controller para enviar pro banco
      onSelected: (TipoPecaDefinition selection) {
        tipoController.text = selection.nome;
      },

      // 4. O Campo de Texto (Design System mantido)
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        // Sincronia reversa: Se o usuário editar, atualizamos o controller principal
        textEditingController.addListener(() {
          tipoController.text = textEditingController.text;
        });

        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            validator: validator,
            onFieldSubmitted: (String value) => onFieldSubmitted(),
            decoration: const InputDecoration(
              labelText: 'Tipo/Categoria',
              hintText: 'Ex: Módulo Frontal (Tela), Camera...',
              //prefixIcon: const Icon(Icons.category_outlined, size: 20),
            ),
          ),
        );
      },

      // 5. PERSONALIZAÇÃO DA LISTA (Aqui mostramos Nome + Descrição)
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.surface, // Cor de fundo do dropdown
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250, maxWidth: 320),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
                itemBuilder: (BuildContext context, int index) {
                  final TipoPecaDefinition option = options.elementAt(index);

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    // Título (Nome da Peça)
                    title: Text(
                      option.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Subtítulo (Descrição útil)
                    subtitle: Text(
                      option.descricao,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                    onTap: () {
                      onSelected(option);
                      descricaoController.text = option.descricao;
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}


// =======================//===========================

// 1. Classe auxiliar para guardar o resumo do modelo
class ResumoModelo {
  final String nomeModelo;
  final Map<String, int> pecasEstoque; // Ex: {"Tela": 2, "Bateria": 5}

  ResumoModelo({required this.nomeModelo, required this.pecasEstoque});

  // Gera uma string bonita tipo: "Tela (2), Bateria (5)"
  String get resumoTexto {
    if (pecasEstoque.isEmpty) return "Sem peças cadastradas";
    return pecasEstoque.entries
        .map((e) => "${e.key} (${e.value})")
        .join(', ');
  }
}

class ModeloAutoCompleteField extends StatefulWidget {
  final Isar isar;
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const ModeloAutoCompleteField({
    super.key,
    required this.isar,
    required this.controller,
    this.validator,
    this.label = 'Modelo do Aparelho',
  });

  @override
  State<ModeloAutoCompleteField> createState() => _ModeloAutoCompleteFieldState();
}

class _ModeloAutoCompleteFieldState extends State<ModeloAutoCompleteField> {
  List<ResumoModelo> _listaResumida = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarResumoEstoque();
  }

  Future<void> _carregarResumoEstoque() async {
    // Busca todas as peças
    final todasPecas = await widget.isar.estoquePecas.where().findAll();

    // MAPA TEMPORÁRIO: Map<NomeModelo, Map<TipoPeca, Quantidade>>
    final Map<String, Map<String, int>> agrupamento = {};

    for (var peca in todasPecas) {
      // Normaliza o nome (remove espaços e poe primeira letra maiuscula se quiser)
      final modelo = (peca.modelo ?? '').trim();
      final tipo = peca.tipo ?? 'Outros';
      final qtd = peca.quantidade; // Ou conte 1 se for por unidade única

      if (modelo.isEmpty) continue;

      // Se o modelo ainda não existe no mapa, cria
      if (!agrupamento.containsKey(modelo)) {
        agrupamento[modelo] = {};
      }

      // Soma a quantidade naquele tipo
      final mapTipos = agrupamento[modelo]!;
      if (mapTipos.containsKey(tipo)) {
        mapTipos[tipo] = mapTipos[tipo]! + qtd; // Soma estoque
      } else {
        mapTipos[tipo] = qtd;
      }
    }

    // Converte o Mapa para nossa Lista de Objetos
    final listaFinal = agrupamento.entries.map((entry) {
      return ResumoModelo(
        nomeModelo: entry.key,
        pecasEstoque: entry.value,
      );
    }).toList();

    // Ordena alfabeticamente
    listaFinal.sort((a, b) => a.nomeModelo.toLowerCase().compareTo(b.nomeModelo.toLowerCase()));

    if (mounted) {
      setState(() {
        _listaResumida = listaFinal;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: const Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(strokeWidth: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      // Mudamos de String para ResumoModelo
      return Autocomplete<ResumoModelo>(

        // A. Define qual texto mostrar no input quando selecionado
        displayStringForOption: (ResumoModelo option) => option.nomeModelo,

        // B. Filtro
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<ResumoModelo>.empty();
          }
          return _listaResumida.where((ResumoModelo option) {
            return option.nomeModelo.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
        },

        // C. Seleção (Preenche o campo e não faz mais nada)
        onSelected: (ResumoModelo selection) {
          widget.controller.text = selection.nomeModelo;
        },

        // D. Campo de Texto (Mantive o seu design)
        fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
          // Sincronia inicial se vier preenchido de fora
          if (widget.controller.text.isNotEmpty && textController.text.isEmpty) {
            textController.text = widget.controller.text;
          }

          textController.addListener(() {
            widget.controller.text = textController.text;
          });

          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextFormField(
              controller: textController,
              focusNode: focusNode,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: widget.label,
                hintText: 'Digite para ver o estoque...',
                //prefixIcon: const Icon(Icons.manage_search),
              ),
              onFieldSubmitted: (_) => onFieldSubmitted(),
              validator: widget.validator,
            ),
          );
        },

        // E. O Visual da Lista (A Mágica acontece aqui)
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surface,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 300, // Altura maior para caber os detalhes
                  maxWidth: constraints.maxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          'Cadastrados no sistema',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey[200]),
                        itemBuilder: (BuildContext context, int index) {
                          final ResumoModelo option = options.elementAt(index);

                          return ListTile(
                            // Título: O Modelo
                            title: Text(
                                option.nomeModelo,
                                style: const TextStyle(fontWeight: FontWeight.bold)
                            ),

                            // Subtítulo: O Estoque Formatado
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: option.pecasEstoque.entries.map((e) {
                                  // Cria um "Chip" visual simples para cada peça
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: e.value > 0
                                          ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5)
                                          : Colors.grey[200], // Cinza se for 0
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "${e.key}: ${e.value}", // Ex: Tela: 2
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            // Ação: Ao clicar, apenas preenche o texto
                            onTap: () => onSelected(option),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
