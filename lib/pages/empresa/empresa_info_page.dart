import 'dart:typed_data';
import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/dialog.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:assistencia_os/models/atendente_model/atendente_model.dart';
import 'package:assistencia_os/models/tecnicos_model/tecnicos_model.dart';
import 'package:assistencia_os/pages/empresa/editar_dados_empresa.dart';
import 'package:assistencia_os/sync/modules/empresa_sync.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assistencia_os/custom_widgets/msg_body_vazio.dart';
import 'package:flutter/services.dart';
import '../../db_helper/db_helper.dart';
import '../../models/empresa_model/empresa_model.dart';
import '../../services/premium_services.dart';
import '../funcionario_forn/atendente/atendentes_screen.dart';
import '../funcionario_forn/tecnicos/tecnicos_page.dart';
import '../home/home.dart';

class DadosEmpresaPage extends StatefulWidget {
  final bool configPage;
  const DadosEmpresaPage({
    super.key,
    this.configPage = false,
  });

  @override
  State<DadosEmpresaPage> createState() => _DadosEmpresaPageState();
}

class _DadosEmpresaPageState extends State<DadosEmpresaPage> {

  Empresa? empresa;
  String? uid;
  int qtdTec = 0;
  int qtdAte = 0;

  List<Tecnicos> tecnicos = [];
  List<Atendente> atendentes = [];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }


  Future<void> carregarDados() async {
    final dados = await DatabaseHelper.getEmpresa();
    final user = FirebaseAuth.instance.currentUser;
    final ate = await DatabaseHelper.getAllAtendentes();
    final tec = await DatabaseHelper.getAllTecnicos();

    setState(() {
      empresa = dados;
      uid = user?.uid;
      tecnicos = tec;
      atendentes = ate;
    });

    // setState(() async {
    //   empresa = dados;
    //   if (user != null) {
    //     uid = user.uid;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: widget.configPage && context.isDesktop ? null : AppBar(
        title: const Text('Dados da Empresa'),
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
          tooltip: 'Voltar',
        ),
        actions: [
          _botaoEditar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white.withValues(alpha: 0.2)
          ),
        ],
      ),
      body: empresa == null
          ? const Vazio(label: 'Nenhuma informação cadastrada. Clique no botão + para adicionar.')
          : SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: context.isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
              ),
            ),
          ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildLogoCabecalho(),
          const SizedBox(height: 16),

          _buildInfoCard(
            icon: Icons.phone_android,
            title: 'Telefone 1',
            subtitle: empresa!.telefone1,
          ),
          _buildInfoCard(
            icon: Icons.phone,
            title: 'Telefone 2',
            subtitle: empresa!.telefone2,
          ),
          _buildInfoCard(
            icon: Icons.location_on,
            title: 'Endereço',
            subtitle: empresa!.endereco,
          ),
          _buildInfoCard(
            icon: Icons.person,
            title: 'Atendentes',
            subtitle: atendentes.length.toString(),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AtendentesPage())
            )
          ),
          _buildInfoCard(
            icon: Icons.build,
            title: 'Técnicos',
            subtitle: tecnicos.length.toString(),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const TecnicosPage())
            ),
          ),
          const SizedBox(height: 10),

          _buildExpansionCard(
            title: 'Política de Garantia',
            content: Text(empresa?.politicaGarantia?.isNotEmpty == true ? empresa!.politicaGarantia.toString() : 'Não informado'),
          ),
          _buildExpansionCard(
            title: 'Política de Privacidade',
            content: Text(empresa?.politicaPrivacidade?.isNotEmpty == true ? empresa!.politicaPrivacidade.toString() : 'Não informado'),
          ),

          _buildAssinatura(),
          const SizedBox(height: 15),

          if (empresa != null)
            _buildBotaoExcluir(),
          const SizedBox(height: 40),
        ]
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const SizedBox(height: 18),
              _buildLogoCabecalho(),
              _buildAssinatura()
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 18),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        icon: Icons.phone_android,
                        title: 'Telefone 1',
                        subtitle: empresa!.telefone1,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoCard(
                        icon: Icons.phone,
                        title: 'Telefone 2',
                        subtitle: empresa!.telefone2,
                      ),
                    ),
                  ],
                ),

                _buildInfoCard(
                  icon: Icons.location_on,
                  title: 'Endereço',
                  subtitle: empresa!.endereco,
                ),

                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        icon: Icons.person,
                        title: 'Atendentes',
                        subtitle: atendentes.length.toString(),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const AtendentesPage())
                        ),
                      ),
                    ),
                    Expanded(
                      child: _buildInfoCard(
                        icon: Icons.build,
                        title: 'Técnicos',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const TecnicosPage())
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                _buildExpansionCard(
                  title: 'Política de Garantia',
                  content: Text(empresa?.politicaGarantia?.isNotEmpty == true ? empresa!.politicaGarantia.toString() : 'Não informado'),
                ),
                _buildExpansionCard(
                  title: 'Política de Privacidade',
                  content: Text(empresa?.politicaPrivacidade?.isNotEmpty == true ? empresa!.politicaPrivacidade.toString() : 'Não informado'),
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.configPage && context.isDesktop)
                    _botaoEditar(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.primary
                    ),
                    const SizedBox(width: 10),
                    if (empresa != null)
                      _buildBotaoExcluir(),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLogoCabecalho () {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          buildLogo(
            empresa!,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            empresa!.nome.toString(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          (empresa?.slogan?.isNotEmpty ?? false) ? Text(
            empresa!.slogan ?? 'Não informado',
            style: const TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center,
          ) : const SizedBox(),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text(
              //   'ID: ${uid ?? 'Não informado'}',
              //   style: TextStyle(
              //     color: Colors.white.withValues(alpha: 0.8),
              //   ),
              //   overflow: TextOverflow.ellipsis,
              // ),
              // Visibility(
              //   visible: uid != null,
              //   child: IconButton(
              //     icon: const Icon(Icons.copy, color: Colors.white70, size: 17),
              //     onPressed: () {
              //       Clipboard.setData(ClipboardData(text: uid ?? ''));
              //
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           content: Text('UID copiado!'),
              //           duration: Duration(seconds: 2),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
          Text('CNPJ: ${empresa?.cnpj?.isNotEmpty == true ? empresa!.cnpj : 'Não informado'}', style: TextStyle(color: Colors.white.withValues(alpha: 0.8))),
          //Divider(height: 30),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAssinatura () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (empresa?.assinatura != null)...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('Assinatura:', style: TextStyle(color: Colors.grey)),
          ),
          CustomCard(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Image.memory(
              Uint8List.fromList(empresa!.assinatura!),
              width: double.infinity,
              height: 100,
            ),
          ),
          const SizedBox(height: 20),
        ]
      ],
    );
  }

  Widget _botaoEditar({
    required Color foregroundColor,
    required Color backgroundColor,
    }) {
    return AppbarBtn(
      icon: empresa == null ? Icons.add: Icons.edit,
      onPressed: () async {
        if (await PermissionService.admPermission()){
          if (!mounted) return;
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditarEmpresaPage(empresa: empresa),
            ),
          );
          if (resultado == true) {
            carregarDados();
          }
        } else {
          if(!mounted) return;
          AppFlushbar.error('Somente administradores podem editar os dados da empresa!.');
        }
      },
    );
  }

  Widget _buildBotaoExcluir() {
    return FutureBuilder(
      future: PermissionService.admPermission(),
      builder: (context, snapshot) {

        // enquanto verifica permissão
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        // erro ou sem permissão
        if (!snapshot.hasData || snapshot.data == false) {
          return const SizedBox.shrink();
        }

        // tem permissão
        return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          icon: const Icon(Icons.delete, color: Colors.white),
          label: const Text('Excluir Dados da Empresa',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: _onExcluirPressed,
        );
      }
    );
  }

  Future <void> _onExcluirPressed() async {
    final syncEmpresa = EmpresaSync();

    final confirmar = await showDialog(
        context: context,
        builder: (context) => CustomDialog(
          rightButtonText: 'Confirmar',
          leftButtonText: 'Cancelar',
          colorRight: Colors.red,
          onPressedLeft: () => Navigator.pop(context, false),
          onPressedRight: () async {

            if (await PermissionService.admPermission()) {
              if (!context.mounted) return;
              Navigator.pop(context, true);
            } else {
              if (!context.mounted) return;
              Navigator.pop(context, false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Somente administradores podem excluir os dados da empresa!.'),
                  duration: Duration(seconds: 5),
                ),
              );
            }
          },
          title: 'Excluir Dados ⚠️',
          content: 'Deseja realmente excluir todos os dados da empresa?',
        )
    );
    if (confirmar == true) {

      await syncEmpresa.deleteEmpresa();

      setState(() {
        empresa = null; // 🔑 limpar a referência local
      });
      if (!context.mounted) return;
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados da empresa excluídos')),
      );
    }
  }


  Widget _buildInfoCard({required IconData icon, required String title, String? subtitle, VoidCallback? onTap}) {
    return GestureDetector(
      child: CustomCard(
        onTap: onTap,
        margin: const EdgeInsets.symmetric(vertical: 6),
        borderRadius: 35,
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle == null || subtitle.isNotEmpty == false ? 'Não informado' : subtitle),
          trailing: onTap != null ? const Icon(Icons.chevron_right_outlined) : null,
        ),
      ),
    );
  }

  Widget _buildExpansionCard({required String title, required Widget content}) {
    return CustomCard(
      margin: const EdgeInsets.symmetric(vertical: 6),

      child: ExpansionTile(
        initiallyExpanded: context.isDesktop ? true : false,
        enableFeedback: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          )
        ],
      ),
    );
  }
  Widget buildLogo(Empresa empresa, {double size = 50}) {
    ImageProvider? image;

    // 1️⃣ Prioridade: imagem local (offline)
    if (empresa.logoBytes != null && empresa.logoBytes!.isNotEmpty) {
      image = MemoryImage(Uint8List.fromList(empresa.logoBytes!));
    }
    // 2️⃣ Fallback: imagem remota
    else if (empresa.logoUrl != null && empresa.logoUrl!.isNotEmpty) {
      image = NetworkImage(empresa.logoUrl!);
    }

    return Hero(
      tag: empresa.id,
      child: CircleAvatar(
        radius: size,
        backgroundColor: Colors.grey[200],
        backgroundImage: image,
        child: image == null
            ? Icon(
          Icons.no_photography,
          size: size * 0.6,
          color: Colors.grey[700],
        ) : null,
      ),
    );
  }
}

