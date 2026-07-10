import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:assistencia_os/pages/clientes/cadastro_ou_editar_cliente.dart';
import 'package:assistencia_os/pages/clientes/detalhes_cliente_page.dart';
import 'package:flutter/material.dart';
import 'package:assistencia_os/custom_widgets/msg_body_vazio.dart';
import '../../configs/search_color.dart';
import '../../custom_widgets/appbar_btn.dart';
import '../../db_helper/db_helper.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../home/home.dart';

class ListaClientesPage extends StatefulWidget {

  const ListaClientesPage({
    super.key,
  });

  @override
  _ListaClientesPageState createState() => _ListaClientesPageState();
}

class _ListaClientesPageState extends State<ListaClientesPage> {
  List<Cliente> clientes = [];
  List<Cliente> clientesFiltrados = [];
  TextEditingController searchController = TextEditingController();
  String filtroSelecionado = 'nome';
  final ValueNotifier<Cliente?> clienteSelecionadoNotifier = ValueNotifier(null);

  //Cliente? clienteSelecionado;
  //final syncService = SyncService(DatabaseHelper.isar);

  @override
  void initState() {
    super.initState();
    carregarClientes();
    //syncService.syncClienteToFirebase(clientes.first);
  }

  Future<void> carregarClientes() async {
    final data = await DatabaseHelper.getAllClientes();

    setState(() {
      clientes = data;
      clientesFiltrados = List.from(data);
      aplicarFiltro();

      // 🔥 mantém seleção válida no desktop
      final selecionado = clienteSelecionadoNotifier.value;
      if (selecionado != null) {
        clienteSelecionadoNotifier.value = clientes.firstWhere(
              (c) => c.id == selecionado.id,
          orElse: () => clientes.first,
        );
      }
    });
  }


  void aplicarFiltro() {
    setState(() {
      if (filtroSelecionado == 'nome') {
        clientesFiltrados.sort(
                (a, b) => a.nome!.toLowerCase().compareTo(b.nome ?? '---'.toLowerCase()));
      } else if (filtroSelecionado == 'data') {
        clientesFiltrados.sort((a, b) {
          final dateA = a.dataCadastro;
          final dateB = b.dataCadastro;
          return dateB.compareTo(dateA);
        });
      }
    });
  }

  void filtrarClientes(String query) {
    final filtrados = clientes.where((cliente) { // Filtra os clientes com base no nome ou telefone
      final nomeLower = cliente.nome?.toLowerCase();
      final telefoneLower = cliente.telefone?.toLowerCase();
      final input = query.toLowerCase();
      return nomeLower!.contains(input) || telefoneLower!.contains(input);
    }).toList();

    setState(() {
      clientesFiltrados = filtrados;
      aplicarFiltro();
    });
  }
  bool modoDesk = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final searchColor = context.appbarButtonColor;

    //
    //final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            final isWide = constraints.maxWidth >= 600;
            final deskMode = constraints.maxWidth >= 600 && constraints.maxWidth <=900;
            modoDesk = isWide;
            
            return Row(
              children: [
                /// Lista de clientes
                Expanded(
                  flex: deskMode ? 2 : 1,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChoiceChip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                label: const Text('Por Nome'),
                                selected: filtroSelecionado == 'nome',
                                onSelected: (_) {
                                  setState(() {
                                    filtroSelecionado = 'nome';
                                    aplicarFiltro();
                                  });
                                },
                                checkmarkColor: Colors.white,
                                selectedColor: theme.primary,
                                labelStyle: TextStyle(
                                  color: filtroSelecionado == 'nome' ? Colors.white : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              ChoiceChip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                label: const Text('Mais Recentes'),
                                selected: filtroSelecionado == 'data',
                                onSelected: (_) {
                                  setState(() {
                                    filtroSelecionado = 'data';
                                    aplicarFiltro();
                                  });
                                },
                                checkmarkColor: Colors.white,
                                selectedColor: theme.primary,
                                labelStyle: TextStyle(
                                  color: filtroSelecionado == 'data' ? Colors.white : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //if (isWide)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _caixaDePesquisa(searchColor),
                      ),

                      const SizedBox(height: 10),

                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: clientesFiltrados.isEmpty
                              ? const Vazio(key: ValueKey('vazio'), label: 'Nenhum cliente encontrado')
                              : ValueListenableBuilder(
                              valueListenable: clienteSelecionadoNotifier,
                              builder: (context, clienteSelecionado, _) {
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    key: const ValueKey('list'),
                                    itemCount: clientesFiltrados.length,
                                    itemBuilder: (context, index) {
                                  final cliente = clientesFiltrados[index];

                                  final isSelected =
                                      clienteSelecionadoNotifier.value?.id == cliente.id;

                                  return GestureDetector(
                                    onTap: () async {
                                      if (isWide) {
                                        clienteSelecionadoNotifier.value = cliente;
                                      } else {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => DetalhesClientePage(cliente: cliente),
                                          ),
                                        );
                                        carregarClientes();
                                      }
                                    },


                                    child: CustomCard(
                                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                      borderRadius: 35,
                                      //elevation: isSelected ? 0 : 10,
                                      color: isSelected ? theme.primary.withValues(alpha: 0.1) : null,
                                      //borderColor: isSelected ? theme.primary.withValues(alpha: 0.5) : null,

                                      child: ListTile(
                                        selected: isSelected,
                                        leading: Hero(
                                          tag: 'avatar_${cliente.id}',
                                          child: CircleAvatar(
                                            backgroundColor: theme.primary,
                                            child: Text(
                                              cliente.nome != null ? cliente.nome![0].toUpperCase() : '?',
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        title: Text(cliente.nome.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: const TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                        subtitle: Text(cliente.telefone.toString()),
                                        trailing: const Icon(Icons.chevron_right_rounded),
                                      ),
                                    ),
                                  );
                                  },
                                  );
                                }
                              ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Detalhes do cliente em tela larga
                if (isWide)
                  Expanded(
                    flex: 2,
                    child: ValueListenableBuilder<Cliente?>(
                      valueListenable: clienteSelecionadoNotifier,
                      builder: (context, cliente, _) {
                        if (cliente == null) {
                          return const Center(
                            child: Text('Selecione um cliente'),
                          );
                        }
                        return DetalhesClientePage(
                          key: ValueKey(cliente.id), // 🔥 ESSENCIAL
                          cliente: cliente,
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),

      floatingActionButtonLocation: context.isTablet || context.isDesktop
          ? FloatingActionButtonLocation.startFloat // 🔥 ÚNICO
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab_lista_clientes', // ✅ ÚNICO
        backgroundColor: Colors.green,
        icon: const Icon(Icons.person_add),
        label: const Text('Novo Cliente'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CadastroEditarCliente()),
          );
          carregarClientes();
        },
      ),
    );
  }
  Widget _caixaDePesquisa (Color color) {
    return CustomTextField(
      borderRadius: 25,
      backgroundColor: color,
      controller: searchController,
      onChanged: filtrarClientes,
      hintText: 'Buscar cliente por nome ou telefone',
      prefixIcon: const Icon(Icons.search),
      maxLines: 1,
      maxLenght: 20,
      counterText: '',
    );
  }
}