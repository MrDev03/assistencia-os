import 'package:isar_community/isar.dart';

part 'estoque_pecas_model.g.dart';

@Collection()
class EstoquePecas {
  Id id = Isar.autoIncrement;

  // --- BUSCA E PERFORMANCE ---

  @Index() // Garante que não existam 2 códigos iguais
  String? barCode;

  //@Index(caseSensitive: false) // Permite buscar "samsung" e achar "Samsung"
  String? modelo;

  //@Index() // Facilita filtros (ex: Mostrar só peças da Apple)
  String? marca;

  // --- DADOS BÁSICOS ---

  String? tipo;
  String? cor;
  String? qualidadeTela; // Ex: Original China, OLED, Incell
  String? descricao;

  // --- LISTAS (Sempre inicializadas) ---

  List<String> fotosUrl = [];
  List<String> fotosLocal = []; // caminho local
  List<String> modelosCompativeis = [];

  // --- VALORES E QUANTIDADES ---

  int quantidade = 0;

  // Dica: Double serve, mas cuidado com cálculos complexos.
  // Para estoque simples, está ótimo.
  double? valorCusto;
  double? valorVenda;

  // --- BOOLEANOS (Estados) ---

  bool usada = false;
  bool aro = false;

  // --- DATAS (Inicializadas para evitar Null) ---

  // Ao criar a variável já com valor, você nunca mais terá erro de null nessas datas
  DateTime dataCadastro = DateTime.now();
  DateTime dataUltimaAtualizacao = DateTime.now();
}
