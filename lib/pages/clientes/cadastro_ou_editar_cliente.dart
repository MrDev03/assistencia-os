import 'dart:convert';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/card_aviso.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assistencia_os/custom_widgets/elevated_button.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:http/http.dart' as http;
import '../../custom_widgets/appbar_btn.dart';
import '../../db_helper/db_helper.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../../sync/modules/cliente_sync.dart'; // Necessário para consulta de CEP

class CadastroEditarCliente extends StatefulWidget {
  final Cliente? cliente;

  const CadastroEditarCliente({super.key, this.cliente});

  @override
  _CadastroEditarClienteState createState() => _CadastroEditarClienteState();
}

class _CadastroEditarClienteState extends State<CadastroEditarCliente> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controllers
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final ruaController = TextEditingController();
  final numeroController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();
  final cepController = TextEditingController();

  // Estado
  bool _isLoading = false;
  bool _formWasEdited = false; // Para alertar ao sair sem salvar

  //late SyncService syncService;
  final syncCliente = ClienteSync();

  @override
  void initState() {
    super.initState();

    if (widget.cliente != null) {
      preencherCampos(widget.cliente!);
    }

    // Listener para marcar formulário como editado
    void markAsEdited() {
      if (!_formWasEdited) setState(() => _formWasEdited = true);
    }
    nomeController.addListener(markAsEdited);
    telefoneController.addListener(markAsEdited);
    // ... adicione para outros campos se desejar rigoroso controle
  }

  void preencherCampos(Cliente cliente) {
    nomeController.text = cliente.nome ?? '';
    telefoneController.text = cliente.telefone ?? '';
    cpfController.text = cliente.cpf ?? '';
    emailController.text = cliente.email ?? '';
    ruaController.text = cliente.rua ?? '';
    numeroController.text = cliente.numero ?? '';
    bairroController.text = cliente.bairro ?? '';
    cidadeController.text = cliente.cidade ?? '';
    estadoController.text = cliente.estado ?? '';
    cepController.text = cliente.cep ?? '';
  }

  @override
  void dispose() {
    nomeController.dispose();
    telefoneController.dispose();
    cpfController.dispose();
    emailController.dispose();
    ruaController.dispose();
    numeroController.dispose();
    bairroController.dispose();
    cidadeController.dispose();
    estadoController.dispose();
    cepController.dispose();
    super.dispose();
  }

  // --- Lógica de Negócio ---

  Future<void> buscarCep() async {
    String cep = cepController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cep.length != 8) {
      AppFlushbar.warning('CEP inválido para busca.');
      //_showSnack('CEP inválido para busca.', Colors.orange);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('erro')) {
          AppFlushbar.error('CEP não encontrado.');
        } else {
          setState(() {
            ruaController.text = data['logradouro'] ?? '';
            bairroController.text = data['bairro'] ?? '';
            cidadeController.text = data['localidade'] ?? '';
            estadoController.text = data['uf'] ?? '';
          });
          // Move o foco para o número
          if (!mounted) return;
          FocusScope.of(context).nextFocus();
        }
      }
    } catch (e) {
      AppFlushbar.error('Erro ao buscar CEP. Verifique sua conexão.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> salvarCliente() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final String date = "${UtilData.obterDataDDMMAAAA(DateTime.now())} • ${UtilData.obterHoraHHMM(DateTime.now())}";

      final cliente = Cliente()
        ..nome = nomeController.text.trim()
        ..telefone = telefoneController.text
        ..cpf = cpfController.text
        ..email = emailController.text.trim()
        ..rua = ruaController.text.trim()
        ..numero = numeroController.text.trim()
        ..bairro = bairroController.text.trim()
        ..cidade = cidadeController.text.trim()
        ..estado = estadoController.text.trim().toUpperCase()
        ..cep = cepController.text
        ..dataCadastro = widget.cliente?.dataCadastro ?? date
        ..createdAt = widget.cliente?.createdAt ?? DateTime.now();

      if (widget.cliente != null) {
        cliente.id = widget.cliente!.id;
      }

      final isar = DatabaseHelper.isar;
      await isar.writeTxn(() async {
        await isar.clientes.put(cliente);
      });

      // Sincroniza com Firebase (dentro do try para garantir envio)
      //await syncService.syncClienteToFirebase(cliente);
      await syncCliente.push(cliente);

      if (!mounted) return;

      AppFlushbar.success(widget.cliente == null ? 'Cliente cadastrado!' : 'Cliente atualizado!');

      _formWasEdited = false; // Reseta flag para permitir sair
      Navigator.pop(context, cliente);

    } catch (e) {
      AppFlushbar.error('Erro ao salvar');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color, behavior: SnackBarBehavior.floating),
    );
  }

  Future<bool> _onWillPop() async {
    if (!_formWasEdited) return true;

    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Descartar alterações?'),
        content: const Text('Você tem alterações não salvas. Deseja sair mesmo assim?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Não')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Sim')),
        ],
      ),
    );
    return shouldPop ?? false;
  }

  // --- Widgets de UI ---

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isEditing = widget.cliente != null;

    return PopScope(
      canPop: !_formWasEdited,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final bool shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(isEditing ? 'Editar Cliente' : 'Novo Cliente'),
          leading: AppbarBtn(
            icon: Icons.arrow_back_ios_new,
            onPressed: () async {
              final bool shouldPop = await _onWillPop();
              if (shouldPop && context.mounted) {
                Navigator.of(context).pop();
              }
            }
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800), // Limita largura em telas grandes
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildHeaderCard(
                            Theme.of(context).colorScheme,
                          ),
                          // const CardAviso(
                          //   message: "Preencha os campos abaixo. Campos marcados com (*) são obrigatórios.",
                          // ),
                          const SizedBox(height: 16),
                          _buildFormCard(theme),
                          const SizedBox(height: 24),
                          _buildSaveButton(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                Container(
                  color: Colors.black45,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(ColorScheme theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: theme.primary),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Preencha os campos abaixo. Campos marcados com (*) são obrigatórios.",
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(ColorScheme theme) {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Dados Pessoais', Icons.person, theme),
          const SizedBox(height: 15),

          CustomTextField(
            controller: nomeController,
            labelText: 'Nome do Cliente',
            requiredTxt: ' *',
            hintText: 'Nome completo',
            maxLenght: 50,
            capitalization: TextCapitalization.words,
            prefixIcon: const Icon(Icons.person_outline), // Supondo que seu CustomTextField aceite prefixIcon
            validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
          ),

          // Layout responsivo: Telefone e CPF na mesma linha se houver espaço
          LayoutBuilder(builder: (context, constraints) {
            return constraints.maxWidth > 500
                ? Row(
              children: [
                Expanded(child: _buildTelefoneField()),
                const SizedBox(width: 16),
                Expanded(child: _buildCpfField()),
              ],
            )
                : Column(
              children: [
                _buildTelefoneField(),
                _buildCpfField(),
              ],
            );
          }),

          CustomTextField(
            controller: emailController,
            labelText: 'Email',
            hintText: 'exemplo@email.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
          ),

          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),

          _buildSectionTitle('Endereço', Icons.location_on, theme),
          const SizedBox(height: 15),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: cepController,
                  labelText: 'CEP',
                  hintText: '00000-000',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter()
                  ],
                  onChanged: (val) {
                    if (val.length >= 10) buscarCep();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 8.0), // Ajuste visual
                child: IconButton.filledTonal(
                  onPressed: _isLoading ? null : buscarCep,
                  icon: const Icon(Icons.search),
                  tooltip: 'Buscar Endereço',
                ),
              )
            ],
          ),

          LayoutBuilder(builder: (context, constraints) {
            // Lógica para responsividade
            bool isWide = constraints.maxWidth > 500;
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        controller: ruaController,
                        labelText: 'Rua',
                        hintText: 'Logradouro',
                        maxLenght: 60,
                        capitalization: TextCapitalization.sentences,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        controller: numeroController,
                        labelText: 'Nº',
                        hintText: '123',
                        keyboardType: TextInputType.number,
                        maxLenght: 6,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                  ],
                ),

                isWide
                    ? Row(
                  children: [
                    Expanded(child: _buildBairroField()),
                    const SizedBox(width: 12),
                    Expanded(child: _buildCidadeField()),
                    const SizedBox(width: 12),
                    SizedBox(width: 80, child: _buildEstadoField()),
                  ],
                )
                    : Column(
                  children: [
                    _buildBairroField(),
                    _buildCidadeField(),
                    _buildEstadoField(),
                  ],
                )
              ],
            );
          }),
        ],
      ),
    );
  }

  // --- Sub-widgets para limpar o código ---

  Widget _buildTelefoneField() {
    return CustomTextField(
      controller: telefoneController,
      labelText: 'Telefone',
      requiredTxt: ' *',
      hintText: '(00) 00000-0000',
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TelefoneInputFormatter(),
      ],
      validator: (value) {
        if (value!.isEmpty) return 'Informe o telefone';
        if (value.length < 14) return 'Inválido';
        return null;
      },
    );
  }

  Widget _buildCpfField() {
    return CustomTextField(
      controller: cpfController,
      labelText: 'CPF',
      hintText: '000.000.000-00',
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CpfInputFormatter()
      ],
    );
  }

  Widget _buildBairroField() => CustomTextField(
    hintText: 'Bairro',
    controller: bairroController,
    labelText: 'Bairro',
    maxLenght: 30,
    capitalization: TextCapitalization.sentences,
  );

  Widget _buildCidadeField() => CustomTextField(
    hintText: 'Cidade',
    controller: cidadeController,
    labelText: 'Cidade',
    maxLenght: 30,
    capitalization: TextCapitalization.sentences,
  );

  Widget _buildEstadoField() => CustomTextField(
    hintText: 'UF',
    controller: estadoController,
    labelText: 'UF',
    maxLenght: 2,
    capitalization: TextCapitalization.characters,
  );

  Widget _buildSectionTitle(String title, IconData icon, ColorScheme theme) {
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomElevatedButton(
        label: widget.cliente != null ? 'Atualizar Dados' : 'Salvar Cadastro',
        click: _isLoading ? null : salvarCliente, // Desabilita se carregando
        posicao: IconAlignment.start,
        icon: _isLoading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}