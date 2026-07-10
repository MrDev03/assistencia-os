import 'package:assistencia_os/custom_widgets/card_aviso.dart';
import 'package:assistencia_os/custom_widgets/device_icon.dart';
import 'package:assistencia_os/custom_widgets/dropdown_button_formfield.dart';
import 'package:assistencia_os/custom_widgets/icone_padrao.dart';
import 'package:assistencia_os/custom_widgets/info_card.dart';
import 'package:assistencia_os/custom_widgets/padrao_page.dart';
import 'package:assistencia_os/db_helper/cargo_helper.dart';
import 'package:assistencia_os/pages/listas.dart';
import 'package:assistencia_os/pages/service_registration/models/data_cadastro.dart';
import 'package:assistencia_os/providers/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:assistencia_os/custom_widgets/elevated_button.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import '../../custom_widgets/auto_complete_field.dart';
import '../../custom_widgets/campo_sugestoes.dart';
import '../../custom_widgets/dialog.dart';
import '../../custom_widgets/garantia.dart';
import '../../custom_widgets/seletor_data_hora.dart';
import '../../db_helper/db_helper.dart';
import '../../db_helper/premium_helper.dart';
import '../../models/estoque_pecas_model/estoque_pecas_model.dart';
import '../premium_page.dart';
import 'checklist_screen.dart';
import 'components/selecao_pecas_orcamento.dart';

//import '../../models/sync_service.dart' show SyncService;

class ServicoStep extends StatefulWidget {

  final DataCadastro data;
  final GlobalKey<FormState>? formKey;

  const ServicoStep({
    super.key,
    required this.data,
    this.formKey,
  });

  @override
  State<ServicoStep> createState() => _ServicoStepState();
}

class _ServicoStepState extends State<ServicoStep>
    with SingleTickerProviderStateMixin {

  // Controllers

  late final TextEditingController _dataEntrega;
  late final TextEditingController valorPecaController;
  late final TextEditingController acessorioController;
  late final TextEditingController _marcaController;
  late final TextEditingController _modeloController;
  late final ValueNotifier<int> _contador;


  // LISTAS E OUTROS
  List<String> _servicosPrestados = [];
  List<String> _pecasUtilizadas = [];
  //bool isEstoque = false;

  bool get temChecklistCompleto =>
      widget.data.itensBons.isNotEmpty && widget.data.itensRuins.isNotEmpty;

  @override
  void initState() {
    super.initState();

    final dados = widget.data;
    _dataEntrega = TextEditingController(text: dados.dataEntrega);

    _contador = ValueNotifier<int>(0);
    _servicosPrestados = dados.servicos.isNotEmpty ? List.from(dados.servicos.split(', ')) : [];
    _pecasUtilizadas = dados.pecasUtilizadas.isNotEmpty ? List.from(dados.pecasUtilizadas.split(', ')) : [];
    _marcaController = TextEditingController(text: dados.marca);
    _modeloController = TextEditingController(text: dados.modelo);
    valorPecaController = TextEditingController(text: dados.valorTotalCustoPecas);
    acessorioController = TextEditingController(text: dados.acessorios);
    _servicosPrestados = dados.servicos.isNotEmpty ? List.from(dados.servicos.split(', ')) : [];
    _pecasUtilizadas = dados.pecasUtilizadas.isNotEmpty ? List.from(dados.pecasUtilizadas.split(', ')) : [];

    // data.itensBons = itensBons;
    // data.itensRuins = itensRuins;

    //widget.data.carregarDados();
    carregarDados();
  }

  final FocusNode _entregaFocus = FocusNode();

  void _listToStringSPrestados() {
    String newValue = _servicosPrestados.join(', ');
    if (widget.data.servicos != newValue) {
      widget.data.servicos = newValue;
    }
    _contador.value++;
  }

  void _listToStringPecasUtilizadas() {
    String newValue = _pecasUtilizadas.join(', ');
    if (widget.data.pecasUtilizadas != newValue) {
      widget.data.pecasUtilizadas = newValue;
    }
    _contador.value++;
  }

  Future<void> carregarDados() async {

    final dados = widget.data;

    final cargoSalvo = await CargoHelper.lerCargo();
    //final clienteDados = await DatabaseHelper.getClienteById(widget.data.clienteId!);
    final dataForn = await DatabaseHelper.getAllFornecedores();
    //final dados = await DatabaseHelper.getEmpresa();
    final dadosTecnicos = await DatabaseHelper.getAllTecnicos();
    final dadosAtendentes = await DatabaseHelper.getAllAtendentes();
    final assi = await PremiumHelper.lerPremium();

    setState(() {
      dados.checkAssinatura = assi;
      dados.fornecedoresList = dataForn.map((e) => e.nome).toList();
      dados.tecnicosList = dadosTecnicos.map((e) => e.nome).toList();
      dados.atendentesList = dadosAtendentes.map((e) => e.nome).toList();
      dados.cargoAtual = cargoSalvo;
    });
  }


  @override
  void dispose() {
    valorPecaController.dispose();
    _marcaController.dispose();
    _modeloController.dispose();
    _dataEntrega.dispose();
    _contador.dispose();
    acessorioController.dispose();
    super.dispose();
  }

  // Função para limpar e converter o texto do controller em double
  double parseValor(String text) {
    if (text.isEmpty) return 0.0;
    try {
      // Remove simbolos de moeda e milhares se houver, troca virgula por ponto
      String clean =
          text
              .replaceAll('R\$', '')
              .replaceAll('.', '') // Remove ponto de milhar
              .replaceAll(',', '.') // Troca vírgula decimal por ponto
              .trim();
      return double.tryParse(clean) ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  final _currency = NumberFormat.simpleCurrency(locale: 'pt_BR');

  // Função que abre a tela de seleção
  void _criarOrcamento() async {
    // Navigator.push retorna o que passamos no .pop() da outra tela
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SelecaoPecasOrcamentoScreen(),
      ),
    );

    // Verifica se voltou com dados
    if (resultado != null && resultado is Map) {
      final List<EstoquePecas> pecas = resultado['pecas'];
      widget.data.pecasUtilizadasRetorno = pecas;
      final double total = resultado['total'];
      final double totalPecasCusto = resultado['totalCusto'];

      for (var peca in pecas) {
        widget.data.qualidadeFrontal = peca.qualidadeTela ?? '';
        widget.data.tipoFrontal = peca.aro ? 'Com Aro' : 'Sem Aro';
      }

      setState(() {
        widget.data.modelo = pecas.first.modelo ?? '';
        _pecasUtilizadas = pecas.map((p) => p.tipo ?? '').toList();
        widget.data.valorOriginalServico = total == 0 ? '' : _currency.format(total).replaceAll('R\$', '').trim();
        valorPecaController.text = totalPecasCusto == 0 ? '' : _currency.format(totalPecasCusto).replaceAll('R\$', '').trim();

        _modeloController.text = widget.data.modelo;
        _marcaController.text = widget.data.marca;
      });
      _listToStringPecasUtilizadas();


      // --- AQUI VOCÊ FAZ O QUE QUISER COM OS DADOS ---
      // Exemplo: Mostrar um resumo num Dialog
      //_mostrarResumoOrcamento(pecas, total);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: _formularioNovaOS(),
    );
  }

  Widget _formularioNovaOS() {

    bool isVisible = true;

    validate(value) => value == null || value.isEmpty ? 'Campo obrigatório' : null;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final data = widget.data;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Define se é tela pequena (mobile) ou grande (tablet/desktop)
        bool isWide = constraints.maxWidth > 600;

        return SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Column(
              spacing: 16,
              children: [

                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: CardAviso(
                    message: "Preencha os campos abaixo. Campos marcados com (*) são obrigatórios.",
                  ),
                ),

                // SE FOR WINDOWS
                if (isWide)...[
                  Row(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // DIREITA
                      Expanded(
                        child: Column(
                          spacing: 16,
                          children: [
                            // --- SEÇÃO A: SEÇÃO DE PEÇA ---
                            // _modoSelect(
                            //   data,
                            //   (value) => setState(() => data.mode = value),
                            // ),

                            _selecionarPeca(),

                            // --- SEÇÃO B: DADOS DO APARELHO ---
                            _dadosAparelho(validate),

                            // --- SEÇÃO C: DIAGNÓSTICO E SERVIÇO ---
                            _diagnosticoServico(validate, data),
                          ],
                        ),
                      ),

                      // ESQUERDA
                      Expanded(
                        child: Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- SEÇÃO D: SEGURANÇA E ACESSÓRIOS ---
                            _segurancaAcessorios(validate, data, isVisible),

                            // --- SEÇÃO E: LOGÍSTICA E OBS ---
                            _logisticaObs(validate, data),
                          ],
                        ),
                      )

                    ],
                  )
                ] else ...[

                  // --- SEÇÃO A: SEÇÃO DE PEÇA ---

                  _selecionarPeca(),

                  // --- SEÇÃO B: DADOS DO APARELHO ---
                  _dadosAparelho(validate),

                  // --- SEÇÃO C: DIAGNÓSTICO E SERVIÇO ---
                  _diagnosticoServico(validate, data),

                  // --- SEÇÃO D: SEGURANÇA E ACESSÓRIOS ---
                  _segurancaAcessorios(validate, data, isVisible),

                  // --- SEÇÃO E: LOGÍSTICA E OBS ---
                  _logisticaObs(validate, data),

                  const SizedBox(height: 60,)

                ],
              ],
            ),
          ),
        );
      },
    );
  }

  // --- MÉTODOS AUXILIARES E WIDGETS ---

  // Widget _modoSelect (DataCadastro data, Function(bool) onChanged) {
  //   return CustomCard(
  //     color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
  //     child: SwitchListTile(
  //       title: Text(
  //         "Incluir Peças",
  //         style: TextStyle(
  //           color: Theme.of(context).colorScheme.onPrimaryContainer,
  //           fontWeight: FontWeight.bold,
  //           fontSize: 18,
  //         ),
  //       ),
  //       value: data.mode,
  //       onChanged: onChanged,
  //       //controlAffinity: ListTileControlAffinity.leading,
  //       contentPadding: const EdgeInsets.only(left: 16, right: 10),
  //     ),
  //   );
  // }

  Future<void> _limparDados () async {
    final data = widget.data;
    setState(() {
      _pecasUtilizadas.clear();
      data.pecasUtilizadas = '';
      data.pecasUtilizadasRetorno = [];
      data.qualidadeFrontal = '';
      data.tipoFrontal = '';
      data.modelo = '';
      data.fornecedor = '';
      data.valorTotalCustoPecas = '';
      data.valorOriginalServico = '';
      valorPecaController.clear();
    });
    _contador.value++;
  }

  Widget _selecionarPeca () {
    final theme = Theme.of(context).colorScheme;
    return InfoCard(
      trailing: IconButton(
        onPressed: () => _limparDados(),
        icon: const Icon(Icons.refresh),
      ),
      color: Colors.cyan,
      title: 'Peças Utilizadas',
      icon: Icons.inventory_2_outlined,
      noBory: true,
      padding: const EdgeInsets.all(16),
      children: [

        _modePeca(),
        // Lógica da Tela/Display (Condicional)

        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Visibility(
            visible: !widget.data.isEstoque,
            child: Column(
              children: [
                _dadosFornecedor(),

                SG(
                  sugestoes: tPeca,
                  selecionados: _pecasUtilizadas,
                  onAdd: _listToStringPecasUtilizadas,
                  labelText: "Peças utilizadas",
                  hintText: 'Adicione ou selecione as peças utilizadas',
                ),

                ValueListenableBuilder<int>(
                  valueListenable: _contador, // Triggers when _listToStringPecasUtilizadas is called
                  builder: (context, value, child) {
                    final data = widget.data;
                    final texto = _pecasUtilizadas.join(', ').toLowerCase();
                    final ehTela = [
                      'frontal',
                      'modulo',
                      'display',
                      'lcd',
                      'tela',
                    ].any((w) => texto.contains(w));

                    if (!ehTela) {
                      // Limpa variáveis se não for tela (Cuidado com setState dentro do build, ideal mover p/ controller listener)
                      // _qualidade = '';
                      data.qualidadeFrontal = '';
                      data.tipoFrontal = '';

                      return const SizedBox();
                    }

                    return Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Detalhes da Tela",
                            style: TextStyle(
                              color: theme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomDBFF(
                            initialValue: data.qualidadeFrontal.isEmpty ? null : widget.data.qualidadeFrontal,
                            labelText: 'Qualidade',
                            onChanged: (v) => setState(() => data.qualidadeFrontal = v ?? ''),
                            validator: (v) {
                              if (ehTela && data.qualidadeFrontal.isEmpty || ehTela && data.tipoFrontal.isEmpty) {
                                return 'Selecione a qualidade da peça';
                              }
                              return null;
                            },
                            items:
                            qualidade
                                .map(
                                  (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                                .toList(),
                            suffixIcon: null,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildChip(
                                'Com Aro',
                                data.tipoFrontal == 'Com Aro',
                                    (v) => setState(
                                      () =>
                                  data.tipoFrontal = 'Com Aro',
                                ),
                              ),

                              const SizedBox(width: 8),
                              _buildChip(
                                'Sem Aro',
                                data.tipoFrontal == 'Sem Aro',
                                    (v) => setState(
                                      () =>
                                  data.tipoFrontal = 'Sem Aro',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // CustomTextField(
                //   controller: valorPecaController,
                //   labelText: 'Valor de Custo das Peças',
                //   hintText: '0,00',
                //   prefix: const Text('R\$ '),
                //   keyboardType: TextInputType.number,
                //   inputFormatters: [
                //     FilteringTextInputFormatter.digitsOnly,
                //     CentavosInputFormatter(),
                //   ],
                //   onChanged: (text) => widget.data.valorTotalCustoPecas = text,
                // ),
              ],
            ),
          ),
        ),

        // BOTÃO SELECIONAR PEÇAS
        AnimatedSize(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          // O AnimatedSize encolhe perfeitamente quando passamos um SizedBox vazio
          child: !widget.data.isEstoque
              ? const SizedBox.shrink()
              : Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              // Fundo super leve que se adapta ao tema (Claro/Escuro)
              color: theme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // --- TÍTULO DA SEÇÃO ---
                Row(
                  children: [
                    Icon(Icons.inventory_2_rounded, size: 20, color: theme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Peças e Componentes do estoque',
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: theme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // --- LISTA DE PEÇAS (Estilo Chips) ---
                if (_pecasUtilizadas.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _pecasUtilizadas.map((peca) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          peca,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: theme.primary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                // --- PAINEL DE QUALIDADE E TIPO ---
                if (widget.data.qualidadeFrontal.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.surface.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        // Qualidade
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'QUALIDADE',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  color: theme.onSurface.withValues(alpha: 0.5),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.data.qualidadeFrontal,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: theme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Divisória vertical sutil
                        Container(
                          height: 30,
                          width: 1,
                          color: theme.outlineVariant.withValues(alpha: 0.5),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                        ),

                        // Tipo
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TIPO',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  color: theme.onSurface.withValues(alpha: 0.5),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.data.tipoFrontal.isEmpty ? 'N/A' : widget.data.tipoFrontal,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: theme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // --- BOTÃO DE AÇÃO ---
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _criarOrcamento,
                    icon: const Icon(Icons.add_shopping_cart_rounded, size: 20),
                    label: const Text(
                      'Selecionar Peças',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: theme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

      ]
    );
  }

  Widget _dadosAparelho (String? Function(String?)? validate) {
    return InfoCard(
      color: Colors.indigoAccent,
      title: 'Dados do Aparelho',
      icon: Icons.phone_android,
      noBory: true,
      padding: const EdgeInsets.all(16),
      children: [

        _tipoAparelhoSelector(),

        BrandSelectorField(
          controller: _marcaController,
          labelText: 'Marca',
          brandsMap: BrandRepository.getByType(
            widget.data.tipoAparelho,
          ),
          onChanged: (text) => widget.data.marca = text,
        ),

        CustomTextField(
          controller: _modeloController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          labelText: 'Modelo',
          hintText: 'Ex: iPhone 13, Galaxy S20',
          requiredTxt: ' *',
          maxLenght: 30,
          validator: validate,
          onChanged: (text) => widget.data.modelo = text,
        ),

      ],
    );
  }

  Widget _diagnosticoServico (String? Function(List<String>?)? validate, DataCadastro data,) {
    final theme = Theme.of(context).colorScheme;
    return InfoCard(
      color: Colors.deepOrange,
      title: 'Diagnóstico e Execução',
      icon: Icons.build_circle_outlined,
      noBory: true,
      padding: const EdgeInsets.all(16),
      children: [

        SG(
          sugestoes: listaDeServicosComuns,
          selecionados: _servicosPrestados,
          onAdd: _listToStringSPrestados,
          labelText: 'Serviços prestados',
          requiredTxt: ' *',
          hintText: 'Ex: Reparo na placa...',
          validator: validate,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),

        GarantiaSelector(
          onChanged: (text) => widget.data.garantia = text,
          data: data,
        ),

        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () async {

              if (!widget.data.checkAssinatura) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PremiumPage(),
                  ),
                );
                return;
              }

              final resultado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChecklistAparelhoScreen(tipoAparelho: widget.data.tipoAparelho,),
                ),
              );
              if (resultado != null) {

                final itensBons = List<String>.from(resultado['bons']);
                final itensRuins = List<String>.from(resultado['ruins']);

                setState(() {
                  widget.data.itensBons = itensBons;
                  widget.data.itensRuins = itensRuins;
                });

              }
            },
            icon: Icon(
              switch (widget.data.checkAssinatura) {
                false => Icons.lock,
                true when temChecklistCompleto => Icons.refresh,
                _ => Icons.checklist,
              },
            ),
            //!widget.data.checkAssinatura ? const Icon(Icons.lock) : temChecklistCompleto ? const Icon(Icons.refresh) : const Icon(Icons.checklist),
            label: Text(temChecklistCompleto ? 'Refazer Avaliação' : 'Avaliar Aparelho'),
          ),
        ),
        Visibility(
          visible: temChecklistCompleto,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ExpansionTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
              collapsedIconColor: Colors.white,
              iconColor: theme.onPrimaryContainer,
              textColor: theme.onPrimaryContainer,
              collapsedTextColor: Colors.white,
              title: const Text('Resultado da Avaliação',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )
              ),
              children: [
                GestureDetector(
                  onTap: () {
                    // CustomDialog2.show(
                    //   context: context,
                    //   title: 'Item Ruim',
                    //   description: 'Este item foi marcado como ruim. Avise seu cliente com antecedência para que ele fique ciente.',
                    //   confirmText: 'Ok'
                    // );
                  },
                  child: Column(
                    children: data.itensRuins.map((item) {
                      return ListTile(
                        title: Text(item),
                        leading: const Icon(Icons.error, color: Colors.red),
                      );
                    }).toList(),
                  ),
                ),
                Column(
                  children: data.itensBons.map((item) {
                    return ListTile(
                      title: Text(item),
                      leading: const Icon(Icons.check, color: Colors.green),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _segurancaAcessorios(String? Function(String?)? validate, DataCadastro data, bool isVisible) {
    return InfoCard(
      color: Colors.teal,
      title: 'Segurança & Extras',
      icon: Icons.lock_outline,
      noBory: true,
      padding: const EdgeInsets.all(16),
      children: [
        _senhaBtn(),
        // Seu widget de seleção de tipo de senha

        // Senha Digitada
        AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: widget.data.tipoSenha == 'Senha' || widget.data.tipoSenha == 'PIN',
              child: ValueListenableBuilder(
                valueListenable: notifier,
                builder: (context, _, __) {
                  return CustomTextField(
                    hintText: 'Digite a senha',
                    labelText: 'Senha do aparelho',
                    obscureText: isVisible,
                    maxLines: 1,
                    inputFormatters: [
                      widget.data.tipoSenha == 'Senha'
                          ? FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
                          : FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    keyboardType: widget.data.tipoSenha == 'PIN'
                        ? TextInputType.number
                        : TextInputType.text,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        isVisible = !isVisible;
                        notifier.atualizar();
                      },
                    ),
                    initialValue: widget.data.senha,
                    onChanged: (text) => widget.data.senha = text,
                  );
                },
              ),
            )
        ),

        // Senha Padrão
        if (widget.data.tipoSenha == 'Padrão')
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch,
              children: [
                if (data.senhaPadrao == null)
                  CustomElevatedButton(
                    label: "Desenhar Padrão",
                    icon: const Icon(
                      Icons.gesture,
                      color: Colors.white,
                    ),
                    click: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => PatternLockWidget(
                          gridSize: 3,
                          confirmar: true,
                          minLength: 3,
                          onSalvar:
                              (p) => setState(
                                () => data.senhaPadrao = p,
                          ),
                        ),
                      );
                    },
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Padrão salvo",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ]
    );
  }

  Widget _logisticaObs(String? Function(String?)? validate, DataCadastro data) {
    return InfoCard(
      color: Colors.pinkAccent,
      title: 'Logística & Detalhes',
      icon: Icons.calendar_month,
      noBory: true,
      padding: const EdgeInsets.all(16),
      children: [
        _navegarPremium(
          child: CustomDBFF(
            enabled: data.checkAssinatura || data.tecnicosList.isEmpty,
            initialValue: data.tecnico == '' ? null : data.tecnico,
            labelText: data.tecnicosList.isEmpty ? 'Nenhum Técnico Cadastrado' : 'Técnico Responsável',
            suffixIcon:
            data.checkAssinatura
                ? null
                : const Icon(
              RemixIcon.vipCrownLine,
              color: Colors.amber,
              size: 15,
            ),
            onChanged: (v) => setState(() => data.tecnico = v?.toString() ?? ''),
            items:
            data.checkAssinatura
                ? data.tecnicosList
                .map(
                  (t) => DropdownMenuItem(
                value: t,
                child: Text(t),
              ),
            ).toList() : [],
          ),
        ),

        CustomDBFF(
          enabled: data.checkAssinatura || data.atendentesList.isEmpty,
          initialValue: data.atendimento == '' ? null : data.atendimento,
          labelText: data.atendentesList.isEmpty ? 'Nenhum Atendente Cadastrado' : 'Atendente Responsável',
          onChanged: (v) => setState(() => data.atendimento = v?.toString() ?? ''),
          suffixIcon: data.checkAssinatura
              ? null
              : const Icon(
            RemixIcon.vipCrownLine,
            color: Colors.amber,
            size: 15,
          ),
          items:
          data.checkAssinatura
              ? data.atendentesList
              .map(
                (a) => DropdownMenuItem(
              value: a,
              child: Text(a),
            ),
          ).toList() : [],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextFormField(
            //focusNode: _entregaFocus,
            readOnly: true, // Não permite editar o campo
            enabled: data.checkAssinatura,
            onTap: _selecionarDataEntrega,
            decoration: InputDecoration(
              hintText: 'Data da Entrega',
              labelText: 'Previsão de Entrega',
              suffixIcon:
              data.checkAssinatura
                  ? const Icon(Icons.date_range)
                  : const Icon(
                RemixIcon.vipCrownLine,
                color: Colors.amber,
                size: 15,
              ),
            ),
            controller: _dataEntrega,
            //initialValue: data.dataEntrega == '' ? null : data.dataEntrega,
          ),
        ),

        CustomTextField(
          hintText: '',
          labelText: 'Observações Gerais',
          maxLines: 3,
          initialValue: data.obs,
          onChanged: (text) => data.obs = text,
        ),
      ]
    );
  }

  // Widget _buildDualField({
  //   required bool isWide,
  //   required Widget child1,
  //   required Widget child2,
  // }) {
  //   if (isWide) {
  //     return Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Expanded(child: child1),
  //         const SizedBox(width: 12),
  //         Expanded(child: child2),
  //       ],
  //     );
  //   } else {
  //     return Column(children: [child1, child2]);
  //   }
  // }

  Widget _buildChip(
    String label,
    bool selected,
    Function(bool) onSelect, {
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: selected ? Colors.white : Colors.grey,
              ),
              const SizedBox(width: 6),
            ],
            Text(label),
          ],
        ),
        selected: selected,
        onSelected: onSelect,
        showCheckmark: false,
        selectedColor: Theme.of(context).colorScheme.primary,
        labelStyle: TextStyle(
          color:
              selected ? Colors.white : Theme.of(context).colorScheme.onSurface,
        ),
        checkmarkColor: Colors.white,
      ),
    );
  }

  // Lógica de Parcelas extraída para limpar o build principal

  // Future<void> _selecionarDataEntrega() async {
  //   if (!widget.data.checkAssinatura) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const PremiumPage()),
  //     );
  //     return;
  //   }
  //   final pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2100),
  //     locale: const Locale('pt', 'BR'),
  //   );
  //
  //   final agora = TimeOfDay.now();
  //
  //
  //
  //   if (pickedDate != null && mounted) {
  //     final pickedTime = await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.now(),
  //     );
  //     if (pickedTime != null) {
  //       final dt = DateTime(
  //         pickedDate.year,
  //         pickedDate.month,
  //         pickedDate.day,
  //         pickedTime.hour,
  //         pickedTime.minute,
  //       );
  //       if (!mounted) return;
  //       widget.data.dataEntrega = "${dt.day}/${dt.month}/${dt.year} • ${pickedTime.format(context)}";
  //       setState(() {
  //
  //       });
  //     }
  //
  //     // 🔥 Mantém o foco
  //     Future.delayed(const Duration(milliseconds: 100), () {
  //       _entregaFocus.requestFocus();
  //     });
  //
  //   }
  // }


// ... (dentro da sua classe)

  // Importe a classe global no topo do seu arquivo
// import 'seletor_data_hora_global.dart';

  Future<void> _selecionarDataEntrega() async {
    // 1. Mantém a sua checagem de assinatura original
    if (!widget.data.checkAssinatura) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PremiumPage()),
      );
      return;
    }

    // 2. Chama o componente global que nós criamos
    final DateTime? resultado = await SeletorDataHoraGlobal.selecionar(context);

    // 3. Processa o resultado se o usuário não tiver cancelado
    if (resultado != null && mounted) {

      // Formatação com Zeros à esquerda para não ficar "5/8/2026 9:5" e sim "05/08/2026 09:05"
      final dia = resultado.day.toString().padLeft(2, '0');
      final mes = resultado.month.toString().padLeft(2, '0');
      final ano = resultado.year.toString();
      final hora = resultado.hour.toString().padLeft(2, '0');
      final minuto = resultado.minute.toString().padLeft(2, '0');
      
      setState(() {
        widget.data.dataEntrega = "$dia/$mes/$ano • $hora:$minuto";
        _dataEntrega.text = widget.data.dataEntrega;
      });

      // Mantém o foco no campo de entrega após fechar o modal
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   if (mounted) {
      //     _entregaFocus.requestFocus();
      //   }
      // });
    }
  }





  Widget _modePeca () {
    final data = widget.data;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none, // Permite que a sombra apareça sem cortes
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [

              ChoiceChip(
                showCheckmark: false,
                avatar: Icon(
                  Icons.inventory_2_outlined,
                  size: 18,
                  color: data.isEstoque ? Colors.white : null,
                ),
                label: const Text("Estoque"),
                selected: data.isEstoque,
                onSelected: (_) {
                  setState(() => data.isEstoque = true);
                  _limparDados();
                },
              ),

              ChoiceChip(
                showCheckmark: false,
                avatar: Icon(
                  Icons.local_shipping_outlined,
                  size: 18,
                  color: !data.isEstoque ? Colors.white : null,
                ),
                label: const Text("Fornecedor Externo"),
                selected: !data.isEstoque,
                onSelected: (_) {
                  setState(() => data.isEstoque = false);
                  _limparDados();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navegarPremium({required Widget child}) {
    return widget.data.checkAssinatura
        ? child
        : GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PremiumPage()),
            );
          },
          child: child,
        );
  }

  Widget _senhaBtn() {
    final data = widget.data;

    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none, // Essencial para o brilho (shadow) não ser cortado
        child: Padding(
          // Padding extra para dar espaço ao brilho do shadow
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGlowingCard(
                label: "Padrão",
                icon: PatternLockIcon(
                  size: 20,
                  color: data.tipoSenha == 'Padrão'
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                ),
                isSelected2: data.tipoSenha == 'Padrão',
                onTap: () {
                  setState(() {
                    data.tipoSenha = 'Padrão';
                    data.senha = '';
                  });
                },
              ),

              _buildGlowingCard(
                label: "PIN",
                icon: Icon(
                  Icons.pin,
                  size: 20,
                  color: data.tipoSenha == 'PIN'
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                ),
                isSelected2: data.tipoSenha == 'PIN',
                onTap: () {
                  setState(() {
                    data.tipoSenha = 'PIN';
                    data.senhaPadrao = null;
                  });
                },
              ),

              _buildGlowingCard(
                label: "Senha",
                icon: Icon(
                  Icons.password,
                  size: 20,
                  color: data.tipoSenha == 'Senha'
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                ),
                isSelected2: data.tipoSenha == 'Senha',
                onTap: () {
                  setState(() {
                    data.tipoSenha = 'Senha';
                    data.senhaPadrao = null;
                  });
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _tipoAparelhoSelector() {

    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none, // Permite que a sombra apareça sem cortes
        child: Row(
          children: tipoDeAparelho.map((tipo) {
            final _isSelected = widget.data.tipoAparelho == tipo;

            return Padding(
              padding: const EdgeInsets.only(right: 12.0, bottom: 8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (!widget.data.checkAssinatura) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PremiumPage()),
                      );
                      widget.data.tipoAparelho = 'Celular';
                      return;
                    }
                    widget.data.tipoAparelho = tipo;
                    setState(() {
                      widget.data.marca = '';
                    });
                    //marcaController.clear();
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: _isSelected
                        ? theme.primary
                        : theme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(30), // Formato de pílula
                    border: Border.all(
                      color: _isSelected
                          ? Theme.of(context).colorScheme.primary
                          : theme.onPrimaryContainer.withValues(alpha: 0.5),
                      width: 1.0,
                    ),
                    boxShadow: _isSelected
                        ? [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ] : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Seu ícone customizado
                      DeviceIcon(
                        tipo: tipo,
                        size: 20,
                        color: _isSelected
                            ? Colors.white
                            : theme.onPrimaryContainer
                        // Dica: Se o seu DeviceIcon aceitar a propriedade 'color',
                        // você pode mudar a cor dele para branco quando estiver selecionado:
                        // color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tipo,
                        style: TextStyle(
                          color: _isSelected ? Colors.white : theme.onPrimaryContainer,
                          fontWeight: _isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                      // Ícone da coroa exibido caso a condição seja atendida
                      if (!widget.data.checkAssinatura) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          RemixIcon.vipCrownLine,
                          color: Colors.amber,
                          size: 14,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

// Widget extraído para manter o código limpo e reaproveitável
  Widget _buildGlowingCard({
    required String label,
    required Widget icon,
    required bool isSelected2,
    required VoidCallback onTap,
  }) {
    // Defina as cores vibrantes aqui

    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected2
              ? theme.primary
              : theme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(30), // Formato de pílula
          border: Border.all(
            color: isSelected2
                ? Theme.of(context).colorScheme.primary
                : theme.onPrimaryContainer.withValues(alpha: 0.5),
            width: 1.0,
          ),
          boxShadow: isSelected2
              ? [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected2 ? Colors.white : Colors.grey.shade700,
                fontWeight: isSelected2 ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Utilitários =====

  void onChanged(bool? value) {
    setState(() {
      //widget.data.mode = value!;
      //widget.data.valueFornecedor = value ? 'visivel' : 'oculto';
      //pecasUtilizadasController.text = '';
      widget.data.pecasUtilizadas = '';
    });
  }

  Widget _dadosFornecedor() {
    final Icon iconLock = Icon(
      Icons.lock,
      size: 20,
      color: Theme.of(context).colorScheme.primary,
    );

    final data = widget.data;

    return Column(
      children: [

        CustomDBFF(
          labelText:
              data.fornecedoresList.isEmpty
                  ? 'Nenhum fornecedor cadastrado'
                  : 'Selecione um fornecedor',
          labelColor:
              data.fornecedoresList.isEmpty
                  ? Colors.grey
                  : Theme.of(context).colorScheme.onSurface,
          suffixIcon: null,
          initialValue: data.fornecedor.isEmpty ? null : data.fornecedor,
          onChanged: (value) {
            setState(() {
              widget.data.fornecedor = value ?? '';
            });
          },
          items:
              data.fornecedoresList.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
        ),
      ],
    );
  }

}
