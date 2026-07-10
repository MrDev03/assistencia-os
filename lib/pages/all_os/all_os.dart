import 'dart:async';
import 'package:assistencia_os/configs/search_color.dart';
import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/badge_peca.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/msg_body_vazio.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:assistencia_os/models/options_model/options_model.dart';
import 'package:assistencia_os/pages/premium_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:isar_community/isar.dart';
import '../../custom_widgets/card_servico_status/card_servico.dart';
import '../../db_helper/db_helper.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../../models/servico_model/servico_model.dart';

class AllOs extends StatefulWidget {
  final String? callStatus;
  const AllOs({
    super.key,
    this.callStatus,
  });

  @override
  State<AllOs> createState() => _AllOsState();
}

class _AllOsState extends State<AllOs> {

  // 🌟 Agora temos apenas uma lista que recebe o resultado direto do Isar
  List<Servico> _servicosExibidos = [];

  final TextEditingController _pesquisaController = TextEditingController();
  bool _isLoading = false;
  bool checkAssinatura = false;
  String _statusSelecionado = 'todos';

  final List<String> _statusList = [
    'todos',
    'em andamento',
    'atrasado',
    'sem solução',
    'aguardando cliente',
    'entregue'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.callStatus != null) {
      _statusSelecionado = widget.callStatus!;
    }
    _carregarAssinaturaEBuscar();
    // 🌟 Listener chama a busca no banco a cada digitação
    _pesquisaController.addListener(_buscarNoIsar);
  }

  @override
  void dispose() {
    _pesquisaController.dispose();
    super.dispose();
  }

  Future<void> _carregarAssinaturaEBuscar() async {
    setState(() => _isLoading = true);

    final isar = DatabaseHelper.isar;
    final assi = await isar.subscriptionSettings.get(0);
    checkAssinatura = assi?.isPremium ?? false;

    await _buscarNoIsar();
  }

  // 🌟 Nova função que faz a query direta no Isar
  Future<void> _buscarNoIsar() async {
    final queryText = _pesquisaController.text.trim().toLowerCase();
    final isar = DatabaseHelper.isar;
    final idBusca = int.tryParse(queryText);

    setState(() => _isLoading = true);

    var resultados = await isar.servicos.filter()
        .idGreaterThan(-1)

    // 🌟 AQUI: Implementamos o seu statusEqualTo com caseSensitive: false!
        .optional(
        _statusSelecionado != 'todos',
            (q) => q.and().statusEqualTo(_statusSelecionado, caseSensitive: false)
    )

    // 2. Filtro de Texto (Mantido igual)
        .optional(
        queryText.isNotEmpty,
            (q) => q.and().group((q) {
          if (idBusca != null) {
            return q.idEqualTo(idBusca)
                .or()
                .modeloMatches('*$queryText*', caseSensitive: false)
                .or()
                .servicosMatches('*$queryText*', caseSensitive: false)
                .or()
                .nomeClienteMatches('*$queryText*', caseSensitive: false);
          } else {
            return q.modeloMatches('*$queryText*', caseSensitive: false)
                .or()
                .servicosMatches('*$queryText*', caseSensitive: false)
                .or()
                .nomeClienteMatches('*$queryText*', caseSensitive: false);
          }
        })
    )
        .findAll();

    // 3. Ordenação
    resultados.sort((a, b) {
      final dateA = parseDataServico(a.data) ?? DateTime(1970);
      final dateB = parseDataServico(b.data) ?? DateTime(1970);
      return dateB.compareTo(dateA);
    });

    // 4. Atualiza a tela
    setState(() {
      _servicosExibidos = resultados;
      _isLoading = false;
    });
  }

  // --- Funções Auxiliares de Data (Mantidas Originais) ---
  DateTime? parseDataServico(String? data) {
    if (data == null || data.isEmpty) return null;
    try {
      if (data.contains('/')) {
        final partes = data.split('•');
        final dataStr = partes[0].trim();
        final horaStr = partes.length > 1 ? partes[1].trim() : "00:00";
        final dataSplit = dataStr.split('/');
        return DateTime(
          int.parse(dataSplit[2]), // Ano
          int.parse(dataSplit[1]), // Mês
          int.parse(dataSplit[0]), // Dia
          int.parse(horaStr.split(':')[0]), // Hora
          int.parse(horaStr.split(':')[1]), // Minuto
        );
      }
      return DateTime.tryParse(data);
    } catch (e) {
      return null;
    }
  }

  String formatarData(String? data) {
    if (data == null) return '--/--/----';
    try {
      if (data.contains('/')) return data.split('•')[0].trim();
      DateTime dt = DateTime.parse(data);
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
    } catch (e) {
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchColor = context.appbarButtonColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordens de Serviço'),
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _buscarNoIsar,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- BARRA DE STATUS ---
              _buildStatusChips(),
              
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              //   decoration: BoxDecoration(
              //     borderRadius: const BorderRadius.all(Radius.circular(15)),
              //     gradient: LinearGradient(
              //       colors: [
              //         Colors.teal,
              //         Colors.teal.withValues(alpha: 0.7)
              //       ]
              //     )
              //   ),
              //   child: const Row(
              //     spacing: 10,
              //     children: [
              //       Icon(Icons.tv,
              //         color: Colors.white70,
              //       ),
              //       Expanded(
              //         child: Text(
              //           'Acompanhe os serviços diretamente pela Smart TV',
              //           maxLines: 2,
              //           softWrap: true,
              //           overflow: TextOverflow.ellipsis,
              //           style: TextStyle(color: Colors.white70),
              //         ),
              //       ),
              //       BadgeCustom(
              //         label: 'Em breve',
              //         color: Colors.white,
              //       ),
              //     ],
              //   ),
              // ),
              //
              // --- BARRA DE PESQUISA ---
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: CustomTextField(
                      backgroundColor: searchColor,
                      controller: _pesquisaController,
                      hintText: "Buscar por nome, modelo ou ID...",
                      prefixIcon: const Icon(Icons.search),
                      // O onChanged foi removido daqui pois o Listener no controller já cuida disso
                      maxLines: 1,
                      suffixIcon: Visibility(
                        visible: _pesquisaController.text.isNotEmpty,
                        child: IconButton(
                          onPressed: () {
                            _pesquisaController.clear();
                            // O listener também detecta o clear()
                          },
                          icon: const Icon(Icons.clear, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // --- CONTEÚDO PRINCIPAL ---
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _servicosExibidos.isEmpty // 🌟 Mudado para _servicosExibidos
                    ? const Vazio(label: "Nenhuma OS encontrada")
                    : LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      return _buildGridView();
                    } else if (constraints.maxWidth <= 600) {
                      return _buildListView();
                    } return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    final isar = DatabaseHelper.isar; // Pega a instância do banco
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _servicosExibidos.length, // 🌟 Mudado
          itemBuilder: (context, index) {
            final os = _servicosExibidos[index]; // 🌟 Mudado

            // 🌟 Carrega o cliente atrelado ao serviço usando o IsarLink
            // Assumindo que você tem um clienteLink.value configurado no seu model
            final cliente = os.clienteId != null
                ? isar.clientes.getSync(os.clienteId!) ?? Cliente()
                : Cliente();

            return ServicoCard(
                key: ValueKey(os.id), // 👈 importante
                os: os,
                cliente: cliente,
                checkAssinatura: checkAssinatura,
                onTap: () {
                  setState(() {
                    _buscarNoIsar();
                  });
                }
            ).animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad);
          },
        ),
      ),
    );
  }

  Widget _buildGridView() {
    final isar = DatabaseHelper.isar; // Pega a instância do banco
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisExtent: 300,
            childAspectRatio: 1.7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _servicosExibidos.length, // 🌟 Mudado
          itemBuilder: (context, index) {
            final os = _servicosExibidos[index]; // 🌟 Mudado

            // 🌟 Carrega o cliente do IsarLink
            final cliente = os.clienteId != null
                ? isar.clientes.getSync(os.clienteId!) ?? Cliente()
                : Cliente();

            return ServicoCard(
                key: ValueKey(os.id), // 👈 importante
                os: os,
                cliente: cliente,
                checkAssinatura: checkAssinatura,
                onTap: () {
                  setState(() {
                    _buscarNoIsar();
                  });
                }
            );
          },
        ),
      ),
    );
  }

  Color _getChipColor(String status) {
    switch (status) {
      case 'atrasado':
        return Colors.pink;
      case 'entregue':
        return Colors.greenAccent.shade700;
      case 'sem solução':
        return Colors.red;
      case 'aguardando cliente':
        return Colors.purple.shade700;
      case 'em andamento':
        return Colors.orange;
      default:
        return Colors.blueAccent.shade700;
    }
  }

  Widget _buildStatusChips() {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _statusList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final status = _statusList[index];

          return ChoiceChip(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            selectedShadowColor: Colors.transparent,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide(
              color: _getChipColor(status).withValues(alpha: 0.3),
              width: 1,
            ),
            backgroundColor: _getChipColor(status).withValues(alpha: 0.1),
            label: Text(status.toUpperCase()),
            selectedColor: _getChipColor(status),
            checkmarkColor: Colors.white,
            labelStyle: TextStyle(
              color: _statusSelecionado == status ? Colors.white : _getChipColor(status),
            ),
            selected: _statusSelecionado == status,
            onSelected: (_) {
              if (!checkAssinatura) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PremiumPage()
                  ),
                );
                return;
              }
              setState(() {
                _statusSelecionado = status;
              });
              // 🌟 Chama a busca direta no Isar ao trocar o status
              _buscarNoIsar();
            },
          );
        },
      ),
    );
  }
}