import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/text_field.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Classe simples para modelar o acessório
class AcessorioItem {
  String nome;
  double valor;

  AcessorioItem({
    required this.nome,
    required this.valor,
  });
}

// Classe para empacotar o resultado que será devolvido para a tela anterior
class AcessoriosResult {
  final double total;
  final String totalFormatado;
  final String descricao;
  final List<AcessorioItem> itens;

  AcessoriosResult({
    required this.total,
    required this.totalFormatado,
    required this.descricao,
    required this.itens,
  });
}

class AcessoriosScreen extends StatefulWidget {
  // Recebe a lista atual caso o usuário queira editar o que já adicionou antes
  final List<AcessorioItem> itensIniciais;

  const AcessoriosScreen({
    super.key,
    this.itensIniciais = const [],
  });

  @override
  State<AcessoriosScreen> createState() => _AcessoriosScreenState();
}

class _AcessoriosScreenState extends State<AcessoriosScreen> {
  late List<AcessorioItem> _itens;
  final _currency = NumberFormat.simpleCurrency(locale: 'pt_BR');

  @override
  void initState() {
    super.initState();
    // Cria uma cópia da lista para não alterar a original caso o usuário cancele
    _itens = List.from(widget.itensIniciais);
  }

  void _removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  // --- MODAL DE ADIÇÃO ---
  void _mostrarModalAdicionar() {
    if (_itens.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Limite máximo de 10 acessórios atingido.")),
      );
      return;
    }

    final nomeCtrl = TextEditingController();
    final valorCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Adicionar Acessório"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: nomeCtrl,
                labelText: "Nome do item",
                hintText: "Ex: Película de Vidro",
                maxLenght: 20,
                capitalization: TextCapitalization.sentences,
              ),
              CustomTextField(
                controller: valorCtrl,
                labelText: "Valor (R\$)",
                hintText: "0,00",
                maxLenght: 9,
                counterText: '',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(moeda: true),
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            AnimatedBuilder(
                animation: Listenable.merge([nomeCtrl, valorCtrl]),
                builder: (context, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: nomeCtrl.text.isNotEmpty && valorCtrl.text.isNotEmpty
                        ? () {
                      double valor = UtilBrasilFields.converterMoedaParaDouble(valorCtrl.text);
                      setState(() {
                        _itens.add(AcessorioItem(nome: nomeCtrl.text, valor: valor));
                      });
                      Navigator.pop(context);
                    }
                        : null,
                    child: const Text("Adicionar"),
                  );
                }
            ),
          ],
        );
      },
    );
  }

  // --- FUNÇÃO DE CONFIRMAÇÃO ---
  void _confirmarEVoltar() {
    double total = _itens.fold(0, (sum, item) => sum + item.valor);
    String totalFormatado = _currency.format(total).replaceAll('R\$', '').trim();
    String descricao = _itens.map((e) => "${e.nome} (${_currency.format(e.valor)})").join(', ');

    final resultado = AcessoriosResult(
      total: total,
      totalFormatado: totalFormatado,
      descricao: descricao,
      itens: _itens,
    );

    // Devolve o objeto empacotado para a tela anterior
    Navigator.pop(context, resultado);
  }

  @override
  Widget build(BuildContext context) {
    double totalAtual = _itens.fold(0, (sum, item) => sum + item.valor);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Acréscimos/Acessórios"),
      ),
      body: _itens.isEmpty
          ? const Center(
        child: Text(
          "Nenhum item adicionado ainda.",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _itens.length,
        itemBuilder: (context, index) {
          final item = _itens[index];
          return CustomCard(
            //elevation: 1,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(item.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(_currency.format(item.valor)),
              trailing: IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: Colors.red,
                  hoverColor: Colors.red.withValues(alpha: 0.1),
                ),
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _removerItem(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarModalAdicionar,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Adicionado:", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(
                    _currency.format(totalAtual),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
              FilledButton(
                onPressed: totalAtual == 0 ? null : _confirmarEVoltar,
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  //padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text("Confirmar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}