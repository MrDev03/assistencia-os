import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/device_icon.dart';
import '../../custom_widgets/top_msg.dart';

// Enum para gerenciar os 3 estados possíveis de cada item
enum StatusChecklist { pendente, bom, ruim }

class ChecklistItemData {
  final String titulo;
  final IconData icone;

  ChecklistItemData(this.titulo, this.icone);
}

class ChecklistAparelhoScreen extends StatefulWidget {
  final String tipoAparelho;

  const ChecklistAparelhoScreen({super.key, required this.tipoAparelho});

  @override
  State<ChecklistAparelhoScreen> createState() =>
      _ChecklistAparelhoScreenState();
}

class _ChecklistAparelhoScreenState extends State<ChecklistAparelhoScreen> {
  // Agora o mapa guarda o Status do item
  final Map<String, StatusChecklist> _checklistState = {};
  List<ChecklistItemData> _itensDoChecklist = [];
  // List<String> itensBom = [];
  // List<String> itensRuim = [];

  // Cores de feedback
  final Color corBom = Colors.green.shade600;
  final Color corRuim = Colors.red.shade500;
  final Color corPendente = Colors.grey.shade400;

  Color getCorProgresso(double valor) {
    if (valor <= 0.35) return Colors.red;
    if (valor <= 0.65) return Colors.orange.shade700;
    if (valor <= 0.90) return Colors.yellow.shade700;
    return Colors.green;
  }

  @override
  void initState() {
    super.initState();
    _carregarItensChecklist();
  }

  void _carregarItensChecklist() {
    Map<String, List<ChecklistItemData>> listasPorAparelho = {
      'Celular': [
        ChecklistItemData('Tela / Touchscreen', Icons.touch_app),
        ChecklistItemData('Câmera Frontal', Icons.camera_front),
        ChecklistItemData('Câmera Traseira', Icons.camera_rear),
        ChecklistItemData('Microfone', Icons.mic),
        ChecklistItemData('Alto-falante', Icons.volume_up),
        ChecklistItemData('Auricular', Icons.hearing),
        ChecklistItemData('Carregamento', Icons.electrical_services),
        ChecklistItemData('Bateria', Icons.battery_charging_full),
        ChecklistItemData('Botões de Volume / Power', Icons.power_settings_new),
        ChecklistItemData('Wi-Fi / Bluetooth / Rede', Icons.wifi),
        ChecklistItemData('Sensores', Icons.sensors),
        ChecklistItemData('Biometria / Face ID', Icons.fingerprint),
        //ChecklistItemData('Ligado?', Icons.on_device_training),
      ],
      'Notebook': [
        ChecklistItemData('Tela (Display)', Icons.laptop_chromebook),
        ChecklistItemData('Teclado', Icons.keyboard),
        ChecklistItemData('Touchpad / Mouse', Icons.mouse),
        ChecklistItemData('Portas USB / HDMI', Icons.usb),
        ChecklistItemData('Bateria / Carregamento', Icons.battery_charging_full),
        ChecklistItemData('Webcam', Icons.videocam),
        ChecklistItemData('Alto-falante / Áudio', Icons.speaker),
        ChecklistItemData('Wi-Fi', Icons.wifi),
        ChecklistItemData('Dobradiças da Tela', Icons.build),
        ChecklistItemData('Processador', Icons.computer),
        ChecklistItemData('Memória RAM', Icons.memory),
        ChecklistItemData('SSD / HD', Icons.storage),
        ChecklistItemData('Placa de Vídeo', Icons.videocam),
        ChecklistItemData('Placa Mãe', Icons.computer),
      ],
      'Smartwatch': [
        ChecklistItemData('Tela / Touchscreen', Icons.watch),
        ChecklistItemData('Pulseira / Encaixes', Icons.link),
        ChecklistItemData('Sensor Cardíaco', Icons.favorite),
        ChecklistItemData('Botões Físicos', Icons.radio_button_checked),
        ChecklistItemData('Bateria', Icons.battery_charging_full),
        ChecklistItemData('Carregamento', Icons.electrical_services),
        ChecklistItemData('Bluetooth', Icons.bluetooth),
      ],
      'Tablet': [
        ChecklistItemData('Tela / Touchscreen', Icons.tablet_mac),
        ChecklistItemData('Câmeras', Icons.camera_alt),
        ChecklistItemData('Botões Físicos', Icons.smart_button),
        ChecklistItemData('Carregamento', Icons.electrical_services),
        ChecklistItemData('Bateria', Icons.battery_charging_full),
        ChecklistItemData('Alto-falantes', Icons.volume_up),
        ChecklistItemData('Wi-Fi', Icons.wifi),
      ],
      'Caixa de Som': [
        ChecklistItemData('Saída de som', Icons.volume_up),
        ChecklistItemData('Qualidade do áudio', Icons.graphic_eq),
        ChecklistItemData('Botões / Controles', Icons.smart_button),
        ChecklistItemData('Conexão Bluetooth', Icons.bluetooth),
        ChecklistItemData('Pareamento', Icons.sync),
        ChecklistItemData('Entrada auxiliar (P2)', Icons.headphones),
        ChecklistItemData('Entrada USB / Cartão SD', Icons.usb),
        ChecklistItemData('Bateria / Carregamento', Icons.battery_charging_full),
        ChecklistItemData('Indicadores LED', Icons.lightbulb),
      ],
      'Fone de Ouvido': [
        ChecklistItemData('Áudio (lado esquerdo)', Icons.hearing),
        ChecklistItemData('Áudio (lado direito)', Icons.hearing),
        ChecklistItemData('Microfone', Icons.mic),
        ChecklistItemData('Botões / Controles', Icons.smart_button),
        ChecklistItemData('Conexão Bluetooth', Icons.bluetooth),
        ChecklistItemData('Pareamento', Icons.sync),
        ChecklistItemData('Bateria / Carregamento', Icons.battery_charging_full),
        ChecklistItemData('Case de carga', Icons.inventory_2),
        ChecklistItemData('Sensor (in-ear)', Icons.sensors),
      ],
      'Outros': [
        ChecklistItemData('Liga / Desliga', Icons.power_settings_new),
        ChecklistItemData('Carcaça / Integridade', Icons.shield),
        ChecklistItemData('Conectores / Portas', Icons.settings_input_component),
        ChecklistItemData('Bateria / Energia', Icons.battery_full),
      ],
    };

    _itensDoChecklist = listasPorAparelho[widget.tipoAparelho] ?? listasPorAparelho['Outros']!;

    // Inicializa todos como pendentes
    for (var item in _itensDoChecklist) {
      _checklistState[item.titulo] = StatusChecklist.pendente;
    }
  }

  // O progresso agora avança se o item for classificado (Bom OU Ruim)
  double get _progresso {
    if (_checklistState.isEmpty) return 0.0;
    int avaliados = _checklistState.values
        .where((status) => status != StatusChecklist.pendente)
        .length;
    return avaliados / _checklistState.length;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Avaliação do Aparelho",
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              children: [
                DeviceIcon(
                    tipo: widget.tipoAparelho,
                    size: 18,
                    color: Colors.grey
                  // Dica: Se o seu DeviceIcon aceitar a propriedade 'color',
                  // você pode mudar a cor dele para branco quando estiver selecionado:
                  // color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
                ),
                Text(
                  widget.tipoAparelho,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          AppbarBtn(
            icon: Icons.refresh,
            onPressed: () {
              setState(() {
                _checklistState.clear();
                _carregarItensChecklist();
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Barra de progresso da avaliação
          CustomCard(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: _progresso),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        value: value,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          getCorProgresso(value),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 40,
                  child: Text(
                    "${(_progresso * 100).toInt()}%",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 100, top: 8),
              itemCount: _itensDoChecklist.length,
              itemBuilder: (context, index) {
                final item = _itensDoChecklist[index];
                final status = _checklistState[item.titulo]!;

                return _buildAvaliacaoCard(item, status);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildBotaoConfirmar(),
    );
  }

  Widget _buildAvaliacaoCard(ChecklistItemData item, StatusChecklist status) {

    final backgroundColor =
    (Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF141418)//Theme.of(context).colorScheme.surfaceContainer
        : Colors.white);

    // Define as cores dinamicamente baseadas no status
    Color corAtual = Colors.transparent;
    Color corIconeFundo = Colors.grey.shade100;
    Color corIcone = Colors.grey.shade600;

    if (status == StatusChecklist.bom) {
      corAtual = corBom;
      corIconeFundo = corBom.withValues(alpha: 0.15);
      corIcone = corBom;
    } else if (status == StatusChecklist.ruim) {
      corAtual = corRuim;
      corIconeFundo = corRuim.withValues(alpha: 0.15);
      corIcone = corRuim;
    }

    bool avaliado = status != StatusChecklist.pendente;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: avaliado ? corAtual.withValues(alpha: 0.05) : backgroundColor,
        borderRadius: BorderRadius.circular(45),
        border: Border.all(
          color: avaliado ? corAtual : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // Ícone do componente (dinâmico)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: corIconeFundo,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              item.icone,
              size: 24,
              color: corIcone,
            ),
          ),
          const SizedBox(width: 12),

          // Nome do Item
          Expanded(
            child: Text(
              item.titulo,
              style: TextStyle(
                fontSize: 15,
                color: avaliado ? Colors.black87 : Colors.grey.shade700,
                fontWeight: avaliado ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),

          // Botões de Ação (Ruim / Bom)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Botão Ruim (Com defeito)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checklistState[item.titulo] = StatusChecklist.ruim;
                  });
                },
                child: _buildActionBtn(
                  icon: Icons.close,
                  color: corRuim,
                  isSelected: status == StatusChecklist.ruim,
                ),
              ),
              const SizedBox(width: 8),

              // Botão Bom (Ok)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _checklistState[item.titulo] = StatusChecklist.bom;
                  });
                },
                child: _buildActionBtn(
                  icon: Icons.check,
                  color: corBom,
                  isSelected: status == StatusChecklist.bom,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Componente extraído para os botões de ação Redondos
  Widget _buildActionBtn({
    required IconData icon,
    required Color color,
    required bool isSelected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? color : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Icon(
        icon,
        size: 20,
        color: isSelected ? Colors.white : Colors.grey.shade400,
      ),
    );
  }

  Widget _buildBotaoConfirmar() {
    bool todosAvaliados = _progresso == 1.0;

    return GestureDetector(
      onTap: () {
        if (!todosAvaliados) {
          AppFlushbar.error('Por favor, avalie todos os itens antes de salvar.');
        } else {
          final itensBons = _checklistState.entries
              .where((e) => e.value == StatusChecklist.bom)
              .map((e) => e.key)
              .toList();

          final itensRuins = _checklistState.entries
              .where((e) => e.value == StatusChecklist.ruim)
              .map((e) => e.key)
              .toList();

          Navigator.pop(context, {
            'bons': itensBons,
            'ruins': itensRuins,
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width * 0.85,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: todosAvaliados
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.shade400,
          boxShadow: todosAvaliados
              ? [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ] : [],
        ),
        child: Center(
          child: Text(
            todosAvaliados ? "Salvar Avaliação" : "Avaliação Pendente",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}