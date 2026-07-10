import 'package:assistencia_os/custom_widgets/dialog.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar_community/isar.dart';
import '../../../db_helper/db_helper.dart';
import '../../../models/estoque_pecas_model/estoque_pecas_model.dart';
import '../../../custom_widgets/badge_peca.dart'; // Certifique-se de ter esse pacote

class SelecaoPecasOrcamentoScreen extends StatefulWidget {

  const SelecaoPecasOrcamentoScreen({super.key});

  @override
  State<SelecaoPecasOrcamentoScreen> createState() => _SelecaoPecasOrcamentoScreenState();
}

class _SelecaoPecasOrcamentoScreenState extends State<SelecaoPecasOrcamentoScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _termoBusca = '';
  final isar = DatabaseHelper.isar;

  // Lista de itens selecionados
  final Set<EstoquePecas> _pecasSelecionadas = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _termoBusca = _searchController.text;
      });
    });
  }

  // Helper para formatar dinheiro
  String _formatarMoeda(double? valor) {
    final formatador = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatador.format(valor ?? 0.0);
  }

  double get _valorTotal => _pecasSelecionadas.fold(0, (sum, item) => sum + (item.valorVenda ?? 0));
  double get _valorTotalCusto => _pecasSelecionadas.fold(0, (sum, item) => sum + (item.valorCusto ?? 0));

  Stream<List<EstoquePecas>> _buscarPecas() {
    if (_termoBusca.isEmpty) {
      // Se não digitar nada, você pode optar por retornar tudo ou nada.
      // Aqui estou retornando tudo ordenado por nome para facilitar.
      return isar.estoquePecas.where().sortByModelo().watch(fireImmediately: true);
    }

    return isar.estoquePecas
        .filter()
        .group((q) => q
        .modeloContains(_termoBusca, caseSensitive: false)
        .or()
        .modelosCompativeisElementContains(_termoBusca, caseSensitive: false)
        .or()
        .tipoContains(_termoBusca, caseSensitive: false)
    )
    // Opcional: só mostrar o que tem estoque
    // .and().quantidadeGreaterThan(0)
        .watch(fireImmediately: true);
  }

  // void _toggleSelecao(EstoquePecas peca) {
  //   setState(() {
  //     if (_pecasSelecionadas.contains(peca)) {
  //       _pecasSelecionadas.remove(peca);
  //     } else if (peca.modelo != _pecasSelecionadas.firstWhereOrNull((p) => p.modelo == peca.modelo)?.modelo) {
  //       _pecasSelecionadas.add(peca);
  //     }
  //   });
  // }

  void _toggleSelecao(EstoquePecas novaPeca) {
    setState(() {
      // 1. Se já estiver selecionada, apenas remove (desmarca)
      // 1. SE JÁ ESTIVER NA LISTA (Remove pelo ID)
      if (_estaSelecionada(novaPeca.id)) {
        _pecasSelecionadas.removeWhere((p) => p.id == novaPeca.id);
        return;
      }

      // 2. Se a lista estiver vazia, adiciona a primeira peça (define o modelo do orçamento)
      if (_pecasSelecionadas.isEmpty) {
        _pecasSelecionadas.add(novaPeca);
        return;
      }

      // 3. VERIFICAÇÃO DE MODELO
      // Pegamos o modelo da primeira peça selecionada como referência
      final modeloReferencia = _pecasSelecionadas.first.modelo?.toLowerCase().trim();
      final modeloNovaPeca = novaPeca.modelo?.toLowerCase().trim();

      // Se os modelos forem diferentes, bloqueia e mostra alerta
      if (modeloReferencia != modeloNovaPeca) {
        _mostrarAlertaModeloDiferente(novaPeca, _pecasSelecionadas.first.modelo ?? 'Desconhecido');
      } else {
        // Se for igual, adiciona normalmente
        _pecasSelecionadas.add(novaPeca);
      }
    });
  }

  void _mostrarAlertaModeloDiferente(EstoquePecas novaPeca, String modeloAtual) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Modelos Diferentes!',
        content:
          'Você selecionou uma peça para "$modeloAtual", mas está tentando adicionar uma peça de "${novaPeca.modelo}".\n\n'
              'Deseja limpar e trocar a lista atual e trocar para "${novaPeca.modelo}"?',
        leftButtonText: 'Cancelar',
        rightButtonText: 'Trocar',
        colorRight: Colors.red,
        onPressedLeft: () => Navigator.pop(context),
        onPressedRight: () {
          // Limpa a lista antiga e adiciona a nova peça
          setState(() {
            _pecasSelecionadas.clear();
            _pecasSelecionadas.add(novaPeca);
          });
          Navigator.pop(context); // Fecha o alerta

          AppFlushbar.info('Iniciado novo orçamento para ${novaPeca.modelo}');
        }
        // actions: [
        //   TextButton(
        //     onPressed: () => Navigator.pop(context), // Fecha e não faz nada
        //     child: const Text('Cancelar'),
        //   ),
        //   FilledButton(
        //     style: FilledButton.styleFrom(backgroundColor: Colors.red),
        //     onPressed: () {
        //
        //     },
        //     child: const Text('Limpar e Trocar'),
        //   ),
        // ],
      ),
    );
  }

  // Verifica se a peça já está na lista comparando o ID
  bool _estaSelecionada(int id) {
    return _pecasSelecionadas.any((p) => p.id == id);
  }

  void _concluirSelecao() {
    final resultado = {
      'pecas': _pecasSelecionadas.toList(),
      'total': _valorTotal,
      'totalCusto': _valorTotalCusto,
      //'modelo': _pecasSelecionadas.first.modelo,
    };
    Navigator.pop(context, resultado);
  }

  Color getCorQuantidade(int quantidade) {
    if (quantidade == 0) {
      return Colors.red;
    } else if (quantidade >= 1 && quantidade <= 2) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  Future<void> _addPeca(EstoquePecas peca) async {
    if (peca.quantidade == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Peça sem estoque.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
      return;
    }

    _toggleSelecao(peca);
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Peças'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: 'Busque por modelo (ex: iPhone 11)...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  suffixIcon: _termoBusca.isNotEmpty
                      ? IconButton(onPressed: _searchController.clear, icon: const Icon(Icons.clear))
                      : null
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // --- LISTA DE PEÇAS DISPONÍVEIS ---
          // LISTA DE RESULTADOS
          Expanded(
            child: _termoBusca.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phonelink_setup, size: 64, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text('Digite o modelo para buscar peças cadastradas no estoque.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
                : StreamBuilder<List<EstoquePecas>>(
              stream: _buscarPecas(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final pecas = snapshot.data!;
                if (pecas.isEmpty) {
                  return const Center(
                  child: Text('Modelo não encontrado no estoque.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                );
                }

                return ListView.separated(
                  itemCount: pecas.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final peca = pecas[index];
                    final isSelected = _estaSelecionada(peca.id);
                    return ListTile(
                      // Isso destaca a linha inteira se estiver selecionada
                      selected: isSelected,
                      selectedTileColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      leading: Checkbox(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        value: isSelected,
                        onChanged: (value) => _addPeca(peca),
                      ),
                      // IconButton(
                      //   icon: Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank, color: colorScheme.primary),
                      //   onPressed: () => _toggleSelecao(peca),
                      //   iconSize: 24,
                      // ),
                      title: Text(
                        peca.tipo ?? 'Peça sem nome',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(peca.modelo ?? ''),
                          SingleChildScrollView(
                            padding: const EdgeInsets.only(top: 4),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                BadgeCustom(
                                  label: '${peca.quantidade.toString()} Unid.',
                                  color: getCorQuantidade(peca.quantidade),
                                ),

                                Visibility(
                                  visible: peca.tipo == 'Módulo Frontal (Tela)',
                                  child: BadgeCustom(
                                    label: peca.aro ? 'Com Aro' : 'Sem Aro',
                                    color: peca.aro ? Colors.blueAccent : Colors.pink,
                                  ),
                                ),

                                Visibility(
                                  visible: peca.qualidadeTela != null && peca.tipo == 'Módulo Frontal (Tela)',
                                  child: BadgeCustom(label: peca.qualidadeTela ?? 'Qualidade N/A', color: Colors.purple),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        _formatarMoeda(peca.valorVenda),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      onTap: () => _addPeca(peca),
                    );
                  },
                );
              },
            ),
          ),

          // --- BARRA INFERIOR COM RESUMO E BOTÃO DE VER LISTA ---
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              //boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text('${_pecasSelecionadas.length} itens', style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                        Text(
                          _formatarMoeda(_valorTotal),
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary
                          ),
                        ),
                      ],
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _pecasSelecionadas.isNotEmpty ? _concluirSelecao : null,
                    icon: const Icon(Icons.check),
                    label: const Text('Confirmar'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}