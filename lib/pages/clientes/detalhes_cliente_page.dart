import 'dart:ui';
import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/dialog.dart';
import 'package:assistencia_os/custom_widgets/info_card.dart';
import 'package:assistencia_os/services/launcher_helper.dart';
import 'package:assistencia_os/custom_widgets/msg_body_vazio.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:assistencia_os/db_helper/cargo_helper.dart';
import 'package:assistencia_os/db_helper/premium_helper.dart';
import 'package:assistencia_os/pages/clientes/cadastro_ou_editar_cliente.dart';
import 'package:assistencia_os/pages/home/home.dart';
import 'package:assistencia_os/pages/all_os/all_os.dart';
import 'package:assistencia_os/pages/service_registration/base_screen.dart';
import 'package:assistencia_os/pages/details_os/details_os_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../custom_widgets/card_servico_status/card_servico.dart';
import '../../custom_widgets/loading_widget.dart';
import '../../db_helper/db_helper.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../../models/servico_model/servico_model.dart';
import '../../sync/modules/cliente_sync.dart';
import '../../sync/modules/servico_sync.dart';
import '../premium_page.dart';

class DetalhesClientePage extends StatefulWidget {
  final Cliente cliente;
  final bool modoDesk;

  const DetalhesClientePage({
    super.key,
    required this.cliente,
    this.modoDesk = false,
  });

  @override
  _DetalhesClientePageState createState() => _DetalhesClientePageState();
}

class _DetalhesClientePageState extends State<DetalhesClientePage> {
  List<Servico> servicos = [];
  late Cliente cliente;
  String message = 'Olá, tudo bem?';
  //final syncService = SyncService(DatabaseHelper.isar);
  String? cargoAtual;
  bool checkAss = false;
  final syncServico = ServicoSync();
  final syncCliente = ClienteSync();


  @override
  void initState() {
    super.initState();
    cliente = widget.cliente;
    _carregarDados();
  }


  Future<void> _carregarDados() async {
    final data = await DatabaseHelper.getClienteById(widget.cliente.id);
    final assi = await PremiumHelper.lerPremium();
    final cargoSalvo = await CargoHelper.lerCargo();
    final dataCliente = await DatabaseHelper.getServicosPorCliente(cliente.id);

    setState(() {
      checkAss = assi;
      cargoAtual = cargoSalvo;
      servicos = dataCliente;

      if (data != null) {
        setState(() {
          cliente = data;
        });
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente não encontrado')),
        );
        Navigator.pop(context);
      }
    });
  }

  late final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final tabletMode = constraints.maxWidth >= 700;
          final deskMode = constraints.maxWidth >= 900;
          final actionsBtn = constraints.maxWidth < 350;


          if (tabletMode) {
            return _buildDesktopLayout(deskMode);
          } else {
            return _buildMobileLayout(constraints.maxWidth <= 700, actionsBtn);
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_task),
        label: const Text('Novo Serviço'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BaseScreen(index: 2, clienteId: cliente.id),
            ),
          );
          _carregarDados();

        },
      ),
    );
  }

  // --- LAYOUT MOBILE ---
  Widget _buildMobileLayout(bool deskMode, bool telaPequena) {

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 350,
              pinned: true,
              leading:

              context.isTablet || context.isDesktop
                  ? const SizedBox() : IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              ),

              title: Text(cliente.nome ?? 'Sem Nome',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),

              actions: [
                if (context.isMobile || telaPequena)
                //_buildMenuActions(),
                if ((context.isTablet || context.isDesktop) && !telaPequena)
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      AppbarBtn(
                        backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        onPressed: _editarCliente,
                        //label: "Editar Dados",
                        icon: Icons.edit,
                      ),
                      AppbarBtn(
                        backgroundColor: Colors.red.withValues(alpha: 0.1),
                        foregroundColor: Colors.red,
                        onPressed: () => _confirmarExclusao(context),
                        //label: "Excluir Cliente",
                        icon: Icons.delete,
                      ),
                    ],
                  ),
              ],

              backgroundColor: Theme.of(context).colorScheme.primary,

              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color:  Theme.of(context).colorScheme.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      _buildAvatar(80),
                      const SizedBox(height: 10),
                      Text(
                        cliente.nome ?? 'Sem Nome',
                        style: const TextStyle(
                            fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _buildQuickActionsBar(),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: TabBar(
                    dividerColor: Colors.grey,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    indicatorWeight: 3,
                    labelColor: isDarkMode ? Colors.white : Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      const Tab(text: 'Detalhes'),
                      Tab(text: 'Histórico (${servicos.length})'),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(children: [_buildInfoSection()]),
            ),
            _buildHistoryList(),
          ],
        ),
      ),
    );
  }

  // --- LAYOUT DESKTOP ---
  Widget _buildDesktopLayout(bool deskMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Coluna Esquerda: Perfil e Detalhes
        Container(
          width: 350,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border:  Border(right: BorderSide(color: Colors.grey.shade200)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Column(
                    children: [
                      _buildAvatar(100),
                      const SizedBox(height: 16),
                      Text(
                        cliente.nome ?? 'Sem Nome',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      _buildQuickActionsBar(),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                _buildInfoSection(),

              ],
            ),
          ),
        ),
        // Coluna Direita: Histórico
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Text("Histórico de Serviços",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    )
                ),
              ),

              Expanded(child: _buildHistoryList(isGrid: deskMode)),
            ],
          )
        ),
      ],
    );
  }

  // --- COMPONENTES VISUAIS ---

  Widget _buildAvatar(double size) {
    final avatar = CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.black.withValues(alpha: 0.3),
      child: Text(
        cliente.nome != null && cliente.nome!.isNotEmpty
            ? cliente.nome!.substring(0, 1).toUpperCase()
            : '#',
        style: TextStyle(
          fontSize: size * 0.4,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (!context.isMobile) return avatar;

    return Hero(
      tag: 'avatar_${cliente.id}',
      child: avatar,
    );
  }

  Widget _buildQuickActionsBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(40),

      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          children: [
            _actionButton(
              delay: const Duration(milliseconds: 100),
              icon: Icons.call,
              color: Colors.blue,
              onTap: () => _checkPremium(() => LauncherHelper.fazerLigacao(numero: cliente.telefone ?? ''),
              ),
            ),
            _actionButton(
              delay: const Duration(milliseconds: 200),
              icon: RemixIcon.whatsappLine,
              color: Colors.green,
              onTap: () => _checkPremium(() => LauncherHelper.abrirWhatsApp(telefone: cliente.telefone ?? '', mensagem: message)),
            ),
            if (cargoAtual != 'atendente')
              _actionButton(
                delay: const Duration(milliseconds: 300),
                icon: Icons.email_outlined,
                color: Colors.orange,
                onTap: () => LauncherHelper.enviarEmail(email: cliente.email ?? ''),
              ),
            _actionButton(
              delay: const Duration(milliseconds: 400),
              icon: Icons.map_outlined,
              color: Colors.pinkAccent,
              onTap: () => LauncherHelper.abrirMapa(endereco: '${cliente.rua}, ${cliente.numero} - ${cliente.bairro}, ${cliente.cidade}',),
            ),
            _actionButton(
              delay: const Duration(milliseconds: 500),
              icon: Icons.edit,
              color: Colors.purple,
              onTap: () => _editarCliente(),
            ),
            _actionButton(
              delay: const Duration(milliseconds: 600),
              icon: Icons.delete,
              color: Colors.red,
              onTap: () => _confirmarExclusao(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _actionButton(
      {
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
        required Duration? delay
      }) {
    return IconButton(
      //padding: const EdgeInsets.all(10),
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
        foregroundColor: Colors.white,
        iconSize: 20
      ),
      icon: Icon(icon),
      onPressed: onTap,
    ).animate().scale(delay: delay);
  }

  Widget _buildInfoSection() {
    return Column(
      children: [
        InfoCard(
          title: "Contato & Pessoal",
          icon: Icons.person_outline,
          children: [
            _InfoRow(label: "Telefone", value: cliente.telefone),
            if (cargoAtual != 'atendente') ...[
              _InfoRow(label: "CPF", value: cliente.cpf),
              _InfoRow(label: "Email", value: cliente.email),
            ],
            if (kDebugMode)
            _InfoRow(label: "ID", value: cliente.id.toString()),

            _InfoRow(label: "Cadastro", value: cliente.dataCadastro),
          ],
        ),
        const SizedBox(height: 16),
        InfoCard(
          title: "Endereço",
          icon: Icons.location_on_outlined,
          children: [
            Text(
              "${cliente.rua ?? ''}, ${cliente.numero ?? ''}",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            if (cliente.bairro != null)
              Text("Bairro: ${cliente.bairro}",
                  style: TextStyle(color: Colors.grey[600])),
            Text(
              "${cliente.cidade ?? ''} - ${cliente.estado ?? ''}",
              style: TextStyle(color: Colors.grey[600]),
            ),
            if (cliente.cep != null)
              Text("CEP: ${cliente.cep}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ],
    ).animate().fade().slideY(begin: 0.1);
  }

  Widget _buildHistoryList({bool isGrid = false}) {

    if (servicos.isEmpty) {
      return const Center(child: Vazio(label: "Nenhum serviço registrado"));
    }

    if (isGrid) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          mainAxisExtent: 200,
          childAspectRatio: 1.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: servicos.length,
        itemBuilder: (context, index) => _buildServiceItem(index),
      );
    }

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: servicos.length,
        itemBuilder: (context, index) => _buildServiceItem(index),
      ),
    );
  }

  Widget _buildServiceItem(int index) {
    // Inverter lista para mostrar mais recentes
    final s = servicos[servicos.length - index - 1];

    return ServicoCard(
      os: s,
      cliente: cliente,
      checkAssinatura: checkAss,
      onTap: () => _navegarParaDetalhes(s, cliente),
    );
  }

  // --- LÓGICA E UTILITÁRIOS ---

  void _checkPremium(VoidCallback action) {
    if (checkAss) {
      action();
    } else {
      AppFlushbar.info('Recurso PRO');
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const PremiumPage()));
    }
  }

  Future<void> _editarCliente() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroEditarCliente(cliente: cliente),
      ),
    );
    if (resultado != null) {
      setState(() {
        cliente = resultado;
      });
    }
  }


  Future<void> _confirmarExclusao(BuildContext dialogCtx) async {

    if (cargoAtual == 'atendente') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text('Somente administradores podem excluir clientes.'),
        ),
      );
      return;
    }

    // 1. Espera a pessoa clicar no dialog
    bool? confirmou = await _dialog(context);

    if (confirmou == true) {

      // 2. Abre o loading de tela cheia
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingWidget(
          message: ['Excluindo', 'Sincronizando', 'Aguarde...'],
        ),
      );

      try {
        // 3. Tenta deletar
        await syncCliente.deleteCliente(cliente.id);
        AppFlushbar.success('Cliente excluído com sucesso!');

      } catch (e) {
        AppFlushbar.error('Falha ao excluir o cliente.');

      } finally {
        // 4. SEMPRE fecha o LoadingWidget (dando erro ou não)
        if (mounted) {
          Navigator.of(context, rootNavigator: true).pop();
        }

        // 5. Fecha a tela do cliente se a deleção deu certo
        if (mounted && confirmou == true) {
          Navigator.pop(context);
        }
      }
    }
  }

  Future<bool?> _dialog (BuildContext ctx) async {
    return CustomDialog2.show<bool>(
      context: ctx,
      title: 'Excluir Cliente ⚠️',
      description: 'Tem certeza que deseja excluir este cliente?\n'
          'Todos os serviços associados a ele serão excluídos.',
      onConfirm: () async {
        Navigator.pop(ctx, true);
      },
      isDestructive: true,
      onCancel: () => Navigator.pop(ctx, false),
      confirmText: 'Excluir',
      cancelText: 'Cancelar'
    );
  }

  Future<void> _navegarParaDetalhes(Servico s, Cliente cliente) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesServicoPage(
          servico: s,
          cliente: cliente,
        ),
      ),
    );
    if (result == true) {
      syncServico.push(s);
      _carregarDados();
    }
  }
}

// --- WIDGETS AUXILIARES PARA CLEAN CODE ---

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          Expanded(
            child: Text(
              value == null || value!.isEmpty ? '---' : value!,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
