import 'dart:io';
import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/assinatura.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/dialog.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:assistencia_os/pages/home/home.dart';
import 'package:assistencia_os/providers/notifier.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar_community/isar.dart';

import '../../custom_widgets/loading_widget.dart';
import '../../custom_widgets/top_msg.dart';
import '../../db_helper/db_helper.dart';
import '../../models/empresa_model/empresa_model.dart';
import '../../sync/modules/empresa_sync.dart';
// Seu arquivo com DatabaseHelper e Empresa

class EditarEmpresaPage extends StatefulWidget {
  final Empresa? empresa;

  const EditarEmpresaPage({super.key, this.empresa});

  @override
  State<EditarEmpresaPage> createState() => _EditarEmpresaPageState();
}

class _EditarEmpresaPageState extends State<EditarEmpresaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final syncEmpresa = EmpresaSync();


  late TextEditingController nomeController;
  late TextEditingController cnpjController;
  late TextEditingController telefone1Controller;
  late TextEditingController telefone2Controller;
  late TextEditingController enderecoController;
  late TextEditingController garantiaController;
  late TextEditingController politicaPrivacidadeController;
  late TextEditingController sloganController;
  late TextEditingController emailController;
  List<int>? logoBytes;
  List<int>? _assinatura;

  //String? logoPath;

  // Valores originais
  late String originalNome;
  late String originalCnpj;
  late String originalTelefone1;
  late String originalTelefone2;
  late String originalEndereco;
  late String originalGarantia;
  late String originalPrivacidade;
  late String originalSlogan;
  late String? originalLogo;
  late String? originalEmail;
  List<int>? originalAssinatura;
  List<int>? originalLogoBytes;

  @override
  void initState() {
    super.initState();

    final empresa = widget.empresa;

    nomeController = TextEditingController(text: empresa?.nome ?? '');
    cnpjController = TextEditingController(text: empresa?.cnpj ?? '');
    telefone1Controller = TextEditingController(text: empresa?.telefone1 ?? '');
    telefone2Controller = TextEditingController(text: empresa?.telefone2 ?? '');
    enderecoController = TextEditingController(text: empresa?.endereco ?? '');
    garantiaController = TextEditingController(text: empresa?.politicaGarantia ?? '');
    //logoPath = (empresa?.logoUrl != null && empresa!.logoUrl!.isNotEmpty) ? empresa.logoUrl : null;
    sloganController = TextEditingController(text: empresa?.slogan ?? '');
    _assinatura = empresa?.assinatura;
    emailController = TextEditingController(text: empresa?.email ?? '');
    logoBytes = empresa?.logoBytes;

    politicaPrivacidadeController = TextEditingController(text: empresa?.politicaPrivacidade ?? '');
    // Guardar os valores originais
    originalNome = nomeController.text;
    originalCnpj = cnpjController.text;
    originalTelefone1 = telefone1Controller.text;
    originalTelefone2 = telefone2Controller.text;
    originalEndereco = enderecoController.text;
    originalGarantia = garantiaController.text;
    originalPrivacidade = politicaPrivacidadeController.text;
    originalSlogan = sloganController.text;
    originalAssinatura = _assinatura;
    originalEmail = emailController.text;
    originalLogoBytes = empresa?.logoBytes;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nomeController.dispose();
    cnpjController.dispose();
    telefone1Controller.dispose();
    telefone2Controller.dispose();
    enderecoController.dispose();
    garantiaController.dispose();
    politicaPrivacidadeController.dispose();
    sloganController.dispose();
    emailController.dispose();
    //logoPath = null;

  }

  bool get houveAlteracao {
    return nomeController.text != originalNome ||
        cnpjController.text != originalCnpj ||
        telefone1Controller.text != originalTelefone1 ||
        telefone2Controller.text != originalTelefone2 ||
        enderecoController.text != originalEndereco ||
        garantiaController.text != originalGarantia ||
        politicaPrivacidadeController.text != originalPrivacidade ||
        sloganController.text != originalSlogan ||
        emailController.text != originalEmail ||
        !listEquals(_assinatura, originalAssinatura) ||
        !listEquals(logoBytes, originalLogoBytes);
  }

  // @override
  // void dispose() {
  //   politicaPrivacidadeController.dispose();
  //   super.dispose();
  // }

  Future<void> _abrirAssinatura(BuildContext context) async {
    AssinaturaBottomSheet.mostrar(
      context,
      onSalvar: (List<int>? novaAssinatura) {
        if (novaAssinatura != null) {
          setState(() {
            _assinatura = novaAssinatura;
          });
          // ou notifier.atualizar(); dependendo de como você gerencia o estado
        }
      },
    );
  }

  Future<void> selecionarImagem(Isar db, int empresaId) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();

      // await db_helper.writeTxn(() async {
      //   final empresa = await db_helper.empresas.get(empresaId);
      //   if (empresa != null) {
      //     empresa.logoBytes = bytes;
      //     await db_helper.empresas.put(empresa);
      //   }
      // });
      setState(() {
        logoBytes = bytes;
      });
    }
    // 🔥 força rebuild da UI após salvar
  }

  Future<void> salvar(BuildContext context) async {
    // 1. Validação
    if (!_formKey.currentState!.validate()) return;

    // 2. Mostrar o Loading (Bloqueia a tela)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingWidget(
        message: [
          'Salvando alterações',
          'Atualizando dados',
          'Sincronizando...',
        ],
      ),
    );

    try {
      // 3. Montar o objeto (Mesma lógica anterior)
      final empresa = Empresa()
        ..nome = nomeController.text
        ..cnpj = cnpjController.text
        ..telefone1 = telefone1Controller.text
        ..telefone2 = telefone2Controller.text
        ..endereco = enderecoController.text
        ..politicaGarantia = garantiaController.text
        ..politicaPrivacidade = politicaPrivacidadeController.text
        ..slogan = sloganController.text
        ..email = emailController.text
        ..logoBytes = logoBytes
        ..createdAt = widget.empresa?.createdAt ?? DateTime.now()
        ..assinatura = _assinatura;

      final isar = DatabaseHelper.isar;

      // 4. Salvar no Isar (Local)
      await isar.writeTxn(() async {
        await isar.empresas.put(empresa);
      });

      notifier.atualizar(); // Atualiza a UI local

      // 5. Salvar no Firebase (Agora com await para segurar o loading)
      await syncEmpresa.push(empresa);

      if (!context.mounted) return;

      // 6. Fechar o Loading Dialog
      // O primeiro pop remove o Dialog da pilha
      Navigator.of(context).pop();

      // 7. Fechar a Tela de Cadastro e dar Sucesso
      // O segundo pop fecha a tela do formulário
      Navigator.of(context).pop(true);

      AppFlushbar.success('Dados salvos e sincronizados com sucesso!');

    } catch (e) {
      // SE DER ERRO:
      if (!context.mounted) return;

      // 1. Fecha o Loading Dialog para não travar o app
      Navigator.of(context).pop();

      // 2. Mostra o erro (mas mantém o usuário na tela de formulário para tentar de novo)
      AppFlushbar.error('Erro ao salvar');
    }
  }

  Widget _dialogo(BuildContext context) {
    return CustomDialog(
      title: 'Descartar alterações?',
      content: 'Você fez alterações que não foram salvas. Deseja sair mesmo assim?',
      onPressedLeft: () => Navigator.pop(context, false),
      onPressedRight: () => Navigator.pop(context, true),
      rightButtonText: 'Sair',
      leftButtonText: 'Cancelar',
    );
  }

  void _deletarAssinatura() {
    setState(() {
      _assinatura = null;
    });
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).colorScheme;
    validate(value) => value == null || value.isEmpty ? 'Campo obrigatório' : null;
    return PopScope(
      canPop: false, // impede sair sem a nossa lógica
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // já saiu normalmente, não precisa tratar

        if (houveAlteracao) {
          final sair = await showDialog<bool>(
            context: context,
            builder: (context) => _dialogo(context),
          );
          if (sair == true) {
            if (!context.mounted) return;
            Navigator.pop(context, result); // força o pop, mantendo o result se existir
          }
        } else {
          Navigator.pop(context, result); // sai normalmente
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: AppbarBtn(
            onPressed: () async {
              if (houveAlteracao) {
                final sair = await showDialog<bool>(
                  context: context,
                  builder: (context) => _dialogo(context),
                );
                if (sair == true) {
                  if (!context.mounted) return;
                  Navigator.pop(context);
                }
              } else {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(widget.empresa == null ? 'Adicionar Empresa' : 'Editar Dados'),
          actions: [
            ValueListenableBuilder(
              valueListenable: notifier,
              builder: (context, value, child) {
                return AppbarBtn(
                  onPressed:
                  houveAlteracao == true ? () {
                    salvar(context);
                  } : null,
                  icon: Icons.save //Icon(Icons.save, color: houveAlteracao == true ? Colors.white : null),
                );
              }
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16,0,16,8),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: context.isDesktop ?
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _bloco1(validate)),
                        const SizedBox(width: 20),
                        Expanded(child: _bloco2(validate)),
                      ],
                    ) : Column(
                  children: [
                    _bloco1(validate),
                    const SizedBox(height: 16),
                    _bloco2(validate),
                  ]
                )
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bloco1 (String? Function(String?) validate) {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              await selecionarImagem(DatabaseHelper.isar, 1);
              setState(() {
              });
            },
            child: buildLogo(
                widget.empresa?.logoBytes ?? [],
                size: 50
            ),
          ),

          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Campos com * são obrigatórios', style: TextStyle(color: Colors.red, fontSize: 12)),
          ),
          CustomTextField(
              controller: nomeController,
              labelText: 'Nome da Empresa',
              requiredTxt: ' *',
              hintText: 'Ex: Mr Celulares',
              obscureText: false,
              validator: validate,
              onChanged: (value) {
                notifier.atualizar();
              }
          ),
          CustomTextField(
            controller: sloganController,
            labelText: 'Slogan',
            hintText: 'Ex: Melhor loja de celulares da região',
            maxLenght: 50,
            onChanged: (value) {
              notifier.atualizar();
            },
          ),
          CustomTextField(
            controller: cnpjController,
            labelText: 'CNPJ',
            hintText: 'Ex: 00.000.000/0000-00',
            obscureText: false,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CnpjInputFormatter(),
            ],
            onChanged: (value) {
              notifier.atualizar();
            },
          ),
          CustomTextField(
              controller: telefone1Controller,
              labelText: 'Telefone 1',
              requiredTxt: ' *',
              hintText: 'Ex: (00) 00000-0000',
              obscureText: false,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
              onChanged: (value) {
                notifier.atualizar();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                if (value.length < 14) {
                  return 'Telefone incompleto!';
                }
                return null;
              }
          ),
          CustomTextField(
              controller: telefone2Controller,
              labelText: 'Telefone 2',
              hintText: 'Ex: (00) 00000-0000',
              obscureText: false,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
              onChanged: (value) {
                notifier.atualizar();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                if (value.length < 14) {
                  return 'Telefone incompleto!';
                }
                return null;
              }
          ),

          CustomTextField(
            controller: emailController,
            labelText: 'Email',
            hintText: 'Ex: john.c.calhoun@examplepetstore.com',
            obscureText: false,
            onChanged: (value) {
              notifier.atualizar();
            },
          ),
        ]
      ),
    );
  }

  Widget _bloco2 (String? Function(String?) validate) {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          _assi(context),

          CustomTextField(
              controller: enderecoController,
              labelText: 'Endereço',
              requiredTxt: ' *',
              hintText: 'Ex: Av. Weyne Cavalcante, N999...',
              obscureText: false,
              maxLenght: 90,
              validator: validate,
              onChanged: (value) {
                notifier.atualizar();
              }
          ),
          CustomTextField(
              controller: garantiaController,
              labelText: 'Política de Garantia',
              hintText: 'Forneça dados sobre sua garantia para o cliente caso necessário.',
              obscureText: false,
              maxLenght: 600,
              onChanged: (value) {
                notifier.atualizar();
              }
          ),
          CustomTextField(
            controller: politicaPrivacidadeController,
            labelText: 'Política de Privacidade',
            hintText: '',
            obscureText: false,
            maxLenght: 600,
            onChanged: (value) {
              notifier.atualizar();
            },
          ),
        ]
      ),
    );
  }

  Widget _assi(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final bool hasAssinatura = _assinatura != null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Título mais elegante e fora da caixa
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Row(
              children: [
                Icon(Icons.draw_outlined, size: 20, color: theme.primary),
                const SizedBox(width: 8),
                Text(
                  'Assinatura do Estabelecimento',
                  style: TextStyle(
                    color: theme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // 2. Container Principal (O "Cartão")
          Container(
            height: 140, // Altura fixa confortável
            width: double.infinity,
            decoration: BoxDecoration(
              // Fundo suave se estiver vazio, branco/surface se tiver assinatura
              color: hasAssinatura ? theme.surface : theme.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: hasAssinatura ? theme.outlineVariant : theme.primary.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            clipBehavior: Clip.hardEdge, // Garante que o InkWell não vaze pelas bordas arredondadas

            // 3. Alterna entre estado Vazio e Preenchido
            child: hasAssinatura

            // --- ESTADO PREENCHIDO (Com Assinatura) ---
                ? Row(
              children: [
                // Imagem da Assinatura
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.memory(
                      Uint8List.fromList(_assinatura!),
                      fit: BoxFit.contain, // Garante que a assinatura não distorça
                    ),
                  ),
                ),

                // Divisor vertical sutil
                Container(
                  width: 1,
                  color: theme.outlineVariant.withValues(alpha: 0.5),
                ),

                // Ações (Editar / Deletar)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.filledTonal(
                        icon: const Icon(Icons.edit_rounded, size: 20),
                        tooltip: 'Editar Assinatura',
                        onPressed: () {
                          _abrirAssinatura(context);
                          notifier.atualizar();
                        },
                      ),
                      const SizedBox(height: 12),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.red.withValues(alpha: 0.1),
                          foregroundColor: Colors.red,
                        ),
                        icon: const Icon(Icons.delete_outline_rounded, size: 20),
                        tooltip: 'Remover Assinatura',
                        onPressed: () {
                          _deletarAssinatura();
                          notifier.atualizar();
                        },
                      ).animate().scale(duration: 300.ms),
                    ],
                  ),
                ),
              ],
            )

            // --- ESTADO VAZIO (Sem Assinatura) ---
                : InkWell(
              // Torna a área inteira clicável!
              onTap: () {
                _abrirAssinatura(context);
                notifier.atualizar();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.gesture_rounded, color: theme.primary, size: 28),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Toque para adicionar uma assinatura",
                    style: TextStyle(
                      color: theme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildLogo(List<int> logoBytesV, {double size = 50}) {
    final bytesParaMostrar = logoBytes ?? logoBytesV;
    return CircleAvatar(
      radius: 60,
      backgroundImage: bytesParaMostrar.isNotEmpty
          ? MemoryImage(Uint8List.fromList(bytesParaMostrar))
          : null,
      child: (bytesParaMostrar.isEmpty)
          ? Icon(Icons.store, size: size)
          : null,
    );
  }
}

