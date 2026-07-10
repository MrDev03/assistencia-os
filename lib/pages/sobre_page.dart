import 'package:assistencia_os/custom_widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home/home.dart';

class SobrePage extends StatefulWidget {
  final bool configPage;
  const SobrePage({
    super.key,
    this.configPage = false,
  });

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  String appName = '';
  String version = '';
  String buildNumber = '';
  String pacote = '';
  DateTime? dataInstalacao;
  DateTime? dataAtualizacao;

  @override
  void initState() {
    super.initState();
    carregarInformacoes();
  }

  Future<void> carregarInformacoes() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appName = info.appName;
      version = info.version;
      pacote = info.packageName;
      dataInstalacao = info.installTime;
      dataAtualizacao = info.updateTime;
      buildNumber = info.buildNumber;
    });
  }

  Future<void> abrirLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Não foi possível abrir $url';
    }
  }

  String formatarData(DateTime? data) {
    if (data == null) return 'Não disponível';

    // Exemplo: "16/09/2025 08:30"
    return DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(data);
  }

  @override
  Widget build(BuildContext context) {

    final tema = Theme.of(context);

    return Scaffold(
      appBar: widget.configPage && context.isDesktop ? null : AppBar(
        title: const Text('Sobre o App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: Image.asset('assets/icons/ic_launcher.png').image,
                  backgroundColor: Colors.transparent,

                ),
              ).animate(
                onPlay: (controller) => controller.repeat(),
              ).moveY(
                begin: -5,
                end: 5,
                duration: 1200.ms,
                curve: Curves.easeInOut,
              )
                  .then() // volta
                  .moveY(
                begin: 5,
                end: -5,
                duration: 1200.ms,
                curve: Curves.easeInOut,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Assistência OS',
                  style: tema.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  'Versão: $version+$buildNumber',
                  style: tema.textTheme.bodyMedium,
                ),
              ),
              const Divider(height: 40),

              const ListTile(
                leading: Icon(Icons.developer_mode, color: Colors.blueAccent),
                title: Text('Desenvolvedor'),
                subtitle: Text('Marcelo Nunes'),
              ),
              ListTile(
                leading: const Icon(Icons.android, color: Colors.green),
                title: const Text('Nome do pacote'),
                subtitle: Text(pacote ?? 'Não disponível'),
              ),
              ListTile(
                leading: const Icon(Icons.date_range, color: Colors.redAccent),
                title: const Text('Data de instalação'),
                subtitle: Text(formatarData(dataInstalacao)),
              ),
              ListTile(
                leading: const Icon(Icons.update, color: Colors.orangeAccent),
                title: const Text('Última atualização'),
                subtitle: Text(formatarData(dataAtualizacao)),
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined, color: Colors.purpleAccent),
                title: const Text('E-mail'),
                subtitle: const Text('marcelo.n.p97@gmail.com'),
                onTap: () {
                  abrirLink('mailto:marcelo.n.p97@gmail.com');
                },
                trailing: Icon(Icons.open_in_new, size: 18, color: tema.colorScheme.primary),
              ),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.pinkAccent),
                title: const Text('Website'),
                subtitle: const Text('www.nextcodestudio.com.br'),
                onTap: () {
                  abrirLink('https://www.nextcodestudio.com.br');
                },
                trailing: Icon(Icons.open_in_new, size: 18, color: tema.colorScheme.primary),
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined, color: Colors.blueAccent),
                title: const Text('Política de Privacidade'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: 'Política de Privacidade 🔒',
                      content: 'Seu dados são importantes para nós. Este aplicativo coleta e armazena apenas informações necessárias para seu funcionamento, como cadastros, listas ou registros feitos diretamente por você no próprio dispositivo.'

                        'As informações inseridas não são compartilhadas, vendidas ou transferidas a terceiros. Todos os dados são armazenados localmente no seu aparelho ou, quando aplicável, em serviços na nuvem de forma segura.'

                        'Nós respeitamos sua privacidade e garantimos que seus dados serão utilizados exclusivamente para melhorar sua experiência no aplicativo.'

                        'Se você tiver qualquer dúvida sobre sua privacidade, entre em contato conosco.',
                      onPressedLeft: () {  },
                      onPressedRight: () {
                        Navigator.pop(context);
                      },
                      rightButtonText: 'Ok',
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.gavel_outlined, color: Colors.redAccent),
                title: const Text('Termos de Uso'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: 'Termos de Uso 📄',
                      content: termos,
                      onPressedLeft: () {  },
                      onPressedRight: () {
                        Navigator.pop(context);
                      },
                      rightButtonText: 'Ok',
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
              Center(
                child: Text(
                  '© ${DateTime.now().year} NexCode Studio\nTodos os direitos reservados.',
                  textAlign: TextAlign.center,
                  style: tema.textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Versão $version',
                  style: tema.textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String termos = 'Ao utilizar este aplicativo, você concorda com os seguintes termos:\n\n'

      ' • Este app foi desenvolvido para uso pessoal e/ou profissional, com o objetivo de auxiliar na organização de informações, cadastros e registros.\n\n'

      ' • O uso dos dados inseridos no aplicativo é de responsabilidade do usuário.\n\n'

      ' • Não nos responsabilizamos por perdas, danos ou prejuízos decorrentes do uso indevido do aplicativo ou de eventuais falhas técnicas.\n\n'

      ' • As informações cadastradas são armazenadas localmente no seu dispositivo ou, quando disponível, em serviços de nuvem de forma segura.\n\n'

      ' • O usuário é responsável por manter seus dados atualizados e realizar backups, quando necessário.\n\n'

      ' • Ao continuar utilizando o aplicativo, você declara estar ciente e de acordo com este Termo de Uso.';

}

//============= Termos de uso ===============

class Politicas extends StatelessWidget {
  const Politicas({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        children: [
          TextSpan()
        ]
      ),
    );
  }
}
