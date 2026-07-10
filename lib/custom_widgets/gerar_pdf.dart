import 'package:assistencia_os/models/options_model/options_model.dart';
import 'package:assistencia_os/models/servico_model/servico_model.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../db_helper/db_helper.dart';
import '../models/cliente_model/cliente_model.dart';
import '../models/empresa_model/empresa_model.dart';
import 'gerar_pdf.dart' as pw;

// Supondo que seus widgets personalizados sejam parecidos com pw.Text,
// o código abaixo os reutiliza dentro de estruturas de layout melhores.

Future<Uint8List> gerarPDF( Cliente? cliente, Servico servico ) async {

  // --- PREPARAÇÃO DE DADOS ---
  final Empresa? empresa = await DatabaseHelper.getEmpresa();
  final checkAssinatura = await DatabaseHelper.isar.subscriptionSettings.get(0);

  final pdf = pw.Document();
  final dateFormatter = DateFormat('dd/MM/yyyy');
  final data = dateFormatter.format(DateTime.now());
  final marca = (servico.marca?.isNotEmpty == true) ? servico.marca! : 'Não informado';

  final materialIcons = pw.Font.ttf(
    await rootBundle.load('assets/fonts/MaterialIcons-Regular.ttf'),
  );

  List<dynamic> listaAcrescimo = servico.acessorios!.split('), ').map((item) {
    // Se removermos a divisão do ") ", precisamos recolocar o ")"
    if (!item.endsWith(')')) {
      return '$item)';
    }
    return item;
  }).toList();

  // Tratamento de valores
  // final double valorOriginal = double.tryParse(
  //   (servico.valor ?? "0").toString().replaceAll('.', '').replaceAll(',', '.'),
  // ) ?? 0.0;

  // final double entradaDouble = double.tryParse(
  //   (servico.valor2 ?? "0").toString().replaceAll('.', '').replaceAll(',', '.'),
  // ) ?? 0.0;

  final double aPagar = (servico.valorOriginalServicoDouble ?? 0) + (servico.valorTotalAcessoriosDouble ?? 0) - (servico.valor2 ?? 0);

  // double get valor1 {
  //   double total = (valorServico + valorAcessorios) - valor2;
  //   if (total < 0) total = 0;
  //   return total;
  // }

  final currency = NumberFormat.simpleCurrency(locale: 'pt_BR');

  Uint8List? assinaturaBytes;
  if (empresa?.assinatura?.isNotEmpty ?? false) {
    assinaturaBytes = Uint8List.fromList(empresa!.assinatura!);
  }

  String dataentrega = servico.dataEntrega != null ? servico.dataEntrega!.replaceAll('•', ' às ') : '';

  Uint8List? logoBytes;
  if (empresa?.logoBytes != null && (checkAssinatura?.isPremium ?? false)) {
    logoBytes = Uint8List.fromList(empresa!.logoBytes!);
  }

  int getDeviceIconCode(String? tipo) {
    switch (tipo) {
      case 'Celular':
        return 0xe325; // phone_android
      case 'Smartwatch':
        return 0xe334; // watch
      case 'Tablet':
        return 0xe330; // tablet_android
      case 'Notebook':
        return 0xe31e; // laptop
      case 'Computador':
        return 0xe30a; // computer (desktop)
      case 'Caixa de Som':
        return 0xe32d; // speaker
      case 'Fone de Ouvido':
        return 0xe310; // headset
      case 'Outros':
      default:
        return 0xe337; // devices_other (ícone genérico)
    }
  }

  // Cor primária para detalhes (Azul escuro profissional ou cinza escuro)
  const PdfColor primaryColor = PdfColors.blueGrey900;
  const PdfColor accentColor = PdfColors.grey200;

  // --- MÉTODOS AUXILIARES DE LAYOUT (Dentro da função para acessar seus widgets) ---

  // Cria uma linha de informação com fundo alternado opcional
  pw.Widget buildInfoRow(String label, String value, {bool isBold = false}) {
    return pw.Container(
      decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColors.grey400,
            width: 0.5,
          )
      ),
      child: pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 3, horizontal: 7),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.SizedBox(
              child: BoryText(txt: '$label:  ', fontWeight: pw.FontWeight.bold), // Se BoryText aceitar style, use bold
            ),
            pw.Expanded(
              child: BoryText(txt: value.isEmpty  ? '-' : value),
            ),
          ],
        ),
      )
    );
  }

  // --- CONSTRUÇÃO DO PDF ---
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(30), // Margem um pouco maior para elegância
      build: (context) => [

        // 1. CABEÇALHO MODERNO
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // Dados da Empresa
            pw.Flexible(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  TitleText(txt: empresa?.nome ?? 'Empresa'),
                  if (empresa?.slogan != null)
                    pw.Text(empresa!.slogan!, style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 10)),
                  pw.SizedBox(height: 8),
                  if (empresa?.cnpj!.isNotEmpty == true) BoryText(txt: 'CNPJ: ${empresa!.cnpj}'),
                  BoryText(txt: empresa?.endereco ?? ''),
                  BoryText(txt: 'Tel: ${empresa?.telefone1 ?? ''} ${empresa?.telefone2?.isNotEmpty == true ? ' / ${empresa!.telefone2}' : ''}'),
                ],
              ),
            ),
            // Logo
            if (logoBytes != null)
              pw.Container(
                height: 70,
                width: 70,
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(8),
                  image: pw.DecorationImage(
                    image: pw.MemoryImage(logoBytes),
                  ),
                ),
              ),
          ],
        ),

        pw.SizedBox(height: 15),

        // 2. BARRA DE TÍTULO DA O.S.
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(8),
          decoration: const pw.BoxDecoration(
            color: primaryColor,
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('ORDEM DE SERVIÇO', style: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 14)),
              pw.Text('Data: $data', style: const pw.TextStyle(color: PdfColors.white, fontSize: 10)),
            ],
          ),
        ),

        pw.SizedBox(height: 15),

        // 3. CLIENTE E FINANCEIRO (Lado a Lado)
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Coluna Cliente
            pw.Expanded(
              flex: 6,
              child: pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    SubTitleText(txt: 'Dados do Cliente'),

                    pw.SizedBox(height: 5),
                    TitleText(txt: cliente?.nome ?? 'Não informado'), // Nome em destaque
                    pw.SizedBox(height: 5),
                    // Adicione telefone ou endereço do cliente aqui se tiver
                  ],
                ),
              ),
            ),

            if (servico.acessorios!.isNotEmpty == true)...[
              pw.SizedBox(width: 10),
              pw.Expanded(
                flex: 8,
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      SubTitleText(txt: 'Acréscimos'),
                      pw.SizedBox(height: 5),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: listaAcrescimo.map((item) {
                          return pw.BoryText(txt: servico.acessorios!.isNotEmpty ? "+ $item" : 'Não informado');
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ],

            pw.SizedBox(width: 10),

            // Coluna Financeira (Card de Destaque)
            pw.Expanded(
              flex: servico.acessorios!.isNotEmpty ? 7 : 3,
              child: pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(4),
                  border: pw.Border.all(color: PdfColors.grey300),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    SubTitleText(txt: 'Resumo Financeiro'),
                    pw.Divider(color: PdfColors.grey400, thickness: 0.5),

                    if (servico.valorOriginalServicoDouble != 0)
                      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                        BoryText(txt: 'Valor do Serviço:'), BoryText(txt: currency.format(servico.valorOriginalServicoDouble), /*color: PdfColors.red800*/)
                      ]),

                    if ((servico.valorTotalAcessoriosDouble ?? 0) > 0)
                      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                        BoryText(txt: 'Acréscimos:'), BoryText(txt: '+ ${currency.format(servico.valorTotalAcessoriosDouble)}', /*color: PdfColors.red800*/)
                      ]),

                    if ((servico.valor2 ?? 0) > 0)
                      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                        BoryText(txt: servico.formaPgto1 != '' && servico.formaPgto2 != '' ? 'Pagameto 1: ' : 'Entrada:'), BoryText(txt: "- ${currency.format(servico.valor2)}", /*color: PdfColors.red800*/)
                      ]),

                    if (servico.formaPgto1 != '' && servico.formaPgto2 != '')
                      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                        BoryText(txt: 'Pagameto 2: '), BoryText(txt: "- ${currency.format(servico.valor1Double)}", /*color: PdfColors.red800*/)
                      ]),

                      pw.Divider(thickness: 0.5, borderStyle: pw.BorderStyle.dashed),

                    pw.SizedBox(height: 5),
                    pw.Text('A PAGAR', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                    if (servico.formaPgto1 != '')...[
                        pw.Text(
                          "PAGO",
                          style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColors.green),
                        ),
                    ] else ...[
                      pw.Text(
                        currency.format(aPagar),
                        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: primaryColor),
                      ),
                    ],

                    //pw.SizedBox(height: 5),
                    // if (servico.formaPgto1.isNotEmpty)
                    //   pw.Text('${servico.formaPgto1} ${servico.formaPgto1 == 'Cartão' ? " - ${servico.debitoCredito}" : ''}', style: const pw.TextStyle(fontSize: 9)),
                    // if (servico.qtdParcelas1?.isNotEmpty ?? false)
                    //   pw.Text(servico.qtdParcelas1, style: const pw.TextStyle(fontSize: 9)),
                  ],
                ),
              ),
            ),
          ],
        ),

        pw.SizedBox(height: 15),

        // 4. DETALHES TÉCNICOS (Layout em "Caixa")
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(4),
            color: accentColor, // Fundo leve cinza
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(children: [
                pw.Icon(pw.IconData(getDeviceIconCode(servico.tipoDeAparelho)), font: materialIcons, size: 14), // Ícone de celular/device (font padrão)
                pw.SizedBox(width: 5),
                SubTitleText(txt: 'Dados do Aparelho & Serviço'),
              ]),
              pw.SizedBox(height: 15),
              // pw.Divider(color: PdfColors.grey400, thickness: 0.5),
              // pw.SizedBox(height: 5),

              // Tabela Implícita usando Rows
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: buildInfoRow('Aparelho', servico.tipoDeAparelho ?? ''),
                    ),
                    pw.Expanded(
                      child: buildInfoRow('Modelo', servico.modelo ?? '---'),
                    ),
                    if (servico.marca!.isNotEmpty)
                    pw.Expanded(
                      child: buildInfoRow('Marca', marca),
                    ),
                  ]
              ),

              //buildInfoRow('Problemas', servico.problema!.isNotEmpty ? servico.problema ?? '---' : 'Não informado'),
              buildInfoRow('Serviços', servico.servicos!.isNotEmpty ? servico.servicos ?? '---' : 'Não informado'),
              if (servico.pecasUtilizadas!.isNotEmpty)
                buildInfoRow('Peças Utilizadas', servico.pecasUtilizadas ?? ''),

              pw.Row(
                children: [
                  if (servico.tipoDeFrontal!.isNotEmpty)
                  pw.Expanded(
                    flex: 5,
                    child: buildInfoRow('Tipo Frontal', servico.tipoDeFrontal ?? ''),
                  ),
                  if (servico.qualidadeFrontal!.isNotEmpty)
                  pw.Expanded(
                    flex: 7,
                    child: buildInfoRow('Qualidade Frontal', servico.qualidadeFrontal ?? ''),
                  ),
                  pw.Expanded(
                    flex: 5,
                    child: buildInfoRow('Garantia', servico.garantia ?? ''),
                  ),
                ]
              ),

              pw.Row(
                children: [
                  if (servico.tecnico!.isNotEmpty)
                  pw.Expanded(
                    child: buildInfoRow('Técnico', servico.tecnico ?? '---'),
                  ),
                  if (servico.dataEntrega!.isNotEmpty)
                  pw.Expanded(
                    child: buildInfoRow('Previsão Entrega', dataentrega ?? ''),
                  )
                ]
              ),
            ],
          ),
        ),

        // 5. OBSERVAÇÕES
        if (servico.obs!.isNotEmpty) ...[
          pw.SizedBox(height: 10),
          pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(4)
              ),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    SubTitleText(txt: 'Observações'),
                    pw.SizedBox(height: 2),
                    pw.Text(servico.obs ?? '---', textAlign: pw.TextAlign.justify, style: const pw.TextStyle(fontSize: 8,)),
                  ]
              )
          ),
        ],

        pw.SizedBox(height: 5),

        // 6. TERMOS E POLÍTICAS (Texto menor, justificado)
        pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (empresa?.politicaGarantia?.isNotEmpty ?? false)
                pw.Expanded(
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                    pw.SubTitleText(txt: 'Termos de Garantia'),
                    pw.Text(empresa!.politicaGarantia!, textAlign: pw.TextAlign.justify, style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                  ]),
                ),

              if ((empresa?.politicaGarantia?.isNotEmpty ?? false) && (empresa?.politicaPrivacidade?.isNotEmpty ?? false))
                pw.SizedBox(width: 10),

              if (empresa?.politicaPrivacidade?.isNotEmpty ?? false)
                pw.Expanded(
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                    pw.SubTitleText(txt: 'Política de Privacidade'),
                    pw.Text(empresa!.politicaPrivacidade!, textAlign: pw.TextAlign.justify, style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                  ]),
                ),
            ]
        ),

        pw.SizedBox(height: 5),
        pw.Spacer(),

        // 7. ASSINATURAS (Alinhadas no rodapé)
        pw.Container(
          constraints: const pw.BoxConstraints(minHeight: 60),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Container(
                constraints: const pw.BoxConstraints(maxWidth: 250),
                child: pw.Expanded(
                  child: pw.Column(
                    children: [
                      pw.Divider(color: PdfColors.black),
                      SubTitleText(txt: 'Assinatura do Cliente'),
                    ],
                  ),
                ),
              ),

              if (assinaturaBytes != null)...[
                pw.SizedBox(width: 40),
                pw.Expanded(
                  child: pw.Column(
                    children: [
                      pw.Image(pw.MemoryImage(assinaturaBytes), width: 100),
                      pw.Divider(color: PdfColors.black),
                      SubTitleText(txt: 'Assinatura da Empresa'),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );

  return pdf.save();
}

class BoryText extends pw.StatelessWidget {

  final String txt;
  final pw.FontWeight? fontWeight;

  BoryText({
    required this.txt,
    this.fontWeight,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(txt,
      style: pw.TextStyle(
        fontSize: 10,
        color: PdfColors.black,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TitleText extends pw.StatelessWidget {
  final String txt;
  TitleText({required this.txt});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(txt,
      style: pw.TextStyle(
        fontSize: 14,
        color: PdfColors.black,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }
}

class SubTitleText extends pw.StatelessWidget {
  final String txt;
  SubTitleText({required this.txt});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(txt,
      style: pw.TextStyle(
        fontSize: 12,
        color: PdfColors.black,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }
}


