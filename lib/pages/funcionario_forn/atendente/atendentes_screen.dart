import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/loading_widget.dart';
import 'package:assistencia_os/custom_widgets/msg_body_vazio.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../custom_widgets/dialog.dart';
import '../../../custom_widgets/tiles_gestao.dart';
import '../../../custom_widgets/top_msg.dart';
import '../../../db_helper/cargo_helper.dart';
import '../../../db_helper/db_helper.dart';
import '../../../models/atendente_model/atendente_model.dart';
import '../../../sync/modules/atendente_sync.dart';
import '../../home/home.dart';
import '../cadastro_funcionario_page.dart';
import 'detalhes_screen.dart';

class _ResumoAtendente {
  int quantidadeServicos;
  double valorTotal;

  _ResumoAtendente({
    this.quantidadeServicos = 0,
    this.valorTotal = 0.0,
  });
}

class AtendentesPage extends StatefulWidget {
  final bool configPage;
  const AtendentesPage({
    super.key,
    this.configPage = false,
  });

  @override
  State<AtendentesPage> createState() => _AtendentesPageState();
}

class _AtendentesPageState extends State<AtendentesPage> {

  final nomeController = TextEditingController();
  final numeroController = TextEditingController();
  final syncAtendente = AtendenteSync();

  String? cargoAtual;
  late Map<String, _ResumoAtendente> resumosAtendentes = {};
  List<Atendente> atendenteListSelect = [];

  @override
  void initState() {
    loadList();
    super.initState();
  }

  Future<void> loadList() async {
    final cargoSelecionado = await CargoHelper.lerCargo();
    final dataAtendentes = await DatabaseHelper.getAllAtendentes();
    final dataServicos = await DatabaseHelper.getAllServicos();

    // 🔥 Processa o resumo
    final Map<String, _ResumoAtendente> mapaTemporario = {};

    for (var servico in dataServicos) {
      final nome = servico.atendente?.trim();

      if (nome != null && nome.isNotEmpty) {
        final valorServico = servico.valorOriginalServicoDouble ?? 0.0; // Ajuste para o campo de valor correto

        if (!mapaTemporario.containsKey(nome)) {
          mapaTemporario[nome] = _ResumoAtendente();
        }

        mapaTemporario[nome]!.quantidadeServicos += 1;
        mapaTemporario[nome]!.valorTotal += valorServico;
      }
    }

    // 🔥 NOVO: Ordenando a lista de atendentes pelo valor total (Ranking)
    dataAtendentes.sort((a, b) {
      // Pega o valor total de 'a' e 'b'. Se não tiver no mapa, é 0.0.
      final totalA = mapaTemporario[a.nome]?.valorTotal ?? 0.0;
      final totalB = mapaTemporario[b.nome]?.valorTotal ?? 0.0;

      // Compara B com A para ordem Decrescente (do maior faturamento para o menor)
      return totalB.compareTo(totalA);
    });

    if (mounted) {
      setState(() {
        atendenteListSelect = dataAtendentes;
        resumosAtendentes = mapaTemporario; // Atualiza o estado com os cálculos
        cargoAtual = cargoSelecionado;
      });
    }
  }

  /// 🔥 Adicionar fornecedor
  Future<void> addAtendente({Atendente? at}) async {

    if (cargoAtual != 'admin') {
      AppFlushbar.error('Sem permissão para adicionar.');
      return;
    }

    // 1. Abre a tela e aguarda o resultado
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroFuncionarioPage(tipo: TipoFuncionario.atendente, funcionario: at,),
      ),
    );

    // 2. Se o usuário preencheu e clicou em Salvar, processamos:
    if (result != null && result is Map<String, dynamic>) {
      if(!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingWidget(message: ['Salvando...', 'Aguarde']),
      );

      try {
        final dataHora = "${UtilData.obterDataDDMMAAAA(DateTime.now())} • ${UtilData.obterHoraHHMM(DateTime.now())}";

        // Monta o objeto (Atendente ou Tecnicos)
        final newAtendente = Atendente()
          ..nome = result['nome']
          ..numero = result['numero']
          ..salario = result['salario']
          ..comissao = result['comissao']
          ..metaMensal = result['metaMensal']
          ..tempoExperiencia = result['tempoExperiencia']
          ..observacoes = result['observacoes']
          ..dateTimeCadastro = dataHora
          ..createdAt = DateTime.now();

        await DatabaseHelper.insertAtendente(newAtendente);
        await syncAtendente.push(newAtendente);

        await loadList(); // Atualiza a lista da tela

        if (!mounted) return;
        Navigator.pop(context); // Fecha o loading
        AppFlushbar.success('Adicionado com sucesso!');

      } catch (e) {
        if (!mounted) return;
        Navigator.pop(context); // Fecha o loading
        AppFlushbar.error('Erro ao salvar no banco.');
      }
    }
  }

  /// 🔥 Remover atendente com desfazer

  void removerAtendente(int index) async {
    // 1. Validação rápida ANTES de abrir qualquer loading
    if (cargoAtual != 'admin') {
      AppFlushbar.error('Somente administradores podem remover atendentes');
      return;
    }

    // Captura o navigator antes das operações assíncronas (boa prática no Flutter)
    final navigator = Navigator.of(context);
    final removed = atendenteListSelect[index];

    // 2. Mostra o loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingWidget(
        message: ['Deletando...', 'Sincronizando', 'Aguarde...'],
      ),
    );

    try {
      // 3. Tenta realizar a exclusão e sincronização
      await syncAtendente.deleteAtendente(removed.id);

      // 4. Atualiza a lista local apenas se a exclusão externa der certo
      setState(() {
        atendenteListSelect.removeAt(index);
      });

      if (!mounted) return;
      AppFlushbar.success('Atendente ${removed.nome} removido com sucesso');

    } catch (e) {
      // 5. Se o banco falhar ou estiver sem internet, cai aqui e não trava o app
      if (!mounted) return;
      AppFlushbar.error('Falha ao remover atendente. Tente novamente.');
      debugPrint('Erro ao remover atendente: $e');

    } finally {
      // 6. O bloco finally SEMPRE é executado (com sucesso ou erro)
      // Isso garante que o loading seja destruído.
      navigator.pop();
    }
  }

  bool notifier = false;
  late final valueListenable = ValueNotifier(notifier);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: widget.configPage && context.isDesktop ? null : AppBar(
          title: const Text("Atendentes"),
          centerTitle: true,
          leading: const AppbarBtn(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: atendenteListSelect.isEmpty
                    ? const Vazio(label: 'Nenhum atendente cadastrado')
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: atendenteListSelect.length,
                  itemBuilder: (context, index) {
                    final atendente = atendenteListSelect[index];
                    final resumo = resumosAtendentes[atendente.nome] ?? _ResumoAtendente();
                    return TilesGestao(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AtendenteDetalhesPage(
                                tipo: TipoFuncionario.atendente,
                                index: index,
                                funcionario: atendente,
                                onPress: () => removerAtendente(index),
                                onEdit: () => loadList()
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        CustomDialog2.show(
                          context: context,
                          title: 'Deletar ${atendente.nome} ?',
                          description: 'Essa ação não poderá ser desfeita. Os serviços feitos por este atendente continuarão salvos.',
                          confirmText: 'Deletar',
                          cancelText: 'Cancelar',
                          isDestructive: true,
                          onConfirm: () {
                            Navigator.pop(context); // Close dialog
                            removerAtendente(index);
                          },
                        );
                      },
                       posicaoRanking: index,
                       widgetcustom: atendenteListSelect[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: theme.primary,
          onPressed: () => addAtendente(),
          label: const Text("Adicionar"),
          icon:const Icon(Icons.add, color: Colors.white),
        ).animate().scale()
      );
    }

  void _validate () {
    nomeController.text.isEmpty || numeroController.text.length < 14 ? valueListenable.value = false : valueListenable.value = true;
  }

}

