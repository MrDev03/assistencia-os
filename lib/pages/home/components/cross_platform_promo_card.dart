import 'dart:io';
import 'dart:ui';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CrossPlatformPromoCard extends StatelessWidget {
  // Substitua pelos seus links reais
  final String linkAndroid = "https://play.google.com/store/apps/details?id=com.mr.dev.assistencia&pcampaignid=web_share";
  final String linkWindows = "https://apps.microsoft.com/detail/9N0XGLP5GNXL?hl=pt-br&gl=BR&ocid=pdpshare";
  final EdgeInsetsGeometry padding;

  const CrossPlatformPromoCard({
    super.key,
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 0),
  });

  @override
  Widget build(BuildContext context) {
    // Detecta a plataforma atual
    final bool isWindows = Platform.isWindows;

    final String title = isWindows
        ? 'Baixe o App para Android'
        : 'Use também no Computador';

    final String subtitle = isWindows
        ? 'Tenha o sistema na palma da sua mão.'
        : 'Baixe a versão desktop para Windows.';

    final IconData icon = isWindows
        ? Icons.phone_iphone_rounded
        : Icons.desktop_mac_rounded; // Ícones arredondados estilo Apple

    return Padding(
      padding: padding,
      child: InkWell(
        onTap: () => _showModal(context, isWindows),
        borderRadius: BorderRadius.circular(24),
        child: CustomCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showModal(BuildContext context, bool isWindows) {

    final link = isWindows ? linkAndroid : linkWindows;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28), // Bordas bem arredondadas
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(
              maxWidth: 300
            ),
            decoration: BoxDecoration(
              color: isDark? const Color(0xFF252525) : const Color(0xFFF2F5F9),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isWindows ? Icons.phone_android_rounded : Icons.desktop_windows_rounded,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  isWindows ? 'App para Android' : 'App para Windows',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  isWindows
                      ? 'Escaneie o código abaixo com o seu celular ou copie o link de download.'
                      : 'Copie o link abaixo e acesse no seu computador para instalar o sistema.',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // EXIBE O QR CODE APENAS NO WINDOWS
                if (isWindows) ...[
                  CustomCard(
                    borderRadius: 18,
                    padding: const EdgeInsets.all(5),
                    child: QrImageView(
                      data: link,
                      version: QrVersions.auto,
                      size: 150.0,
                      eyeStyle: QrEyeStyle(
                        color: isDark ? Colors.white : Colors.black
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        color: isDark ? Colors.white : Colors.black,
                        dataModuleShape: QrDataModuleShape.circle
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // ÁREA DO LINK COPIÁVEL
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          link,
                          style: const TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy_rounded, size: 20),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: link)).then((_) {

                            AppFlushbar.success('Link copiado!');
                            if (!context.mounted) return;
                            Navigator.pop(context); // Fecha o modal após copiar
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // BOTÃO FECHAR
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'),
                ),
              ],
            ),
          ).animate().fade(delay: 150.ms).scale(curve: Curves.easeOutBack),
        );
      },
    );
  }
}