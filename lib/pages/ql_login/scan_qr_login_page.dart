import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrLoginPage extends StatefulWidget {
  const ScanQrLoginPage({super.key});

  @override
  State<ScanQrLoginPage> createState() => _ScanQrLoginPageState();
}

class _ScanQrLoginPageState extends State<ScanQrLoginPage> {
  bool _processing = false;

  void _onDetect(BarcodeCapture capture) async {
    if (_processing) return;

    final barcode = capture.barcodes.first;
    final rawValue = barcode.rawValue;

    if (rawValue == null) return;

    setState(() => _processing = true);

    try {
      // Exemplo esperado:
      // assistencia://login?session=UUID
      final uri = Uri.parse(rawValue);

      if (uri.scheme != 'assistencia' || uri.host != 'login') {
        throw Exception('QR Code inválido');
      }

      final sessionId = uri.queryParameters['session'];

      if (sessionId == null) {
        throw Exception('Sessão não encontrada');
      }

      // 👉 próximo passo: enviar sessionId para o backend
      debugPrint('Session ID lido: $sessionId');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR Code lido com sucesso')),
      );

      Navigator.pop(context, sessionId); // retorna para quem chamou
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Erro ao ler QR Code: $e'),
        ),
      );
      setState(() => _processing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR Code'),
      ),
      body: Stack(
        children: [
          MobileScanner(
            fit: BoxFit.cover,
            onDetect: _onDetect,
          ),

          // Overlay simples
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
          ),

          if (_processing)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
