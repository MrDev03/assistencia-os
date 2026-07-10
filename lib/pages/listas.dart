
// List<String> models = [
//   'Apple',
//   'Samsung',
//   'Xiaomi',
//   'Motorola',
//   'Realme',
//   'Infinix (Positivo)',
//   'Huawei',
//   'Nokia',
//   'OnePlus',
//   'TCL',
//   'Sony',
//   'Asus',
//   'LG',
//   'Outros'
// ];

List<String> tPeca = [
  'Modulo Frontal',
  'Conector',
  'Sub-Placa',
  'Flex de carga',
  'Bateria',
  'Flex',
  'Flex Power',
  'Carcaça',
  'Tampa Traseira',
  'Alto Falante',
  'Auricular',
  'Câmera traseira',
  'Câmera frontal',
  'Tela',
  'Vidro',
  'Outro'
];

List<String> qualidade = [
  'Incell',
  'Oled',
  'TFT',
  'IPS',
  'Original Nacional',
  'Original China',
];

List<String> tipoDeAparelho = [
  'Celular',
  'Smartwatch',
  'Tablet',
  'Notebook',
  'Computador',
  'Caixa de Som',
  'Fone de Ouvido',
  'Outros'
];

final listaDeServicosComuns = [
  'Troca de Tela',
  'Troca de Bateria',
  'Troca de Conector',
  'Troca de Carcaça',
  'Troca do Vidro',
  'Troca de Sub-placa',
  'Limpeza de Conector',
  'Troca de flex power',
  'Troca de flex de carga',
  'Reparo na placa mãe',
  'Desoxidação',
  'Recuperação de arquivos',
  'Transferência de dados',
  'Colar tela',
  'Colar tampa',
  'Desbloqueio',
  'Formatação',
  'Limpeza',
  'Backup'
];

final List<String> problemasComuns = [
  "Tela quebrada",
  "Bateria descarregando rápido",
  "Sem touch",
  "Não liga",
  "Não Inicia",
  "Conector de carga com defeito",
  "Alto-falante sem som",
  "Microfone não funciona",
  "Auricular sem som",
  "Câmera não abre",
  "Aparelho esquentando",
  "Travamentos ou lentidão",
  "Wi-Fi não conecta",
  "Bluetooth não liga",
  "Molhado"
];

class BrandRepository {
  // ==========================================================
  // 1. O MAPA MESTRE (Todas as marcas do sistema em um só lugar)
  // ==========================================================
  static final Map<String, String> _allLogos = {
    // --- Big Tech (Celulares, Tablets, PC) ---
    'Apple': 'assets/images/apple.png',
    'Samsung': 'assets/images/samsung.png',
    'Xiaomi': 'assets/images/xiaomi.png',
    'Motorola': 'assets/images/motorola.png',
    'Google': 'assets/images/marcas/google.png',
    'Huawei': 'assets/images/huawei.png',
    'Honor': 'assets/images/marcas/honor.png',
    'Realme': 'assets/images/realme.png',
    'Infinix (Positivo)': 'assets/images/infinix.png',
    'Nokia': 'assets/images/nokia.png',
    'OnePlus': 'assets/images/oneplus.png',
    'Oppo': 'assets/images/marcas/oppo.png',
    'TCL': 'assets/images/tcl.png',
    'Sony': 'assets/images/sony.png',
    'Asus': 'assets/images/asus.png',
    'LG': 'assets/images/lg.png',
    'Microsoft': 'assets/images/marcas/microsoft.png', // Surface / Windows
    'Lenovo': 'assets/images/marcas/lenovo.png',

    // --- Computadores (Novas) ---
    'Dell': 'assets/images/marcas/dell-logo.png',
    'HP': 'assets/images/marcas/hp-logo.png',
    'Acer': 'assets/images/marcas/acer-logo.png',
    'Avell': 'assets/images/marcas/avell.png', // Marca BR Gamer
    'MSI': 'assets/images/marcas/msi-logo.png',
    'Razer': 'assets/images/marcas/razer-logo.png',
    'Compaq': 'assets/images/marcas/compaq.png',
    'Positivo': 'assets/images/marcas/positivo-logo.png',
    'Vaio': 'assets/images/marcas/vaio-logo.png',
    'Alienware': 'assets/images/marcas/alienware.png',

    // --- Áudio (Caixas de Som / Fones) ---
    'JBL': 'assets/images/marcas/jbl-logo.png',
    'Bose': 'assets/images/marcas/bose.png',
    'Sennheiser': 'assets/images/marcas/sennheiser-logo.png',
    'Edifier': 'assets/images/marcas/Edifier.png',
    'Harman Kardon': 'assets/images/marcas/harman-kardon-logo.png',
    'Marshall': 'assets/images/marcas/marshall-amplification-logo.png',
    'Anker': 'assets/images/marcas/anker-logo.png', // Soundcore
    'Beats': 'assets/images/marcas/beats-logo.png', // Beats by Dre
    'AKG': 'assets/images/marcas/akg-logo.png',
    'Philco': 'assets/images/marcas/philco-logo.png', // Muito comum em caixas de som no BR
    'Mondial': 'assets/images/marcas/mondial-logo.png', // Caixas de som baratas
    'Pulse': 'assets/images/marcas/logotipo-desconto-pulse.png', // Marca da Multilaser
    'Amvox': 'assets/images/marcas/amvox-logo-5.png',

    // --- Periféricos / Gamer (Fones) ---
    'Logitech': 'assets/images/marcas/logitech.png',
    'HyperX': 'assets/images/marcas/hyperx-logo.png',
    'Corsair': 'assets/images/marcas/corsair-memory.png',
    'Redragon': 'assets/images/marcas/redragon-logo.png',
    'Havit': 'assets/images/marcas/HAVIT.png',

    // --- Wearables Específicos (Já existiam) ---
    'Garmin': 'assets/images/marcas/garmin-logo.png',
    'Polar': 'assets/images/marcas/Polar-logo.png',
    'Suunto': 'assets/images/marcas/suunto-logo.png',
    'Coros': 'assets/images/marcas/COROS.png',
    'Fitbit': 'assets/images/marcas/fitbit-logo.png',
    'Withings': 'assets/images/marcas/Withings.jpg',
    'Amazfit': 'assets/images/marcas/amazfit-logo.png',
    'Haylou': 'assets/images/marcas/Haylou.png',
    'Mibro': 'assets/images/marcas/Mibro2.png',
    'Zeblaze': 'assets/images/marcas/zeblaze.png',
    'BlitzWolf': 'assets/images/marcas/BlitzWolf.png',
    'QCY': 'assets/images/marcas/qcy.jpg',
    'Kospet': 'assets/images/marcas/Kospet.png',
    'Mobvoi (TicWatch)': 'assets/images/marcas/Mobvoi.jpg',
    'Fossil': 'assets/images/marcas/fossil-logo.png',
    'Multi (Multilaser)': 'assets/images/marcas/multi-logo.png',
    'Technos': 'assets/images/marcas/Technos.png',
    'Amazon' : 'assets/images/marcas/Amazon.png',
  };

  // ==========================================================
  // 2. LISTAS DE NOMES (Filtros por Categoria)
  // ==========================================================

  // ... (Listas anteriores de Celular e Smartwatch mantidas aqui) ...

  static const List<String> _celularNames = [
    'Apple', 'Samsung', 'Xiaomi', 'Motorola', 'Google', 'Realme',
    'Infinix (Positivo)', 'Huawei', 'Nokia', 'OnePlus', 'Oppo',
    'TCL', 'Sony', 'Asus', 'LG'
  ];

  static const List<String> _smartwatchNames = [
    'Apple', 'Samsung', 'Google', 'Xiaomi', 'Huawei', 'Honor',
    'OnePlus', 'Oppo', 'Realme', 'Garmin', 'Polar', 'Suunto',
    'Coros', 'Fitbit', 'Withings', 'Amazfit', 'Haylou', 'Mibro',
    'Zeblaze', 'BlitzWolf', 'QCY', 'Kospet', 'Mobvoi (TicWatch)',
    'Fossil', 'Multi (Multilaser)', 'Technos'
  ];

  static const List<String> _tabletNames = [
    'Apple', 'Samsung', 'Lenovo', 'Xiaomi', 'Microsoft',
    'Amazon', 'Huawei', 'Motorola', 'Nokia', 'TCL', 'Realme',
    'Multi (Multilaser)', 'Vaio', 'Positivo'
  ];

  // --- NOVAS LISTAS ---

  static const List<String> _computerNames = [
    'Apple', 'Dell', 'HP', 'Lenovo', 'Acer', 'Asus', 'Samsung',
    'LG', 'Avell', 'MSI', 'Razer', 'Microsoft', 'Compaq',
    'Positivo', 'Vaio', 'Alienware',
  ];

  static const List<String> _speakerNames = [
    'JBL', 'Sony', 'LG', 'Samsung', 'Edifier', 'Harman Kardon',
    'Bose', 'Marshall', 'Anker', 'Philco',
    'Mondial', 'Pulse', 'Amvox', 'Google', 'Amazon', 'Xiaomi'
  ];

  static const List<String> _headphoneNames = [
    'Apple', 'Samsung', 'JBL', 'Xiaomi', 'Sony', 'Edifier',
    'Sennheiser', 'Bose', 'QCY', 'Haylou', 'Lenovo', 'Beats',
    'AKG', 'Anker', 'Huawei', 'Motorola',
    'Logitech', 'HyperX', 'Razer', 'Redragon', 'Havit', 'Corsair'
  ];

  // ==========================================================
  // 3. LÓGICA E GETTERS
  // ==========================================================

  static Map<String, String> _buildMap(List<String> names) {
    return {
      for (var name in names)
        name: _allLogos[name] ?? ''
    };
  }

  // Carrega a logomarca em qualquer lugar
  static const String defaultLogo = 'assets/images/marcas/semLogo.png';

  static String getLogoByBrand(String brand) {
    return _allLogos[brand] ?? defaultLogo;
  }

  static Map<String, String> getByType(String type) {
    return switch (type) {
      'Celular' => celulares,
      'Tablet' => tablets,
      'Notebook' || 'PC' || 'Computador' => computadores,
      'Smartwatch' || 'Relógio' => smartwatches,
      'Caixa de Som' => caixasSom,
      'Fone de Ouvido' => fones,
      _ => celulares, // Retorno padrão caso não encontre (fallback)
    };
  }

  // Getters Públicos
  static Map<String, String> get celulares => _buildMap(_celularNames);
  static Map<String, String> get smartwatches => _buildMap(_smartwatchNames);
  static Map<String, String> get tablets => _buildMap(_tabletNames);

  // Novos Getters
  static Map<String, String> get computadores => _buildMap(_computerNames);
  static Map<String, String> get caixasSom => _buildMap(_speakerNames);
  static Map<String, String> get fones => _buildMap(_headphoneNames);
}

// 1. A Classe de Definição (Mantenha igual)
class TipoPecaDefinition {
  final String nome;
  final String descricao;

  const TipoPecaDefinition(this.nome, this.descricao);

  @override
  String toString() => nome;
}

// 2. A Lista Completa Atualizada
const List<TipoPecaDefinition> tiposDePecaLista = [
  // --- 1. Tela e Exibição ---
  TipoPecaDefinition('Módulo Frontal (Tela)', 'Display completo (LCD/OLED + Touch + Aro)'),
  TipoPecaDefinition('Display', 'Tela principal do aparelho responsável por mostrar o conteúdo'),
  TipoPecaDefinition('Touchscreen', 'Apenas o digitalizador (vidro sensível ao toque)'),
  TipoPecaDefinition('Vidro / Lente', 'Vidro externo para recondicionamento (sem touch)'),
  TipoPecaDefinition('Película Polarizadora', 'Filtro de luz do display'),

  // --- 2. Energia e Carregamento ---
  TipoPecaDefinition('Bateria', 'Fonte de energia interna'),
  TipoPecaDefinition('Conector de Carga', 'Peça soldável (USB-C, Micro-USB, Lightning)'),
  TipoPecaDefinition('Placa de Carga (Sub)', 'Placa inferior com conector e microfone'),
  TipoPecaDefinition('Flex de Carga', 'Cabo que liga a Sub-placa à Placa Mãe'),
  TipoPecaDefinition('Flex de Indução', 'Bobina de indução / NFC'),

  // --- 3. Carcaça e Estrutura ---
  TipoPecaDefinition('Tampa Traseira', 'Carcaça posterior (Vidro ou Plástico)'),
  TipoPecaDefinition('Aro / Chassi', 'Estrutura lateral ou meio do aparelho'),
  TipoPecaDefinition('Gaveta de Chip', 'Slot / Bandeja para SIM Card e SD'),
  TipoPecaDefinition('Lente da Câmera', 'Vidrinho de proteção externo da câmera'),
  TipoPecaDefinition('Botões Externos', 'Capas plásticas/metálicas (Volume e Power)'),

  // --- 4. Câmeras ---
  TipoPecaDefinition('Câmera Traseira Principal', 'Módulo principal de fotos'),
  TipoPecaDefinition('Câmera Auxiliar', 'Módulos secundários (Ultrawide, Macro, Telefoto)'),
  TipoPecaDefinition('Câmera Frontal', 'Câmera de Selfie'),

  // --- 5. Áudio e Vibração ---
  TipoPecaDefinition('Alto-falante', 'Campainha principal (Mídia e Viva-voz)'),
  TipoPecaDefinition('Auricular', 'Falante superior para chamadas no ouvido'),
  TipoPecaDefinition('Microfone', 'Captura de áudio (Soldado ou avulso)'),
  TipoPecaDefinition('Motor Vibra Call', 'Mecanismo de vibração'),

  // --- 6. Conectividade e Sensores ---
  TipoPecaDefinition('Flex Power / Volume', 'Cabo interno dos botões laterais'),
  TipoPecaDefinition('Sensor Biometria', 'Leitor de digital (Traseiro, Lateral ou Tela)'),
  TipoPecaDefinition('Antena Coaxial', 'Fios de sinal (Branco, Preto, Azul)'),
  TipoPecaDefinition('Antena Wi-Fi / GPS', 'Adesivos ou peças plásticas de sinal'),
  TipoPecaDefinition('Sensor de Proximidade', 'Sensor que apaga a tela em chamadas'),

  // --- 7. Placas e Eletrônica ---
  TipoPecaDefinition('Placa Mãe (Mainboard)', 'Placa principal lógica do aparelho'),
  TipoPecaDefinition('CI (Circuito Integrado)', 'Componentes (PMIC, Codec, CPU, Memória)'),

  // --- Outros ---
  TipoPecaDefinition('Parafusos / Blindagens', 'Kit de fixação interna'),
  TipoPecaDefinition('Outros', 'Peças não listadas acima'),
];