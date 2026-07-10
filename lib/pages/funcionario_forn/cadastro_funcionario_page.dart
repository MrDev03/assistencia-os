import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/elevated_button.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 🔥 Enum para saber se estamos lidando com Atendente ou Técnico
enum TipoFuncionario { atendente, tecnico, fornecedor }

class CadastroFuncionarioPage extends StatefulWidget {
  final TipoFuncionario tipo;

  // Usamos 'dynamic' para aceitar tanto Atendente quanto Tecnicos
  // Se for null, a tela entra no modo de CRIAÇÃO.
  final dynamic funcionario;

  const CadastroFuncionarioPage({
    super.key,
    required this.tipo,
    this.funcionario,
  });

  @override
  State<CadastroFuncionarioPage> createState() => _CadastroFuncionarioPageState();
}

class _CadastroFuncionarioPageState extends State<CadastroFuncionarioPage> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final numeroController = TextEditingController();
  final salarioController = TextEditingController();
  final comissaoController = TextEditingController();
  final metaController = TextEditingController();
  final experienciaController = TextEditingController();
  final obsController = TextEditingController();

  // 🔥 1. Variáveis para guardar o estado original
  late String _originalNome;
  late String _originalNumero;
  late String _originalSalario;
  late String _originalComissao;
  late String _originalMeta;
  late String _originalExperiencia;
  late String _originalObs;

  bool isEdit = false;
  late final modeEdit = ValueNotifier<bool>(isEdit);

  bool get isEdicao => widget.funcionario != null;
  String get labelSingular => widget.tipo == TipoFuncionario.atendente ? 'Atendente' : 'Técnico';
  //bool get podeSalvar => modeEdit.value;

  @override
  void initState() {
    super.initState();
    _preencherCamposSeEdicao();

    // 🔥 2. Captura os valores originais exatos que estão nos controllers
    _originalNome = nomeController.text;
    _originalNumero = numeroController.text;
    _originalSalario = salarioController.text;
    _originalComissao = comissaoController.text;
    _originalMeta = metaController.text;
    _originalExperiencia = experienciaController.text;
    _originalObs = obsController.text;
  }

  void _preencherCamposSeEdicao() {
    if (isEdicao) {
      final f = widget.funcionario!;

      // O 'dynamic' permite ler os campos comuns às duas classes
      nomeController.text = f.nome ?? '';
      numeroController.text = f.numero ?? '';
      experienciaController.text = f.tempoExperiencia ?? '';
      obsController.text = f.observacoes ?? '';

      if (f.salario != null) {
        salarioController.text = UtilBrasilFields.obterReal(f.salario!);
      }
      if (f.metaMensal != null) {
        metaController.text = UtilBrasilFields.obterReal(f.metaMensal!);
      }
      if (f.comissao != null) {
        comissaoController.text = f.comissao!.toStringAsFixed(2).replaceAll('.', ',');
      }
    }
  }

  void _retornarDados() {
    if (!_formKey.currentState!.validate()) return;

    // Converte os valores monetários/decimais
    final salario = salarioController.text.isNotEmpty
        ? UtilBrasilFields.converterMoedaParaDouble(salarioController.text) : null;

    final meta = metaController.text.isNotEmpty
        ? UtilBrasilFields.converterMoedaParaDouble(metaController.text) : null;

    final comissao = comissaoController.text.isNotEmpty
        ? double.tryParse(comissaoController.text.replaceAll(',', '.')) : null;

    // 🔥 Monta um Map com os dados preenchidos
    final dadosFormulario = {
      'nome': nomeController.text.trim(),
      'numero': numeroController.text.trim(),
      'salario': salario,
      'comissao': comissao,
      'metaMensal': meta,
      'tempoExperiencia': experienciaController.text.trim(),
      'observacoes': obsController.text.trim(),
    };

    // Retorna os dados para a tela anterior
    Navigator.pop(context, dadosFormulario);
  }

  String num2 = '';

  // 🔥 3. Nova função de validação global
  void _verificarAlteracoes() {
    // 1. Verifica se os campos obrigatórios estão preenchidos corretamente
    final bool nomeValido = nomeController.text.trim().isNotEmpty;
    final bool numeroValido = numeroController.text.length >= 14;
    final bool isValido = nomeValido && numeroValido;

    if (!isEdicao) {
      // Se for CRIAÇÃO, o botão liga se os campos obrigatórios estiverem preenchidos
      modeEdit.value = isValido;
      return;
    }

    // 2. Se for EDIÇÃO, verifica se pelo menos UM campo está diferente do original
    final bool houveAlteracao =
        nomeController.text != _originalNome ||
            num2 != _originalNumero ||
            salarioController.text != _originalSalario ||
            comissaoController.text != _originalComissao ||
            metaController.text != _originalMeta ||
            experienciaController.text != _originalExperiencia ||
            obsController.text != _originalObs;

    // O botão de salvar edições só acende se o form for válido E tiver alteração
    modeEdit.value = isValido && houveAlteracao;
  }

  @override
  Widget build(BuildContext context) {

    final func = widget.funcionario;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdicao ? 'Editar $labelSingular' : 'Novo $labelSingular'),
        centerTitle: true,
        leading: AppbarBtn(onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(
                        title: 'Informações Pessoais',
                        children: [

                          CustomTextField(
                            controller: nomeController,
                            labelText: 'Nome Completo *',
                            hintText: 'Digite o nome',
                            validator: (val) => val == null || val.isEmpty ? 'Campo obrigatório' : null,
                            onChanged: (v) => _verificarAlteracoes(),
                          ),

                          CustomTextField(
                            controller: numeroController,
                            labelText: 'Número de Contato *',
                            hintText: '(00) 00000-0000',
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                            validator: (val) => val == null || val.length < 14 ? 'Telefone inválido' : null,
                            onChanged: (v) {
                              num2 = v;
                              _verificarAlteracoes();
                              //v != _originalNumero ? modeEdit.value = true : false;
                              print('NUMERO ${num2}');
                              print('NUMERO ORI $_originalNumero');
                            },

                          ),

                        ]
                      ),

                      _buildSectionTitle(
                        title: 'Dados Profissionais',
                        children: [
                          Row(
                            spacing: 15,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: salarioController,
                                  labelText: 'Salário Base',
                                  hintText: 'R\$ 0,00',
                                  maxLenght: 12,
                                  counterText: '',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CentavosInputFormatter(moeda: true),
                                  ],
                                  onChanged: (v) => _verificarAlteracoes(),
                                ),
                              ),

                              Expanded(
                                child: CustomTextField(
                                  controller: comissaoController,
                                  labelText: 'Comissão (%)',
                                  hintText: 'Ex: 5,0',
                                  suffixIcon: const Icon(Icons.percent_outlined, size: 18),
                                  maxLenght: 3,
                                  counterText: '',
                                  onChanged: (value) {
                                    _verificarAlteracoes();
                                    final numero = double.tryParse(value);
                                    if (numero != null && numero > 100) {
                                      comissaoController.text = '100';
                                      comissaoController.selection = TextSelection.fromPosition(const TextPosition(offset: 3));
                                    }
                                  },
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                ),
                              ),
                            ],
                          ),

                          CustomTextField(
                            controller: metaController,
                            labelText: 'Meta Mensal',
                            hintText: 'R\$ 0,00',
                            keyboardType: TextInputType.number,
                            maxLenght: 13,
                            counterText: '',
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CentavosInputFormatter(moeda: true),
                            ],
                            onChanged: (v) => _verificarAlteracoes(),
                          ),

                          CustomTextField(
                            controller: experienciaController,
                            labelText: 'Tempo de Experiência',
                            maxLenght: 50,
                            counterText: '',
                            hintText: 'Ex: 1 ano e 2 meses, Júnior...',
                            onChanged: (v) => _verificarAlteracoes(),
                          ),

                        ]
                      ),

                      _buildSectionTitle(
                        title: 'Informações Adicionais',
                        children: [

                          CustomTextField(
                            controller: obsController,
                            labelText: 'Observações',
                            hintText: 'Anotações gerais...',
                            maxLines: 3,
                            maxLenght: 250,
                            onChanged: (v) => _verificarAlteracoes(),
                          ),

                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,16,16),
              child: ValueListenableBuilder<bool>(
                valueListenable: modeEdit,
                builder: (context, podeSalvar, child) {
                  return CustomElevatedButton(
                    label: isEdicao ? "Salvar Alterações" : "Cadastrar",
                    click: podeSalvar ? _retornarDados : null, // 🔥 Chama a função que devolve o objeto
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 24, bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        CustomCard(
          padding: const EdgeInsets.fromLTRB(16,0,16,16),
          child: Column(
            children: children
          ),
        ),
      ],
    );
  }
}