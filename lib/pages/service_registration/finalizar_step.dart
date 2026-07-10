import 'package:assistencia_os/pages/service_registration/models/data_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import '../../custom_widgets/appbar_btn.dart';
import '../../custom_widgets/card.dart';
import '../../custom_widgets/gerar_pdf.dart' as pdf_wiget;
import '../../models/empresa_model/empresa_model.dart';
import '../../models/servico_model/servico_model.dart';
import '../../services/pdf_services.dart';
import '../premium_page.dart';

class FinalizarStep extends StatelessWidget {

  final DataCadastro data;

  FinalizarStep({
    super.key,
    required this.data,
    this.empresa,
  });

  final Empresa? empresa;
  final PdfServices _pdfServices = PdfServices();
  final DataCadastro dataCadastro = DataCadastro();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //btns(context),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 500
            ),
            child: CustomCard(
              key: const ValueKey('conclusao'),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'OS Salva ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.check_circle, color: Colors.green, size: 25),
                    ],
                  ),
                  //Text('Modelo: ${servicoSalvo?.modelo ?? ''}'),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 600,
                    child: PdfPreview(
                      build: (format) async => await pdf_wiget.gerarPDF( data.dadosClienteFinalizados, data.dadosOsFinalizados ?? Servico() ),
                      canChangeOrientation: false,
                      canChangePageFormat: false,
                      allowPrinting: true,
                      allowSharing: true,
                      pdfFileName: 'Ordem_Servico_${data.dadosOsFinalizados?.id ?? ''}.pdf',
                      maxPageWidth: 400,
                      useActions: false,
                      previewPageMargin: EdgeInsets.zero,
                      scrollViewDecoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      pdfPreviewPageDecoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btns (BuildContext ctx) {

    final theme = Theme.of(ctx).colorScheme;

    return Row(
      children: [
        //Text('R\$ ${_converterMoedaParaDouble()}'),
        AppbarBtn(
          icon: Icons.print,
          onPressed: () => _pdfServices.imprimirPDF( data.dadosClienteFinalizados, data.dadosOsFinalizados, ctx),
          margin: const EdgeInsets.only(right: 8),
        ),
        AppbarBtn(
          icon: Icons.share,
          margin: EdgeInsets.zero,
          onPressed: () {
            if (data.checkAssinatura) {
              _pdfServices.compartilharPDF(data.dadosClienteFinalizados, data.dadosOsFinalizados, ctx);
            } else {
              ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Você precisa de uma assinatura para acessar esse recurso',
                  ),
                  duration: Duration(seconds: 5),
                ),
              );
              Navigator.push(
                ctx,
                MaterialPageRoute(builder: (_) => const PremiumPage()),
              );
            }
          },
          //label: 'Compartilhar',
        ),
        if (!data.checkAssinatura)
        const Icon(RemixIcon.vipCrownLine, color: Colors.amber, size: 14),
      ],
    );
  }

}
