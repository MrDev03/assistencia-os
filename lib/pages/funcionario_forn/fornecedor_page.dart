import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/services/launcher_helper.dart';
import 'package:assistencia_os/pages/home/home.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assistencia_os/custom_widgets/msg_body_vazio.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:assistencia_os/custom_widgets/contador.dart';
import 'package:assistencia_os/custom_widgets/elevated_button.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

import '../../custom_widgets/appbar_btn.dart';
import '../../db_helper/cargo_helper.dart';
import '../../db_helper/db_helper.dart';
import '../../models/fornecedor_model/fornecedor_model.dart';
import '../../sync/modules/fornecedor_sync.dart';

class FornecedoresPage extends StatefulWidget {
  final bool configPage;
  const FornecedoresPage({
    super.key,
    this.configPage = false,
  });

  @override
  State<FornecedoresPage> createState() => _FornecedoresPageState();
}

class _FornecedoresPageState extends State<FornecedoresPage> {

  final nomeController = TextEditingController();
  final numeroController = TextEditingController();
  List<Fornecedor> fornecedorListSelect = [];
  String? cargoAtual;
  final syncFornecedores = FornecedorSync();

  @override
  void initState() {
    super.initState();
    loadList();
  }

  /// 🔥 Carregar do banco
  Future<void> loadList() async {
    final cargoSelecionado = await CargoHelper.lerCargo();
    final data = await DatabaseHelper.getAllFornecedores();
    if (mounted) {
      setState(() {
        fornecedorListSelect = data;
        cargoAtual = cargoSelecionado;
      });
    }
  }

  /// 🔥 Adicionar fornecedor
  Future<void> addFornecedor() async {
    final dataHora = "${UtilData.obterDataDDMMAAAA(DateTime.now())} • ${UtilData.obterHoraHHMM(DateTime.now())}";
    final newFornecedor = Fornecedor()
      ..nome = nomeController.text
      ..numero = numeroController.text
      ..dateTimeCadastro = dataHora
      ..createdAt = DateTime.now();

    await DatabaseHelper.insertFornecedor(newFornecedor);
    await loadList();
    nomeController.clear();
    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fornecedor ${newFornecedor.nome} adicionado'),
        duration: const Duration(seconds: 2),
      ),
    );
    await syncFornecedores.push(newFornecedor);
  }

  /// 🔥 Remover fornecedor com desfazer
  void removerFornecedor(int index) async {
    final removed = fornecedorListSelect[index];

    await syncFornecedores.deleteFornecedor(removed.id);

    setState(() {
      fornecedorListSelect.removeAt(index);
    });
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fornecedor ${removed.nome} removido'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () async {
            await DatabaseHelper.insertFornecedor(removed);
            await loadList();
          },
        ),
      ),
    );
  }

  String notifier = '';
  late final valueListenable = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: widget.configPage && context.isDesktop ? null : AppBar(
        title: const Text("Fornecedores"),
        centerTitle: true,
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
          tooltip: 'Voltar',
        ),
        actions: [
          Contador(text: fornecedorListSelect.length.toString()),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: fornecedorListSelect.isEmpty
                ? const Vazio(label: 'Nenhum fornecedor cadastrado')
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: fornecedorListSelect.length,
              itemBuilder: (context, index) {
                return customTile(
                  () => removerFornecedor(index),
                  context,
                  widgetcustom: fornecedorListSelect[index],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.primary,
        onPressed: () {},
        label: const Text("Adicionar"),
        icon:const Icon(Icons.add, color: Colors.white),
      )
    );
  }

  Widget _bodyModal() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text('Cadastrar Fornecedor',
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
          labelText: 'Nome do Fornecedor',
          hintText: 'Digite o nome do fornecedor',
          onChanged: (value) {
            //valueListenable.value = value;
          },
        ),
        CustomTextField(
          controller: numeroController,
          keyboardType: TextInputType.number,
          labelText: 'Número de Contato',
          hintText: 'Digite o número do fornecedor',
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            TelefoneInputFormatter(),
          ],
          onChanged: (value) {
            //valueListenable.value = value;
          },
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<bool>(
            valueListenable: valueListenable,
            builder: (context, value, child) {
              return CustomElevatedButton(
                label: "Cadastrar",
                sizeLabel: 16,
                click: nomeController.text.isEmpty || numeroController.text.length < 14 ? null : () {
                  final text = nomeController.text.trim();
                  if (text.isEmpty) return null;
                  addFornecedor();
                },
              );
            }
        ),
      ],
    );
  }
}

Widget customTile (VoidCallback onPressed, BuildContext context, {required widgetcustom}) {
  //final fornecedor = fornecedorListSelect[index];
  return AnimatedSize(
    duration: const Duration(milliseconds: 300),
    child: CustomCard(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Text(widgetcustom.dateTimeCadastro.toString(),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              widgetcustom.nome ?? "Sem nome",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              widgetcustom.numero == null || widgetcustom.numero!.isEmpty ? "Sem número" : widgetcustom.numero!,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            Divider(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.green.withValues(alpha: 0.1)),
                  ),
                  icon: const Icon(RemixIcon.whatsappLine, color: Colors.green),
                  onPressed: () => LauncherHelper.abrirWhatsApp(telefone: widgetcustom.numero, mensagem: 'Olá, ${widgetcustom.nome}'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.blue.withValues(alpha: 0.1)),
                    ),
                    icon: const Icon(Icons.phone, color: Colors.blueAccent),
                    onPressed: () => LauncherHelper.fazerLigacao(numero: widgetcustom.numero),
                  ),
                ),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red.withValues(alpha: 0.1)),
                  ),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onPressed,
                ),
              ],
            ),
            const SizedBox(height: 3)
          ],
        ),
      ),
    ),
  );
}





