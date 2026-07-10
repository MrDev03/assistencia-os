import 'dart:io';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import '../custom_widgets/gerar_pdf.dart';

class PdfServices {

  Future<void> imprimirPDF( cliente, servico, BuildContext context) async {
    try {
      final pdf = await gerarPDF(cliente, servico);
      await Printing.layoutPdf(onLayout: (format) => pdf);
    } catch (e) {
      if (!context.mounted) return;
      AppFlushbar.error('Erro ao imprimir: $e');
      print('Erro ao imprimir: $e');
    }
  }

  Future<void> compartilharPDF( cliente, servico, BuildContext context) async {
    try {
      final pdf = await gerarPDF( cliente, servico );
      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/Ordem_servico-$cliente-${servico.id}.pdf',
      );
      await file.writeAsBytes(pdf);
      if (!context.mounted) return;

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          subject: 'Ordem de Serviço',
          text: 'Segue a Ordem de Serviço gerada.',
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao compartilhar: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

}