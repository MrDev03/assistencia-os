import 'dart:io';

import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:assistencia_os/db_helper/cargo_helper.dart';
import 'package:assistencia_os/db_helper/premium_helper.dart';
import 'package:assistencia_os/pages/premium_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import '../../configs/search_color.dart';
import '../../custom_widgets/card.dart';
import '../../custom_widgets/lateral_iconbutom.dart';
import '../../db_helper/db_helper.dart';
import '../../models/estoque_pecas_model/estoque_pecas_model.dart';
import '../../custom_widgets/badge_peca.dart';
import 'components/build_image_peca.dart';
import 'components/codigo_barras_scanner.dart';
import 'detalhes_peca.dart';
import 'nova_peca.dart';

// Se tiver aquele arquivo de constantes, importe aqui.
// Caso contrário, defino uma lista simples para o filtro.
const List<String> _opcoesTipos = [
  'Módulo Frontal',
  'Bateria',
  'Conector de Carga',
  'Tampa Traseira',
  'Câmera',
  'Outros'
];

class PecasListScreen extends StatefulWidget {

  const PecasListScreen({super.key});

  @override
  State<PecasListScreen> createState() => _PecasListScreenState();
}

class _PecasListScreenState extends State<PecasListScreen> {
  final Isar isar = DatabaseHelper.isar;
  final TextEditingController _searchController = TextEditingController();
  String? cargo;
  bool _isPremium = false;

  // --- ESTADO DOS FILTROS ---
  String _termoBusca = '';
  String? _filtroTipo;      // Null = Todos
  bool? _filtroUsada;       // Null = Todos, true = Usada, false = Nova
  bool _apenasComEstoque = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _termoBusca = _searchController.text;
      });
    });
    // O listener atualiza a tela a cada letra digitada
    _carregarDados();
  }

  void _carregarDados() async {
    var cargoSalvo = await CargoHelper.lerCargo();
    var premiumSalvo = await PremiumHelper.lerPremium();

    if (cargoSalvo != null) {
      setState(() {
        cargo = cargoSalvo;
        _isPremium = premiumSalvo;
        //_searchController.addListener(() => _termoBusca = _searchController.text);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // --- LÓGICA DO STREAM (Busca + Filtros + Ordenação) ---
  Stream<List<EstoquePecas>> _gerarStream() {
    return isar.estoquePecas.filter()
    // 1. Filtro de Texto (Busca)
        .optional(_termoBusca.isNotEmpty, (q) => q.group((j) => j
        .modeloContains(_termoBusca, caseSensitive: false)
        .or()
        .barCodeContains(_termoBusca, caseSensitive: false)
        .or()
        .marcaContains(_termoBusca, caseSensitive: false)
    ))

    // 2. Filtro de Tipo
        .optional(_filtroTipo != null, (q) => q.tipoContains(_filtroTipo!, caseSensitive: false))

    // 3. Filtro de Condição (Nova/Usada)
        .optional(_filtroUsada != null, (q) => q.usadaEqualTo(_filtroUsada!))

    // 4. Filtro de Estoque
        .optional(_apenasComEstoque, (q) => q.quantidadeGreaterThan(0))

    // 5. Ordenação e Watch
        .sortByDataCadastroDesc()
        .watch(fireImmediately: true);
  }
  // --- UI DO MODAL DE FILTROS ---
  void _abrirFiltros() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite que o modal cresça se necessário
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        // StatefulBuilder permite atualizar o estado DENTRO do modal (os chips mudarem de cor)
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final theme = Theme.of(context);
            return Padding(
              padding: EdgeInsets.only(
                  top: 24,
                  left: 24,
                  right: 24,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filtrar Estoque', style: theme.textTheme.titleLarge),
                      TextButton(
                        onPressed: () {
                          // Limpar Filtros
                          setState(() {
                            _filtroTipo = null;
                            _filtroUsada = null;
                            _apenasComEstoque = false;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Limpar'),
                      )
                    ],
                  ),
                  const Divider(),

                  // --- Filtro: Em Estoque ---
                  SwitchListTile(
                    title: const Text('Apenas com Estoque (>0)'),
                    value: _apenasComEstoque,
                    onChanged: (val) => setModalState(() => _apenasComEstoque = val),
                    contentPadding: EdgeInsets.zero,
                  ),

                  const SizedBox(height: 10),
                  const Text('Condição:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      FilterChip(
                        label: const Text('Nova'),
                        selected: _filtroUsada == false,
                        onSelected: (selected) => setModalState(() => _filtroUsada = selected ? false : null),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Usada'),
                        selected: _filtroUsada == true,
                        onSelected: (selected) => setModalState(() => _filtroUsada = selected ? true : null),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Text('Tipo de Peça:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: _opcoesTipos.map((tipo) {
                      return ChoiceChip(
                        label: Text(tipo),
                        selected: _filtroTipo == tipo,
                        onSelected: (selected) {
                          setModalState(() => _filtroTipo = selected ? tipo : null);
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        setState(() {}); // Aplica os filtros na tela principal
                        Navigator.pop(context);
                      },
                      child: const Text('Aplicar Filtros'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // --- Ícone de Filtro Ativo (Bolinha vermelha se tiver filtro) ---
  bool get _temFiltroAtivo => _filtroTipo != null || _filtroUsada != null || _apenasComEstoque;

  // Lógica para alternar entre "Tudo" e "Pesquisa"


  @override
  Widget build(BuildContext context) {

    final searchColor = context.appbarButtonColor;

    return Scaffold(
      appBar: AppBar(
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
          icon: Icons.arrow_back_ios_new,
        ),
        title: const Text('Estoque de Peças'),
        actions: [
          // Botão de Filtro na AppBar
          Stack(
            alignment: Alignment.topRight,
            children: [
              AppbarBtn(
                icon:
                  _temFiltroAtivo ? Icons.filter_list_alt : Icons.filter_list,
                  //color: Theme.of(context).colorScheme.onPrimaryContainer,
                onPressed: _abrirFiltros,
                tooltip: 'Filtrar',
              ),
              if (_temFiltroAtivo)
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                )
            ],
          ),
          //const SizedBox(width: 8),
        ]
      ),

      body: Column(
        children: [

          // --- CAMPO DE PESQUISA ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Pesquisar modelo ou código...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _termoBusca.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          FocusScope.of(context).unfocus(); // Fecha o teclado
                        },
                      )
                          : null, // Pode adicionar botão de scanner aqui se quiser
                      filled: true,
                      fillColor: searchColor, //Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                LateralIconbutom(
                  icon: const Icon(CupertinoIcons.barcode_viewfinder), // Ícone de mira/scan
                  tooltip: 'Ler Código de Barras',
                  onPressed: _lerCodigoBarras, // Chama a função criada acima
                ),
              ],
            ),
          ),

          // --- BARRA DE FILTROS ATIVOS (Feedback Visual) ---
          if (_temFiltroAtivo)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_apenasComEstoque) _buildFilterChipDisplay('Com Estoque'),
                  if (_filtroUsada != null) _buildFilterChipDisplay(_filtroUsada! ? 'Usada' : 'Nova'),
                  if (_filtroTipo != null) _buildFilterChipDisplay(_filtroTipo!),
                  TextButton(
                      onPressed: () => setState(() {
                        _filtroTipo = null;
                        _filtroUsada = null;
                        _apenasComEstoque = false;
                      }),
                      child: const Text('Limpar', style: TextStyle(fontSize: 12))
                  )
                ],
              ),
            ),

          // --- LISTA (STREAM BUILDER) ---
          Expanded(
            child: StreamBuilder<List<EstoquePecas>>(
              stream: _gerarStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar: ${snapshot.error}'));
                }

                final pecas = snapshot.data;

                if (pecas == null || pecas.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(_searchController.text != '' ? 'Nenhuma peça encontrada.' : 'Nenhuma peça cadastrada.', style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }


                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      children: [
                        //_buildResumoEstoque(pecas),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 80), // Espaço para o FAB
                            itemCount: pecas.length,
                            itemBuilder: (context, index) {
                              final peca = pecas[index];
                              return _buildPecaCard(context, peca);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // No arquivo pecas_list_screen.dart
      floatingActionButton: StreamBuilder(
        stream: _gerarStream(),
        builder: (context, snapshot) {
          final pecas = snapshot.data;
          int contadorPecas = pecas?.length ?? 0;
          int max5 = contadorPecas >= 5 ? 5 : contadorPecas;

          bool limitePecasAtingido() {
            return !_isPremium && contadorPecas >= 5; // se o usuario não for premium e tiver mais de 5 peças cadastradas
          }

          return Badge(
            isLabelVisible: limitePecasAtingido(),
            backgroundColor: Colors.transparent,
            label: const Icon(Icons.lock,
              color: Colors.grey,
              size: 15
            ),
            child: FloatingActionButton.extended(
              onPressed: () {
                if (limitePecasAtingido()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PremiumPage()),
                  );
                  return;
                }
                if (cargo != 'admin') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Somente administradores podem adicionar peças.'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    ),
                  );
                  return;
                }
                // Atualize esta parte:
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PecaFormScreen(isar: isar))
                );
              },
              label: Text(_isPremium ? 'Nova Peça' : 'Nova Peça ${max5.toString()}/5'),
              icon: !limitePecasAtingido() ? const Icon(Icons.add, color: Colors.white,
              ) : const Icon(RemixIcon.vipCrownLine, color: Colors.yellow, size: 18),
            ),
          );
        }
      ),
    );
  }

  Future<void> _lerCodigoBarras() async {

    if (Platform.isWindows) {
      AppFlushbar.error('Indisponível no momento');
      return;
    }

    // Navega para a tela de scanner e aguarda o resultado (String?)
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const ScannerScreen(),
      ),
    );

    // Se o usuário voltou sem escanear, result será null.
    // Se escaneou, result será o código.
    if (result != null && mounted) {
      setState(() {
        _searchController.text = result;
      });

      // Feedback visual (opcional)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Código lido: $result'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  // Widget pequeno para mostrar o que está filtrado na tela principal
  Widget _buildFilterChipDisplay(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        side: BorderSide.none,
        label: Text(label, style: const TextStyle(fontSize: 11)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildPecaCard(BuildContext context, EstoquePecas peca) {
    return CustomCard(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        //contentPadding: const EdgeInsets.all(10),
        leading: Hero(
          tag: peca.id,
          child: Container(
            width: 55,
            height: 55,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: BuildImagePeca(
              caminhoLocal: peca.fotosLocal.isNotEmpty ? peca.fotosLocal[0] : null,
              url: peca.fotosUrl.isNotEmpty ? peca.fotosUrl[0] : null,
            ),
          ),
        ),
        title: Text(
          peca.modelo ?? "Modelo N/A",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(peca.tipo ?? "Tipo N/A"),
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // BadgePeca(
                  //   label: peca.usada ? 'Usada' : 'Nova',
                  //   color: peca.usada ? Colors.orangeAccent : Colors.green,
                  // ),
                  Visibility(
                    visible: peca.tipo == 'Módulo Frontal (Tela)',
                    child: BadgeCustom(label: peca.aro ? 'Com Aro' : 'Sem Aro', color: peca.aro ? Colors.blueAccent : Colors.teal),
                  ),
                  Visibility(
                    visible: peca.qualidadeTela != null && peca.tipo == 'Módulo Frontal (Tela)',
                    child: BadgeCustom(label: peca.qualidadeTela?.toUpperCase() ?? 'Qualidade N/A', color: Colors.purple),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${peca.quantidade}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const Text('unid.', style: TextStyle(fontSize: 10)),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PecaDetalhesScreen(
                isar: isar,
                pecaId: peca.id, // Passamos o ID
                cargoAtual: cargo ?? 'admin',
              ),
            ),
          );
        },
      ),
    );
  }

  //Widget Resumo

  // Widget _buildResumoEstoque(List<EstoquePecas> pecas) {
  //   // 1. Calcula a soma total de itens físicos (Soma do campo quantidade)
  //   int totalItensFisicos = pecas.fold(0, (sum, item) => sum + item.quantidade);
  //
  //   // 2. Calcula quantos modelos diferentes existem (Quantidade de registros)
  //   int totalModelos = pecas.length;
  //
  //   // 3. (Bônus) Calcula o valor total do estoque (Custo * Quantidade)
  //   double valorTotalEstoque = pecas.fold(0, (sum, item) {
  //     return sum + ((item.valorCusto ?? 0) * item.quantidade);
  //   });
  //
  //   // Formata o dinheiro (se tiver o pacote intl configurado)
  //   // final currency = NumberFormat.simpleCurrency(locale: 'pt_BR');
  //   // String valorFormatado = currency.format(valorTotalEstoque);
  //   String valorFormatado = 'R\$ ${valorTotalEstoque.toStringAsFixed(2)}';
  //
  //   return Card(
  //     margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(16),
  //         gradient: LinearGradient(
  //           colors: [
  //             Theme.of(context).colorScheme.primary,
  //             Theme.of(context).colorScheme.tertiary,
  //           ],
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //         ),
  //       ),
  //       child: Column(
  //         children: [
  //           const Text(
  //             'Visão Geral do Estoque',
  //             style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 10),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               _buildInfoItem('Peças Físicas', '$totalItensFisicos', Icons.widgets),
  //               Container(width: 1, height: 40, color: Colors.white24),
  //               _buildInfoItem('Modelos', '$totalModelos', Icons.list_alt),
  //               Container(width: 1, height: 40, color: Colors.white24),
  //               _buildInfoItem('Valor Total', valorFormatado, Icons.attach_money),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildInfoItem(String label, String value, IconData icon) {
  //   return Column(
  //     children: [
  //       Icon(icon, color: Colors.white70, size: 20),
  //       const SizedBox(height: 4),
  //       Text(
  //         value,
  //         style: const TextStyle(
  //             color: Colors.white,
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold
  //         ),
  //       ),
  //       Text(
  //         label,
  //         style: const TextStyle(color: Colors.white70, fontSize: 10),
  //       ),
  //     ],
  //   );
  // }

}