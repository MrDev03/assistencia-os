import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherHelper {

  /// Abre o aplicativo do WhatsApp com o número e a mensagem predefinida.
  static Future<void> abrirWhatsApp({
    required String telefone,
    required String mensagem,
  }) async {
    final numeroLimpo = telefone.replaceAll(RegExp(r'\D'), '');

    if (numeroLimpo.isEmpty || numeroLimpo.length < 10) {
      AppFlushbar.error('Número de telefone inválido. Por favor, verifique.');
      return;
    }

    final url = Uri.parse(
      'https://wa.me/55$numeroLimpo?text=${Uri.encodeComponent(mensagem)}',
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        AppFlushbar.error('Não foi possível encontrar o WhatsApp instalado.');
      }
    } catch (e) {
      AppFlushbar.error('Erro inesperado ao tentar abrir o WhatsApp.');
    }
  }

  /// Abre o discador padrão do aparelho para realizar uma ligação.
  static Future<void> fazerLigacao({
    required String numero,
  }) async {
    final numeroLimpo = numero.replaceAll(RegExp(r'\D'), '');
    final url = Uri(scheme: 'tel', path: numeroLimpo);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        AppFlushbar.error('Não foi possível abrir o discador para o número $numero.');
      }
    } catch (e) {
      AppFlushbar.error('Erro inesperado ao tentar realizar a ligação.');
    }
  }

  /// Abre o aplicativo de e-mail padrão do usuário (Gmail, Mail, etc).
  static Future<void> enviarEmail({
    required String email,
    String assunto = '',
    String corpo = '',
  }) async {
    if (email.trim().isEmpty || !email.contains('@')) {
      AppFlushbar.error('Endereço de e-mail inválido.');
      return;
    }

    final String? query = _encodeQueryParameters(<String, String>{
      if (assunto.isNotEmpty) 'subject': assunto,
      if (corpo.isNotEmpty) 'body': corpo,
    });

    final Uri url = Uri(scheme: 'mailto', path: email, query: query);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        AppFlushbar.error('Nenhum aplicativo de e-mail encontrado no dispositivo.');
      }
    } catch (e) {
      AppFlushbar.error('Erro inesperado ao tentar abrir o e-mail.');
    }
  }

  /// Abre o aplicativo de mapas ou o navegador com o endereço fornecido.
  static Future<void> abrirMapa({
    required String endereco,
  }) async {
    if (endereco.trim().isEmpty) {
      AppFlushbar.error('Endereço não informado.');
      return;
    }

    // Usar a URL universal do Google Maps garante que abra no app (se instalado)
    // ou no navegador de forma limpa, funcionando bem em iOS e Android.
    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(endereco)}'
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        AppFlushbar.error('Não foi possível abrir o mapa.');
      }
    } catch (e) {
      AppFlushbar.error('Erro inesperado ao tentar abrir o mapa.');
    }
  }

  /// Método privado para encodar corretamente os parâmetros do E-mail (evita bugs com espaços)
  static String? _encodeQueryParameters(Map<String, String> params) {
    if (params.isEmpty) return null;
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}


// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void abrirWhatsApp(BuildContext context, String telefone, String message) async {
//
//   String phoneNumber = telefone.replaceAll(RegExp(r'[^0-9]'), ''); // Remove tudo que não é número
//
//   if (phoneNumber.isEmpty || phoneNumber.length < 11) {
//     if (!context.mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.red,
//         content: Text('Número de telefone inválido. Por favor, verifique.'),
//       ),
//     );
//     return;
//   }
//
//   final url = Uri.parse('https://wa.me/55$phoneNumber?text=${Uri.encodeComponent(message)}');
//
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url, mode: LaunchMode.externalApplication);
//   } else {
//     if (!context.mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.red,
//         content: Text('Não foi possível abrir o WhatsApp.'),
//       ),
//     );
//   }
// }
//
// Future<void> fazerLigacao(String numero) async {
//   final Uri url = Uri(scheme: 'tel', path: numero);
//
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     throw 'Não foi possível realizar a ligação para $numero';
//   }
// }