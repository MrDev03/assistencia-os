import 'dart:ui';
import 'package:assistencia_os/custom_widgets/contador.dart';
import 'package:assistencia_os/db_helper/cargo_helper.dart';
import 'package:assistencia_os/pages/funcionario_forn/cadastro_funcionario_page.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assistencia_os/custom_widgets/msg_body_vazio.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../custom_widgets/appbar_btn.dart';
import '../../../custom_widgets/tiles_gestao.dart';
import '../../../custom_widgets/top_msg.dart';
import '../../../db_helper/db_helper.dart';
import '../../../models/tecnicos_model/tecnicos_model.dart';
import '../../../sync/modules/tecnico_sync.dart';
import '../atendente/detalhes_screen.dart';
import '../../home/home.dart';


class TecnicosPage extends StatefulWidget {
  final bool configPage;
  const TecnicosPage({
    super.key,
    this.configPage = false,
  });

  @override
  State<TecnicosPage> createState() => _TecnicosPageState();
}

class _TecnicosPageState extends State<TecnicosPage> {

  final nomeController = TextEditingController();
  final numeroController = TextEditingController();
  List<Tecnicos> tecnicosListSelect = [];
  String? cargoAtual;
  final syncTecnico = TecnicoSync();
  Map<String, _ResumoTecnico> resumosTecnico = {};
  bool notifier = false;
  late final valueListenable = ValueNotifier(notifier);

  @override
  void initState() {
    super.initState();
    loadList();
  }

  /// 🔥 Carregar do banco
  Future<void> loadList() async {
    final dataTecnicos = await DatabaseHelper.getAllTecnicos();
    final dataServicos = await DatabaseHelper.getAllServicos();
    final cargoSalvo = await CargoHelper.lerCargo();

    // 🔥 Processa o resumo
    final Map<String, _ResumoTecnico> mapaTemporario = {};

    for (var servico in dataServicos) {
      final nome = servico.tecnico?.trim();

      if (nome != null && nome.isNotEmpty) {
        final valorServico = servico.valorOriginalServicoDouble ?? 0.0; // Ajuste para o campo de valor correto

        if (!mapaTemporario.containsKey(nome)) {
          mapaTemporario[nome] = _ResumoTecnico();
        }

        mapaTemporario[nome]!.quantidadeServicos += 1;
        mapaTemporario[nome]!.valorTotal += valorServico;
      }
    }

    if (mounted) {
      setState(() {
        tecnicosListSelect = dataTecnicos;
        cargoAtual = cargoSalvo;
        resumosTecnico = mapaTemporario;
      });
    }
  }

  /// 🔥 Adicionar fornecedor
  Future<void> addTecnico() async {
    final dataHora = "${UtilData.obterDataDDMMAAAA(DateTime.now())} • ${UtilData.obterHoraHHMM(DateTime.now())}";
    final newTecnicos = Tecnicos()
      ..nome = nomeController.text
      ..numero = numeroController.text
      ..dateTimeCadastro = dataHora
      ..createdAt = DateTime.now();

    final isar = DatabaseHelper.isar;

    await isar.writeTxn(() async {
      await isar.tecnicos.put(newTecnicos); // insere ou atualiza automaticamente
    });

    await loadList();
    nomeController.clear();

    if (!mounted) return;
    Navigator.pop(context, true);
    AppFlushbar.success('Tecnico ${newTecnicos.nome} adicionado com sucesso');
    await syncTecnico.push(newTecnicos);
  }

  /// 🔥 Remover tecnico com desfazer
  void removerTecnico(int index) async {

    if (cargoAtual != 'admin') {
      AppFlushbar.error('Somente administradores podem remover tecnicos');
      return;
    }

    final removed = tecnicosListSelect[index];
    await syncTecnico.deleteTecnico(removed.id);

    setState(() {
      tecnicosListSelect.removeAt(index);
    });
    if (!mounted) return;

    AppFlushbar.success('Tecnico ${removed.nome} removido com sucesso');
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: widget.configPage && context.isDesktop ? null : AppBar(
          title: const Text("Técnicos"),
          leading: AppbarBtn(
            onPressed: () => Navigator.pop(context),
            tooltip: 'Voltar',
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: tecnicosListSelect.isEmpty
                    ? const Vazio(label: 'Nenhum tecnico cadastrado')
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: tecnicosListSelect.length,
                  itemBuilder: (context, index) {
                    final reverseIndex = tecnicosListSelect.length - index - 1;
                    final tecnico = tecnicosListSelect[reverseIndex];
                    final resumo = resumosTecnico[tecnico.nome] ?? _ResumoTecnico();
                    return TilesGestao(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AtendenteDetalhesPage(
                              tipo: TipoFuncionario.tecnico,
                              onPress: () => removerTecnico(reverseIndex),
                              funcionario: tecnico,
                              onEdit: () async {},
                            ),
                          ),
                        );
                      },
                      widgetcustom: tecnicosListSelect[reverseIndex],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: theme.primary,
          onPressed: () {
            // cargoAtual == 'admin' ? modalAddFuncionarios(
            //   _bodyModal(),
            //   context,
            //   valueListenable,
            //   onPress: () {
            //     final text = nomeController.text.trim();
            //     if (text.isEmpty) return;
            //     addTecnico();
            //   }
            // ) :
            // AppFlushbar.error('Somente administradores podem adicionar tecnicos');
          },
          label: const Text("Adicionar"),
          icon:const Icon(Icons.add, color: Colors.white),
        ).animate().scale()
    );
  }

  Widget _bodyModal () {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text('Cadastrar Técnico',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        CustomTextField(
          controller: nomeController,
          keyboardType: TextInputType.text,
          labelText: 'Nome',
          hintText: '',
          onChanged: (value) {
            _validate();
          },
        ),
        CustomTextField(
          controller: numeroController,
          keyboardType: TextInputType.number,
          labelText: 'Número de Contato',
          hintText: '(00) 00000-0000',
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            TelefoneInputFormatter(),
          ],
          onChanged: (value) {
            _validate();
          },
        ),
      ],
    );
  }

  void _validate () {
    nomeController.text.isEmpty || numeroController.text.length < 14 ? valueListenable.value = false : valueListenable.value = true;
  }

}

class _ResumoTecnico {
  int quantidadeServicos;
  double valorTotal;

  _ResumoTecnico({
    this.quantidadeServicos = 0,
    this.valorTotal = 0.0,
  });
}



