import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/dialog.dart';
import 'package:assistencia_os/custom_widgets/info_card.dart';
import 'package:assistencia_os/custom_widgets/pattern_preview.dart';
import 'package:assistencia_os/db_helper/cargo_helper.dart';
import 'package:assistencia_os/sync/modules/servico_sync.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import '../../custom_widgets/loading_widget.dart';
import '../../custom_widgets/pagamentos/pagamento_check_list.dart';
import '../../custom_widgets/top_msg.dart';
import '../../db_helper/db_helper.dart';
import '../../db_helper/premium_helper.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../../models/empresa_model/empresa_model.dart';
import '../../models/servico_model/servico_model.dart';
import '../../services/pdf_services.dart';
import '../../sync/firebase/firebase_writer.dart';
import '../home/home.dart';
import '../listas.dart';
import '../premium_page.dart';

class ItemAcessorio {
  final String nome;
  final String valor;

  ItemAcessorio({
    required this.nome,
    required this.valor,
  });
}

class DetalhesServicoPage extends StatefulWidget {
  final Servico servico;
  final Cliente cliente;
  final Empresa? empresa;

  const DetalhesServicoPage({
    super.key,
    required this.servico,
    required this.cliente,
    this.empresa,
  });

  @override
  State<DetalhesServicoPage> createState() => _DetalhesServicoPageState();
}

class _DetalhesServicoPageState extends State<DetalhesServicoPage> {
  //Empresa? empresa;
  String? cargoAtual;
  bool checkAssinatura = false;
  final PdfServices pdfServices = PdfServices();
  final syncServicos = ServicoSync();
  final writer = FirebaseWriter();

  @override
  void initState() {
    super.initState();
    carregarDados();
    //verificarExpirarSenhas();
    print('Senha do Aparelho: ${widget.servico.senhaPadrao}');
  }

  Future<void> carregarDados() async {

    final cargoSalvo = await CargoHelper.lerCargo();
    final assi = await PremiumHelper.lerPremium();

    checkAssinatura = assi;
    setState(() {
      if (cargoSalvo == 'admin') {
        cargoAtual = 'Gerente';
      } else if (cargoSalvo == 'tecnico') {
        cargoAtual = 'Técnico';
      } else if (cargoSalvo == 'atendente') {
        cargoAtual = 'Atendente';
      } else {
        cargoAtual = 'Não encontrado';
      }
    });
  }

  List<ItemAcessorio> converterParaLista(String dados) {
    if (dados.trim().isEmpty) return [];

    final regex = RegExp(r'([^,]+?)\s*\(R\$\s*([\d.,]+)\)');

    final matches = regex.allMatches(dados);

    return matches.map((match) {
      final nome = match.group(1)!.trim();
      final valorNumero = match.group(2)!.trim();

      return ItemAcessorio(
        nome: nome,
        valor: "R\$ $valorNumero",
      );
    }).toList();
  }

  // Future<void> verificarExpirarSenhas() async {
  //   final todasOS = await DatabaseHelper.isar.servicos.where().findAll();
  //
  //   for (final os in todasOS) {
  //     if (os.dataSenha != null) {
  //       final agora = DateTime.now();
  //       final diferenca = agora.difference(os.dataSenha!).inDays;
  //
  //       if (diferenca >= 2) {
  //         os.senha = null;
  //         os.senhaPadrao = null;
  //         os.dataSenha = null;
  //
  //         await DatabaseHelper.isar.writeTxn(() async {
  //           await DatabaseHelper.isar.servicos.put(os);
  //         });
  //       }
  //     }
  //   }
  // }

  final currency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  late final double lucro =
      (servico.valorOriginalServicoDouble ?? 0) -
          (servico.valorTotalCustoPecasDouble ?? 0);

  late final servico = widget.servico;

  IconData getIconByFormaPagamento(String formaPgto) {
    switch (formaPgto.toLowerCase()) {
      case 'dinheiro':
        return Icons.payments_outlined;

      case 'pix':
        return Icons.pix;

      case 'débito':
        return Icons.credit_card;

      case 'crédito parcelado':
        return Icons.credit_card;

      case 'crédito à vista':
        return Icons.credit_card_outlined;

      case 'alimentação':
      case 'alimentacao':
        return Icons.restaurant;

      case 'boleto':
        return Icons.receipt_long;

      case 'cheque':
        return Icons.description;

      default:
        return Icons.attach_money; // ícone padrão
    }
  }

  Color dynamicBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : const Color(0xFFF2F5F9);
  }

  @override
  Widget build(BuildContext context) {

    Color txtCor = Theme.of(context).colorScheme.onSurface;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: dynamicBackground(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: txtCor,
        ),
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${servico.nomeCliente}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: txtCor,
              )
            ),
            Text(widget.servico.data.toString(),
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
                color: txtCor,
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.only(right: 10),
        actions: [
          context.isDesktop ?
          _horizontalMenu() : _popUpMenu(),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        )
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30)
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: StreamBuilder(
                stream: DatabaseHelper.isar.servicos.watchObject(servico.id),
                builder: (context, snapshot) {

                  final s = snapshot.data ?? servico;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.isDesktop ? _buildDesktopLayout(servico.valorOriginalServicoDouble ?? 0, lucro, s) :
                      _buildMobileLayout(servico.valorOriginalServicoDouble ?? 0, lucro, s),
                    ]
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(double valorTotal, double lucro, Servico s) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _resumoFinanceiro(),
        _cardPagamento(
            s: s,
            cor: s.formaPgto1.isEmpty ? Colors.orange : Colors.greenAccent.shade700,
            valor: s.valor1Double ?? 0,
            status: s.formaPgto1.isEmpty ? 'Em aberto' : s.formaPgto1.isNotEmpty && s.formaPgto2.isNotEmpty ? 'Pagamento 1' : 'Pago',
            pagamento: s.formaPgto1,
            parcelas: s.parcelas1,
            icon: getIconByFormaPagamento(s.formaPgto1),
            exibirBotao: s.formaPgto1 == ''
        ),
        if (validarPagamentos(s))...[
          const SizedBox(height: 16),
          _cardPagamento(
              s: s,
              cor: Colors.greenAccent.shade700,
              valor: s.valor2 ?? 0,
              status: s.formaPgto1.isNotEmpty && s.formaPgto2.isNotEmpty ? 'Pagamento 2' : 'Pago',
              pagamento: s.formaPgto2,
              parcelas: s.parcelas2,
              icon: getIconByFormaPagamento(s.formaPgto2),
              exibirBotao: s.formaPgto2 == ''
          ),
        ],
        if (servico.acessorios != null && servico.acessorios!.isNotEmpty)
        _listaAcessorios(),
        Visibility(
          visible: servico.itensBons.isNotEmpty || servico.itensRuins.isNotEmpty,
          child: _checkListResult(),
        ),
        _buildAparelhoCard(),
        _buildDetalhesServicoCard(),
        _buildDetalhesPrivados(),
      ],
    );
  }

  Widget _buildDesktopLayout(double valorOServico, double lucro, Servico s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _resumoFinanceiro(),
              _cardPagamento(
                  s: s,
                  cor: s.formaPgto1.isEmpty ? Colors.orange : Colors.greenAccent.shade700,
                  valor: s.valor1Double ?? 0,
                  status: s.formaPgto1.isEmpty ? 'Em aberto' : s.formaPgto1.isNotEmpty && s.formaPgto2.isNotEmpty ? 'Pagamento 1' : 'Pago',
                  pagamento: s.formaPgto1,
                  parcelas: s.parcelas1,
                  icon: getIconByFormaPagamento(s.formaPgto1),
                  exibirBotao: s.formaPgto1 == ''
              ),
              if (validarPagamentos(s))...[
                const SizedBox(height: 16),
                _cardPagamento(
                    s: s,
                    cor: Colors.greenAccent.shade700,
                    valor: s.valor2 ?? 0,
                    status: s.formaPgto1.isNotEmpty && s.formaPgto2.isNotEmpty ? 'Pagamento 2' : 'Pago',
                    pagamento: s.formaPgto2,
                    parcelas: s.parcelas2,
                    icon: getIconByFormaPagamento(s.formaPgto2),
                    exibirBotao: s.formaPgto2 == ''
                ),
              ],
              _buildAparelhoCard(),
              if (servico.acessorios != null && servico.acessorios!.isNotEmpty)
                _listaAcessorios(),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _buildDetalhesServicoCard(),
              Visibility(
                visible: servico.itensBons.isNotEmpty || servico.itensRuins.isNotEmpty,
                child: _checkListResult(),
              ),
              _buildDetalhesPrivados(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _checkListResult () {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomCard(
      margin: const EdgeInsets.only(top: 16),
      color: isDark ? const Color(0xFF141418) : Colors.white,
      child: ExpansionTile(
        initiallyExpanded: context.isDesktop ? true : false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)),
        title: Text('Resultado da Avaliação',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        children: [
          Column(
            children: servico.itensRuins.map((item) {
              return ListTile(
                title: Text(item),
                leading: const Icon(Icons.error, color: Colors.red),
              );
            }).toList(),
          ),
          Column(
            children: servico.itensBons.map((item) {
              return ListTile(
                title: Text(item),
                leading: const Icon(Icons.check, color: Colors.green),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _resumoFinanceiro () {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF141418) : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _infoLine(
              label: 'Valor Total:',
              value: (servico.valorOriginalServicoDouble ?? 0) + (servico.valorTotalAcessoriosDouble ?? 0),
              icon: Icons.attach_money,
              color: Colors.greenAccent.shade700,
            ),
            _infoLine(
              label: 'Valor Serviço:',
              value: servico.valorOriginalServicoDouble ?? 0,
              icon: Icons.attach_money,
              color: Colors.greenAccent.shade700,
              visible: (servico.valorTotalAcessoriosDouble ?? 0) > 0,
            ),
            _infoLine(
              label: 'Lucro Estimado:',
              value: lucro,
              icon: Icons.trending_up,
              color: Colors.greenAccent.shade700,
              visible: (servico.valorTotalCustoPecasDouble ?? 0) > 0 && cargoAtual == 'Gerente',
            ),
            _infoLine(
              label: 'Valor Acessórios:',
              value: servico.valorTotalAcessoriosDouble ?? 0,
              icon: Icons.add,
              color: Colors.greenAccent.shade700,
              visible: (servico.valorTotalAcessoriosDouble ?? 0) > 0,
            ),
            _infoLine(
              label: 'Custo de Peças:',
              value: servico.valorTotalCustoPecasDouble ?? 0,
              icon: Icons.remove_circle,
              color: Colors.redAccent,
              visible: (servico.valorTotalCustoPecasDouble ?? 0) > 0 && cargoAtual == 'Gerente',
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoLine ({
    required String label,
    required double value,
    required IconData icon,
    required Color color,
    bool? visible,
  }) {
    return Visibility(
      visible: visible ?? true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const Spacer(),
          Text(currency.format(value),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardPagamento ({
    Color? cor,
    required Servico s,
    required IconData icon,
    required double valor,
    required String status,
    required String pagamento,
    required String parcelas,
    required bool exibirBotao,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
        padding: const EdgeInsets.all(15),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF141418) : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cor?.withValues(alpha: 0.2) ?? Colors.greenAccent,
                  ),
                  child: Icon(icon,
                    color: cor, //Colors.green,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (pagamento != '')
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(pagamento,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    Text(status,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: cor
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(currency.format(valor),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    if (parcelas != '')
                      Text(parcelas,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                if (exibirBotao)
                  _botaoPagamento()
              ],
            ),
          ],
        )
    );
  }

  Widget _botaoPagamento () {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.green.shade400,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => PagamentoDialog(
                segundoPagamento: servico.formaPgto1 == '' && servico.formaPgto2 != '' ? true : false,
                valorTotalRecebido: servico.valor1Double ?? 0,
                pagamento: (formaPagamento, valorRecebido, parcelas, trocoRecebido) async {
                  if (!mounted) return;

                  /// abre o loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const LoadingWidget(
                      message: [
                        'Salvando pagamento',
                        'Atualizando dados',
                        'Sincronizando...',
                      ],
                    ),
                  );

                  try {
                    final isar = DatabaseHelper.isar;
                    final updates = <String, dynamic>{};
                    final user = FirebaseAuth.instance.currentUser;
                    if (user == null) {
                      if (mounted) Navigator.of(context, rootNavigator: true).pop();
                      return;
                    }

                    // --- PAGAMENTO TOTAL ---
                    if (valorRecebido == servico.valor1Double) {
                      await isar.writeTxn(() async {
                        servico.formaPgto1 = formaPagamento;
                        servico.parcelas1 = parcelas;

                        // 🔴 CORREÇÃO 1: Faltou salvar no Isar
                        await isar.servicos.put(servico);
                      });

                      updates['formaPgto'] = formaPagamento;
                      updates['qtdParcelas'] = parcelas;
                    }

                    // --- PAGAMENTO PARCIAL ---
                    else {
                      // Calcula o novo saldo devedor
                      final novoValorRestante = (servico.valorOriginalServicoDouble ?? 0) +
                          (servico.valorTotalAcessoriosDouble ?? 0) -
                          valorRecebido;

                      await isar.writeTxn(() async {
                        servico.valor1Double = novoValorRestante;
                        servico.formaPgto2 = formaPagamento;
                        servico.parcelas2 = parcelas;
                        servico.valor2 = valorRecebido;

                        // 🔴 CORREÇÃO 1: Faltou salvar no Isar
                        await isar.servicos.put(servico);
                      });

                      // 🔴 CORREÇÃO 2: Faltou atualizar o valor1 no Firebase!
                      updates['valor1'] = novoValorRestante;

                      updates['formaPgto2'] = formaPagamento;
                      updates['parcelas2'] = parcelas;
                      updates['valor2'] = valorRecebido;
                    }

                    // 🔥 Envia somente os campos alterados para o Firebase
                    if (updates.isNotEmpty) {

                      // Atualizamos a data de modificação para manter o sync em dia
                      updates['updatedAt'] = FieldValue.serverTimestamp();

                      // 🔴 CORREÇÃO 3: Ajuste do caminho (verifique se seu writer.update usa 2 ou 3 parâmetros)
                      // Se ele for igual ao seu writer.write, deve ser assim:
                      await writer.update('servicos', servico.id, updates);

                      // Se a sua função REALMENTE exigir o caminho completo numa string só, use:
                      // await writer.update('users/${user.uid}/servicos/${servico.id}', updates);
                    }

                    if (!context.mounted) return;

                    /// fecha loading
                    Navigator.of(context, rootNavigator: true).pop();

                    setState(() {}); // Atualiza a tela com os novos dados

                  } catch (e) {
                    if (!mounted) return;

                    /// fecha loading em caso de erro
                    Navigator.of(context, rootNavigator: true).pop();

                    AppFlushbar.error('Erro ao salvar pagamento: $e');
                  }
                }
            ),
          );
        },
        child: const Text('Adicionar pagamento'),
      ),
    );
  }

  Widget _buildAparelhoCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: InfoCard(
        title: 'Detalhes do Aparelho',
        icon: Icons.smartphone,
        children: [
          _detalhes("Tipo de Aparelho: ", servico.tipoDeAparelho, exibirLinha: false),
          _detalhes("Modelo: ", servico.modelo),
          _detalhes("Marca: ", servico.marca,
              trailing: servico.marca != null && servico.marca!.isNotEmpty ?
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withValues(alpha: 0.8),
                ),
                child: Image.asset(
                  BrandRepository.getLogoByBrand(servico.marca!),
                  width: 30,
                  height: 30,
                ),
              ) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDetalhesServicoCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: InfoCard(
        title: 'Detalhes do Serviço',
        icon: Icons.build_circle_outlined,
        children: [
          _detalhes("Serviços Prestados: ", servico.servicos, exibirLinha: false),
          _detalhes("Problemas Diagnosticados: ", servico.problema),
          _detalhes("Motivo sem solução: ", servico.motivo),
          _detalhes('Peças Utilizadas: ', servico.pecasUtilizadas),
          _detalhes('Qualidade da Frontal: ', servico.qualidadeFrontal),
          _detalhes('Tipo de Frontal: ', servico.tipoDeFrontal),
          _detalhes("Fornecedor Externo: ", servico.fornecedor),
          _detalhes("Garantia: ", servico.garantia),
          _detalhes("Observações: ", servico.obs),
          _detalhes("Atendente Responsável: ", servico.atendente),
          _detalhes("Técnico Responsável: ", servico.tecnico),
          _detalhes("Data de Entrega: ", servico.dataEntrega),
        ],
      ),
    );
  }

  Widget _buildDetalhesPrivados() {

    final pattern = (servico.senhaPadrao ?? '')
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((e) => int.tryParse(e.trim()))
        .where((e) => e != null)
        .cast<int>()
        .toList();

    bool temSenhaOuPadrao(String cargoAtual, Servico servico) {
      if (cargoAtual == 'Atendente') return false;

      return (servico.senha?.isNotEmpty ?? false) ||
          (servico.senhaPadrao?.isNotEmpty ?? false);
    }

    return Visibility(
      visible: temSenhaOuPadrao(cargoAtual ?? '', servico),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: InfoCard(
            title: 'Senha do Aparelho',
            icon: Icons.security,
            children: [

              if (servico.status == 'finalizado')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Serviço Finalizado',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                      )
                    ),
                    const Spacer(),
                    const Icon(Icons.check_circle, color: Colors.green),
                  ],
                ),
              ),

              if (servico.status != 'finalizado')...[

                if (servico.senha?.isNotEmpty ?? false)
                _detalhes("Senha Digitada:",
                  servico.senha.toString(),
                  //cor: Colors.green,
                  exibirLinha: false,
                ),

                if (servico.senhaPadrao?.isNotEmpty ?? false)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PatternPreview(pattern: pattern),
                  ],
                ),
              ],
            ],
          )
      ),
    );
  }

  Widget _detalhes(String titulo, String? texto, {
    Widget? trailing,
    Widget? leading,
    Color? cor,
    bool exibirLinha = true,
  }) {
    return Visibility(
      visible: texto != null && texto.isNotEmpty,
      child: Column(
        children: [
          Visibility(
            visible: exibirLinha,
            child: const Divider(
              height: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(titulo,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(texto == null || texto.isEmpty ? 'Não informado' : texto,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: cor,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn (Function()? onPressed, String child, Icon icon) {
    return FilledButton.icon(
      // style: TextButton.styleFrom(
      //   backgroundColor: Colors.white.withValues(alpha: 0.2),
      //   foregroundColor: Colors.white
      // ),
      onPressed: onPressed,
      icon: icon,
      label: Text(child,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        )
      ),
    );
  }

  Widget _horizontalMenu () {
    return Row(
      children: [
        _btn(
            () {
            if (checkAssinatura) {
              pdfServices.compartilharPDF( widget.cliente, widget.servico, context );
            } else {
              AppFlushbar.info('Você precisa de uma assinatura para acessar esse recurso');

              Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumPage()));
            }
          },
          "Compartilhar",
          checkAssinatura ? const Icon(Icons.share) : const Icon(RemixIcon.vipCrownLine, color: Colors.amber, size: 15),
        ),
        const SizedBox(width: 10),
        _btn(
              () => pdfServices.imprimirPDF( widget.cliente, widget.servico, context ),
          "Imprimir 2º via",
          const Icon(Icons.print),
        ),
        const SizedBox(width: 10),
        _btn(
          () => _excluir(),
          "Excluir",
          const Icon(Icons.delete),
        ),
      ],
    );
  }

  Widget _popUpMenu() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txtCor = Theme.of(context).colorScheme.onPrimaryContainer;
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF141418) : Colors.white,
        shape: BoxShape.circle
      ),
      child: PopupMenuButton(
        //offset: const Offset(0, 50),
          //surfaceTintColor: Colors.blue,
          elevation: 10,
          shadowColor: Theme.of(context).colorScheme.primary,
          splashRadius: 20,
          color: isDark ? const Color(0xFF141418) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: (context) => [

            PopupMenuItem(
                mouseCursor: SystemMouseCursors.click,
                onTap: () => pdfServices.imprimirPDF( widget.cliente, widget.servico, context ),
                child: Row(
                  children: [
                    Icon(Icons.print, color: txtCor),
                    const SizedBox(width: 10),
                    Text('Imprimir 2º via',
                      style: TextStyle(
                        color: txtCor,
                      ),
                    ),
                  ],
                )
            ),

            PopupMenuItem(
                mouseCursor: SystemMouseCursors.click,
                onTap: () {
                  if (checkAssinatura) {
                    pdfServices.compartilharPDF( widget.cliente, widget.servico, context );
                  } else {

                    AppFlushbar.info('Você precisa de uma assinatura para acessar esse recurso');

                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumPage()));
                  }
                },
                child: Row(
                  children: [
                    Icon(FluentIcons.share_16_filled, color: txtCor),
                    const SizedBox(width: 10),
                    Text('Compartilhar',
                      style: TextStyle(
                        color: txtCor,
                      )
                    ),
                    if (checkAssinatura == false)...[
                      const SizedBox(width: 10),
                      const Icon(RemixIcon.vipCrownLine, color: Colors.amber, size: 15),
                    ],
                  ],
                )
            ),

            PopupMenuItem(
              mouseCursor: SystemMouseCursors.click,
                onTap: () async => await _excluir(),
                child: Row(
                  children: [
                    Icon(Icons.delete, color: txtCor),
                    const SizedBox(width: 10),
                    Text('Excluir',
                      style: TextStyle(
                        color: txtCor,
                      ),
                    ),
                  ],
                )
            ),
          ]
      ),
    );
  }

  Future<dynamic> _excluir () async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) =>
            CustomDialog(
                colorRight: Colors.red,
                onPressedLeft: () => Navigator.pop(context),
                onPressedRight: () async {

                  // Deletar serviço local e firebase

                  await syncServicos.deleteServico(widget.servico.id);

                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.green,
                      content: Text('Serviço excluído com sucesso!'),
                    ),
                  );
                  Navigator.pop(context); // Volta para a tela anterior após excluir
                  Navigator.pop(context, true);

                },
                title: 'Excluir Serviço ⚠️',
                content:
                'Tem certeza que deseja excluir este serviço? '
                    'Essa ação é irreversível!',
                rightButtonText: 'Excluir',
                leftButtonText: 'Cancelar'
            )
    );
  }

  bool validarPagamentos(Servico s) {
    final temPgto1 = s.formaPgto1.isNotEmpty;
    final temPgto2 = s.formaPgto2.isNotEmpty;

    return (!temPgto1 && temPgto2) || temPgto2;
  }

  // ScaffoldMessenger

  Widget _listaAcessorios () {
    final lista = converterParaLista(servico.acessorios ?? '');
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF141418) : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ExpansionTile(
          initiallyExpanded: context.isDesktop ? true : false,
          title: Text('Acessórios Incluidos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          shape: const Border(),
          collapsedShape: const Border(),
          enableFeedback: false,
          splashColor: Colors.transparent,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final item = lista[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(item.nome,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        )
                      ),
                      Text(item.valor,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[500],
                        )
                      ),
                    ],
                  ),
                );
              },
            )
          ]
        ),
      ),
    );
  }

}
