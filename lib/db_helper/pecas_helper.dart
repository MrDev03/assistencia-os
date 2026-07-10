
import 'package:isar_community/isar.dart';

import '../models/estoque_pecas_model/estoque_pecas_model.dart';

class PecasHelper {

  static Future<void> baixarEstoque(Isar isar, List<EstoquePecas> pecasSelecionadas) async {
    await isar.writeTxn(() async {
      for (var peca in pecasSelecionadas) {
        // 1. Buscamos a peça mais recente no banco pelo ID
        // (Isso evita erro se alguém mudou o estoque enquanto você escolhia)
        final pecaNoBanco = await isar.estoquePecas.get(peca.id);

        if (pecaNoBanco != null) {
          // 2. Verifica se tem estoque antes de baixar (Opcional, mas recomendado)
          if (pecaNoBanco.quantidade > 0) {
            pecaNoBanco.quantidade -= 1; // Baixa 1 unidade

            // 3. Salva a alteração
            await isar.estoquePecas.put(pecaNoBanco);
            print('Baixado: ${pecaNoBanco.modelo} | Nova qtd: ${pecaNoBanco.quantidade}');
          } else {
            print('ERRO: Estoque insuficiente para ${pecaNoBanco.modelo}');
            // Aqui você poderia lançar uma exceção se quisesse travar a venda
          }
        }
      }
    });
  }

  static Stream<List<EstoquePecas>> streamBuscarPecas({
    required Isar isar,
    String termoBusca = '',
    String? filtroTipo,
    bool? filtroUsada,
    bool apenasComEstoque = false,
  }) {
    return isar.estoquePecas
        .filter()

    // 🔎 Busca textual
        .optional(termoBusca.isNotEmpty, (q) => q.group((j) => j
        .modeloContains(termoBusca, caseSensitive: false)
        .or()
        .barCodeContains(termoBusca, caseSensitive: false)
        .or()
        .marcaContains(termoBusca, caseSensitive: false),
    ))

    // 🧩 Tipo
        .optional(filtroTipo != null, (q) =>
        q.tipoContains(filtroTipo!, caseSensitive: false))

    // 📦 Nova ou usada
        .optional(filtroUsada != null,
            (q) => q.usadaEqualTo(filtroUsada!))

    // 📊 Apenas com estoque
        .optional(apenasComEstoque,
            (q) => q.quantidadeGreaterThan(0))

    // 📅 Ordenação
        .sortByDataCadastroDesc()

    // 👀 Stream reativo
        .watch(fireImmediately: true);
  }
}