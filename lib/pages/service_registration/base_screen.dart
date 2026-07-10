import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:assistencia_os/pages/service_registration/cliente_step.dart';
import 'package:assistencia_os/pages/service_registration/models/servico_repository.dart';
import 'package:assistencia_os/pages/service_registration/pagamento_step.dart';
import 'package:assistencia_os/pages/service_registration/servico_step.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../custom_widgets/appbar_btn.dart';
import '../../custom_widgets/dialog.dart';
import '../../services/pdf_services.dart';
import '../premium_page.dart';
import 'finalizar_step.dart';
import 'models/data_cadastro.dart';
import 'package:flutter/rendering.dart';

class BaseScreen extends StatefulWidget {
  final int index;
  final int? clienteId;

  const BaseScreen({super.key, this.index = 1, this.clienteId});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late int index = widget.index;

  // Variável que controla a animação do FAB
  bool _isFabExtended = true;

  DataCadastro dataCadastro = DataCadastro();
  DataCliente dataCliente = DataCliente();
  ServicoRepository servicoRepository = ServicoRepository();
  final PdfServices _pdfServices = PdfServices();

  final _formKeyCliente = GlobalKey<FormState>();
  final _formKeyPagamento = GlobalKey<FormState>();
  final _formKeyServico = GlobalKey<FormState>();

  Widget getBody() {
    if (widget.clienteId != null) {
      dataCliente.clienteId = widget.clienteId;
    }
    switch (index) {
      case 1:
        return ClienteStep(data: dataCliente, formKey: _formKeyCliente);
      case 2:
        return ServicoStep(data: dataCadastro, formKey: _formKeyServico);
      case 3:
        return PagamentoStep(data: dataCadastro, formKey: _formKeyPagamento);
      case 4:
        return FinalizarStep(data: dataCadastro);
      default:
        return ClienteStep(data: dataCliente, formKey: _formKeyCliente);
    }
  }

  String getLabelAppBar () {
    switch (index) {
      case 1:
        return 'Dados do Cliente';
      case 2:
        return 'Dados do Serviço';
      case 3:
        return 'Pagamento';
      case 4:
        return 'Finalizar';
      default:
        return '';
    }
  }

  Future<dynamic> _avisoSair() {
    return CustomDialog2.show(
      context: context,
      title: 'Atenção',
      description: 'Deseja sair dessa tela? Os dados não serão salvos.',
      confirmText: 'Sim',
      cancelText: 'Cancelar',
      onConfirm: () async {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    // return showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //         title: const Text('Atenção'),
    //         content: const Text('Deseja sair dessa tela? Os dados não serão salvos.'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: const Text('Cancelar'),
    //           ),
    //           FilledButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //               Navigator.pop(context);
    //             },
    //             child: const Text('Sim'),
    //           ),
    //         ]
    //     );
    //   }
    // );
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Retorna a nossa variável para a tela anterior
        _avisoSair();
      },
      child: Scaffold(
      
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 20,
          title: Text(
            getLabelAppBar(),
            key: ValueKey(index),
          ).animate()
              .fade(duration: 250.ms)
              .slideY(begin: 0.4, curve: Curves.easeOutCubic),
          actions: [
      
            Visibility(
              visible: index == 4,
              //replacement: const SizedBox(),
              child: _printBtns(),
            ),
      
            Visibility(
              visible: index != 4,
              child: AppbarBtn(
                icon: Icons.close_rounded,
                onPressed: () => _avisoSair(),
                foregroundColor: Colors.red,
                margin: const EdgeInsets.only(right: 8),
              ),
            ),
      
            const SizedBox(width: 8),
          ],
        ),
      
        // BOTÃO FLUTUANTE ANIMADO AQUI
        floatingActionButton: _buildAnimatedFab(),
      
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            // Se o usuário rolou para baixo (lendo o form), esconde o texto
            if (notification.direction == ScrollDirection.reverse) {
              if (_isFabExtended) setState(() => _isFabExtended = false);
            }
            // Se rolou para cima (voltando), mostra o texto
            else if (notification.direction == ScrollDirection.forward) {
              if (!_isFabExtended) setState(() => _isFabExtended = true);
            }
            return true;
          },
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 16),
                    SizedBox(
                      height: 42,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface,
                        ),
                        onPressed: index == 1 || index == 4 ? null : () {
                          setState(() {
                            if (index > 1) index--;
                            _isFabExtended = true; // Expande ao voltar o step
                          });
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Flexible(
                      child: CustomCard(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // Considerando que seu total de passos seja 4.
                            // Se o index for 1 = 25%, 2 = 50%, 3 = 75%, 4 = 100%.
                            final double progressPercentage = (index.clamp(0, 4)) / 4;
      
                            return Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                // 1. Fundo da barra (Barra vazia)
                                Container(
                                  height: 10,
                                  //width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
      
                                // 2. Barra de progresso preenchida e animada
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeOutCubic,
                                  height: 10,
                                  width: constraints.maxWidth * progressPercentage,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        index == 4 ? Colors.greenAccent.shade700 : Theme.of(context).colorScheme.primary,
                                        index == 4 ? Colors.green : Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                                      ], // Mantendo o estilo do card anterior
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: theme.primary,
                        //borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${index.toString()}/4",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
      
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 900),
      
                      transitionBuilder: (child, animation) {
                        final inFromRight = Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ));
      
                        final outToLeft = Tween<Offset>(
                          begin: Offset.zero,
                          end: const Offset(-1.0, 1.0),
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInCubic,
                        ));
      
                        // AnimatedSwitcher não informa se é entrada ou saída,
                        // então usamos Fade + Slide juntos
                        return SlideTransition(
                          position: animation.status == AnimationStatus.reverse
                              ? outToLeft
                              : inFromRight,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: KeyedSubtree(
                        key: ValueKey(index),
                        child: getBody(),
                      ),
                    ),
                  ),
                ),
      
      
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                //   child: CustomElevatedButton(
                //     backgroundColor: buttonColor,
                //     posicao: IconAlignment.end,
                //     icon: Icon(
                //       index == 4 ? Icons.check_sharp : Icons.arrow_forward,
                //     ),
                //     label: index == 4 ? "Finalizar" : "Avançar",
                //     click: () {
                //
                //     },
                //   ),
                // ),
                // const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedFab() {
    return GestureDetector(
      onTap: _avancarStep,
      child: AnimatedContainer(
        // Duração e Curva são o segredo da suavidade
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
        height: 56,
        // Se estiver expandido, padding maior. Se não, padding de botão circular.
        padding: EdgeInsets.symmetric(horizontal: _isFabExtended ? 24.0 : 16.0),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(30), // Borda bem arredondada (Pílula)
          boxShadow: [
            BoxShadow(
              color: buttonColor.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        // O Row garante que o Ícone e o Texto fiquem lado a lado
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ícone estático (sempre visível)
            Icon(
              index == 4 ? Icons.check_sharp : Icons.arrow_forward,
              color: Colors.white,
            ),

            // O AnimatedSize faz o texto "nascer" e "sumir" suavemente
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              alignment: Alignment.centerLeft,
              child: _isFabExtended
                  ? Padding(
                // Esse padding separa o ícone do texto apenas quando expandido
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  index == 4 ? "Finalizar" : "Avançar",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              )
              // Quando _isFabExtended for falso, ele encolhe para tamanho zero
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  bool _clienteValido = true;
  bool _servicoValido = true;
  bool _pagamentoValido = true;

  void _avancarStep() {
    setState(() {
      if (index == 1) {
        final valid = _formKeyCliente.currentState?.validate() ?? false;

        setState(() {
          _clienteValido = valid;
        });

        if (!valid) {
          AppFlushbar.error('Preencha os campos obrigatórios!');
          return;
        }

        index++;
      } else if (index == 2) {
        final valid = _formKeyServico.currentState?.validate() ?? false;

        setState(() {
          _servicoValido = valid;
        });

        if (!valid) {
          AppFlushbar.error('Preencha os campos obrigatórios!');
          return;
        }
        index++;
      } else if (index == 3) {
        final valid = _formKeyPagamento.currentState?.validate() ?? false;

        setState(() {
          _pagamentoValido = valid;
        });

        if (!valid) {
          AppFlushbar.error('Preencha os campos obrigatórios!');
          return;
        }

        servicoRepository.salvar(dataCadastro, dataCliente);
        index++;
      } else {
        Navigator.pop(context);
      }
    });
  }

  Widget _printBtns () {
    return Row(
      children: [
        AppbarBtn(
          icon: Icons.print,
          onPressed: () => _pdfServices.imprimirPDF( dataCadastro.dadosClienteFinalizados, dataCadastro.dadosOsFinalizados, context),
          margin: EdgeInsets.zero,
        ),
        Badge(
          isLabelVisible: !dataCadastro.checkAssinatura,
          offset: const Offset(-5, 5),
          label:
          const Text(
            'Pro',),
          child: AppbarBtn(
            icon: FluentIcons.share_16_filled,
            margin: EdgeInsets.zero,
            onPressed: () {
              if (dataCadastro.checkAssinatura) {
                _pdfServices.compartilharPDF(dataCadastro.dadosClienteFinalizados, dataCadastro.dadosOsFinalizados, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Você precisa de uma assinatura para acessar esse recurso',
                    ),
                    duration: Duration(seconds: 5),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PremiumPage()),
                );
              }
            },
            //label: 'Compartilhar',
          ),
        ),
      ],
    );
  }

  Color get buttonColor {
    // Etapa final
    if (index == 4) {
      return Colors.green;
    }

    // Validação do formulário do cliente
    if (index == 1) {
      return _clienteValido
          ? Theme.of(context).colorScheme.primary
          : Colors.red;
    }

    // Validação do formulário do serviço
    if (index == 2) {
      return _servicoValido
          ? Theme.of(context).colorScheme.primary
          : Colors.red;
    }

    if (index == 3) {
      return _pagamentoValido
          ? Theme.of(context).colorScheme.primary
          : Colors.red;
    }

    return Theme.of(context).colorScheme.primary;
  }

}



