import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  // Controlador para gerenciar flash e câmera
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates, // Evita ler o mesmo código 10x seguidas
    returnImage: false,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Escanear Código', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Botão de Flash
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              return IconButton(
                icon: Icon(
                  state == TorchState.on ? Icons.flash_on : Icons.flash_off,
                  color: Colors.white,
                ),
                onPressed: () => controller.toggleTorch(),
              );
            },
          ),
          // Botão de Trocar Câmera (Frontal/Traseira)
          IconButton(
            icon: const Icon(Icons.cameraswitch, color: Colors.white),
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {

              if (_isProcessing) return;

              final barcodes = capture.barcodes;
              if (barcodes.isEmpty) return;

              final code = barcodes.first.rawValue;
              if (code == null) return;

              _isProcessing = true; // 🔒 trava

              Navigator.pop(context, code);

              // final List<Barcode> barcodes = capture.barcodes;
              //
              // if (barcodes.isNotEmpty) {
              //   final String? code = barcodes.first.rawValue;
              //   if (code != null) {
              //     // Retorna o código para a tela anterior
              //     Navigator.pop(context, code);
              //   }
              // }
            },
          ),
          // Overlay Visual (A "Mira")
          Center(
            child: Container(
              width: double.infinity,
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(CupertinoIcons.barcode, color: Colors.redAccent, size: 30),
              ),
            ),
          ),
          // Texto de instrução
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Text(
              'Aponte para o código',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}