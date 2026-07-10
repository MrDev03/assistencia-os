import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Seus imports personalizados mantidos
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/pages/service_registration/models/data_cadastro.dart';
import '../../configs/search_color.dart';
import '../../custom_widgets/lateral_iconbutom.dart';
import '../../custom_widgets/text_field.dart';
import '../../custom_widgets/top_msg.dart';
import '../../db_helper/db_helper.dart';
import '../../models/cliente_model/cliente_model.dart';

class ClienteStep extends StatefulWidget {
  final DataCliente data;
  final GlobalKey<FormState>? formKey;

  const ClienteStep({
    super.key,
    required this.data,
    this.formKey,
  });

  @override
  State<ClienteStep> createState() => _ClienteStepState();
}

class _ClienteStepState extends State<ClienteStep> {
  // Todos declarados corretamente para evitar Memory Leaks
  late final TextEditingController nomeController;
  late final TextEditingController telefoneController;
  late final TextEditingController cpfController;
  late final TextEditingController emailController;
  late final TextEditingController ruaController;
  late final TextEditingController numeroController;
  late final TextEditingController bairroController;
  late final TextEditingController cidadeController;
  late final TextEditingController estadoController;
  late final TextEditingController cepController;

  List<Cliente> listaClientes = [];
  bool _isLoading = false;
  bool _isSearchingCep = false; // Evita requisições simultâneas ao ViaCEP

  bool get clienteExistente => widget.data.clienteId != null;

  @override
  void initState() {
    super.initState();

    // Inicialização segura de todos os controllers
    nomeController = TextEditingController(text: widget.data.nome);
    telefoneController = TextEditingController(text: widget.data.telefone);
    cpfController = TextEditingController(text: widget.data.cpf ?? '');
    emailController = TextEditingController(text: widget.data.email ?? '');
    ruaController = TextEditingController(text: widget.data.rua ?? '');
    numeroController = TextEditingController(text: widget.data.numero ?? '');
    bairroController = TextEditingController(text: widget.data.bairro ?? '');
    cidadeController = TextEditingController(text: widget.data.cidade ?? '');
    estadoController = TextEditingController(text: widget.data.estado ?? '');
    cepController = TextEditingController(text: widget.data.cep ?? '');

    carregarClientes();
  }

  @override
  void dispose() {
    // Garante a liberação de TODOS os controllers da memória
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

  Future<void> carregarClientes() async {
    try {
      listaClientes = await DatabaseHelper.getAllClientes();
      if (mounted) setState(() {});
    } catch (e) {
      AppFlushbar.error('Erro ao carregar clientes do banco.');
    }
  }

  Future<void> buscarCep() async {
    if (_isSearchingCep) return; // Trava se já houver uma busca em andamento

    String cep = cepController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cep.length != 8) {
      AppFlushbar.warning('CEP inválido para busca.');
      return;
    }

    setState(() {
      _isLoading = true;
      _isSearchingCep = true;
    });

    try {
      final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
      final response = await http.get(url).timeout(const Duration(seconds: 7));

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
          if (!mounted) return;
          FocusScope.of(context).nextFocus();
        }
      }
      salvarDadosNoObjeto();
    } catch (e) {
      AppFlushbar.error('Erro ao buscar CEP. Verifique sua conexão.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isSearchingCep = false;
        });
      }
    }
  }

  /// Método utilitário para você chamar antes de mudar de página
  /// Substitui os múltiplos listeners pesados do initState
  void salvarDadosNoObjeto() {
    widget.data.nome = nomeController.text;
    widget.data.telefone = telefoneController.text;
    widget.data.cpf = cpfController.text;
    widget.data.email = emailController.text;
    widget.data.rua = ruaController.text;
    widget.data.numero = numeroController.text;
    widget.data.bairro = bairroController.text;
    widget.data.cidade = cidadeController.text;
    widget.data.estado = estadoController.text;
    widget.data.cep = cepController.text;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final searchColor = context.appbarButtonColor;

    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: CustomCard(
            borderRadius: 30,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: widget.formKey,
              child: Column(
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          // decoration: BoxDecoration(
                          //   color: theme.primary.withValues(alpha: 0.2),
                          //   borderRadius: BorderRadius.circular(30),
                          // ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: theme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person_outline, color: Colors.white, size: 20),
                              ),
                              const Spacer(),
                              const Text(
                                'Informações do Cliente',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  //color: theme.onPrimaryContainer,
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: theme.primary.withValues(alpha: 0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _refreshCampos,
                        icon: const Icon(Icons.refresh),
                        color: theme.onPrimaryContainer,
                        tooltip: 'Limpar campos',
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  // COMPONENTE DE BUSCA TOTALMENTE OTIMIZADO
                  TypeAheadField<Cliente>(
                    debounceDuration: const Duration(milliseconds: 300), // Aguarda usuário parar de digitar
                    direction: VerticalDirection.up,
                    controller: nomeController,
                    loadingBuilder: (context) => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    emptyBuilder: (context) => const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Nenhum cliente encontrado ❌',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    decorationBuilder: (context, child) {
                      return Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        clipBehavior: Clip.antiAlias,
                        color: searchColor,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: child,
                        ),
                      );
                    },
                    suggestionsCallback: (search) async {
                      if (search.trim().isEmpty) return [];
                      final query = search.toLowerCase().trim();

                      // Filtra protegendo contra nulos e limita a 15 itens na tela
                      return listaClientes
                          .where((cliente) => cliente.nome?.toLowerCase().contains(query) ?? false)
                          .take(15)
                          .toList();
                    },
                    builder: (context, controller, focusNode) {
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: 'Nome do Cliente',
                          hintText: 'Digite o nome',
                        ),
                        onChanged: (text) => widget.data.nome = text,
                        enabled: !clienteExistente,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o nome do cliente';
                          }
                          return null;
                        },
                      );
                    },
                    itemBuilder: (context, cliente) {
                      return ListTile(
                        title: Text(
                          cliente.nome ?? 'Sem nome',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(cliente.telefone ?? 'Sem telefone'),
                        leading: const Icon(Icons.person),
                      );
                    },
                    onSelected: (cliente) => setState(() => _selectSugestao(cliente)),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: telefoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Telefone',
                      hintText: '(00) 00000-0000',
                    ),
                    enabled: !clienteExistente,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o telefone';
                      } else if (value.length < 14) {
                        return 'Telefone inválido';
                      }
                      return null;
                    },
                    onChanged: (text) => widget.data.telefone = text,
                  ),

                  const SizedBox(height: 16),

                  ExpansionTile(
                      collapsedBackgroundColor: theme.primary.withValues(alpha: 0.1),
                      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      splashColor: theme.primary.withValues(alpha: 0.3),
                      textColor: theme.onPrimaryContainer,
                      collapsedTextColor: theme.onPrimaryContainer,
                      collapsedIconColor: theme.onPrimaryContainer,
                      enableFeedback: false,
                      title: const Text(
                        'Informações adicionais',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      children: [
                        const SizedBox(height: 8),
                        _buildAddInfo()
                      ]
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _refreshCampos() {
    setState(() {
      nomeController.clear();
      telefoneController.clear();
      cpfController.clear();
      emailController.clear();
      ruaController.clear();
      numeroController.clear();
      bairroController.clear();
      cidadeController.clear();
      estadoController.clear();
      cepController.clear();
      widget.data.clienteId = null;
    });
  }

  void _selectSugestao(Cliente cliente) {
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

    widget.data.clienteId = cliente.id;
    salvarDadosNoObjeto();
  }

  Widget _buildAddInfo() {
    return Column(
      children: [
        CustomTextField(
          controller: cpfController,
          labelText: 'CPF',
          hintText: '000.000.000-00',
          keyboardType: TextInputType.number,
          enabled: !clienteExistente,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, CpfInputFormatter()],
          onChanged: (text) => widget.data.cpf = text,
        ),
        CustomTextField(
          controller: emailController,
          labelText: 'E-mail',
          hintText: 'exemplo@email.com',
          keyboardType: TextInputType.emailAddress,
          onChanged: (text) => widget.data.email = text,
          enabled: !clienteExistente,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CustomTextField(
                controller: cepController,
                labelText: 'CEP',
                hintText: '00000-000',
                keyboardType: TextInputType.number,
                enabled: !clienteExistente,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, CepInputFormatter()],
                onChanged: (val) {
                  // Ajustado para disparar apenas quando a máscara do CEP estiver completa (9 dígitos: 00000-000)
                  widget.data.cep = val;
                  if (val.length == 9) buscarCep();
                },
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: LateralIconbutom(
                onPressed: _isLoading || clienteExistente ? null : buscarCep,
                icon: _isLoading
                    ? LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                )
                    : const Icon(Icons.search),
                tooltip: 'Buscar Endereço',
              ),
            )
          ],
        ),
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
                enabled: !clienteExistente,
                onChanged: (text) => widget.data.rua = text,
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
                enabled: !clienteExistente,
                onChanged: (text) => widget.data.numero = text,
              ),
            ),
          ],
        ),
        CustomTextField(
          hintText: 'Bairro',
          controller: bairroController,
          labelText: 'Bairro',
          maxLenght: 30,
          capitalization: TextCapitalization.sentences,
          onChanged: (text) => widget.data.bairro = text,
          enabled: !clienteExistente,
        ),
        CustomTextField(
          hintText: 'Cidade',
          controller: cidadeController,
          labelText: 'Cidade',
          maxLenght: 30,
          capitalization: TextCapitalization.sentences,
          onChanged: (text) => widget.data.cidade = text,
          enabled: !clienteExistente,
        ),
        CustomTextField(
          hintText: 'UF',
          controller: estadoController,
          labelText: 'UF',
          maxLenght: 2,
          capitalization: TextCapitalization.characters,
          onChanged: (text) => widget.data.estado = text,
          enabled: !clienteExistente,
        ),
      ],
    );
  }
}