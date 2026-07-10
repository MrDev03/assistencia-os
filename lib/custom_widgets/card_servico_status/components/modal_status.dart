

import 'package:assistencia_os/pages/home/home.dart';
import 'package:assistencia_os/pages/premium_page.dart';
import 'package:flutter/material.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import '../../../configs/search_color.dart';
import '../../../db_helper/db_helper.dart';
import '../../../models/cliente_model/cliente_model.dart';
import '../../../models/servico_model/servico_model.dart';
import '../../../pages/details_os/details_os_screen.dart';
import '../../../services/launcher_helper.dart';
import '../../../sync/modules/status_sync.dart';
import '../../elevated_button.dart';
import '../../loading_widget.dart';
import '../../text_field.dart';
import '../../top_msg.dart';

class ModalStatus extends StatefulWidget {
  final Servico os;
  final Cliente cliente;
  final String statusSelecionado;
  final VoidCallback onTap;
  final Function(String status) onStatusChanged;
  final bool checkAssinatura;
  const ModalStatus({
    super.key,
    required this.os,
    required this.cliente,
    required this.statusSelecionado,
    required this.onTap,
    required this.onStatusChanged,
    required this.checkAssinatura,
  });

  @override
  State<ModalStatus> createState() => _ModalStatusState();
}

class _ModalStatusState extends State<ModalStatus> {

  String motivoFalha = '';
  final statusSync = StatusSync();
  final valueListenable = ValueNotifier('');

  // NOVO: Variável de estado local do modal
  late String _statusAtual;

  final List<String> _statusList = [
    'em andamento',
    'sem solução',
    'aguardando cliente',
    'entregue'
  ];

  @override
  void initState() {
    super.initState();
    // NOVO: Inicializa a variável local com o status que veio da tela principal
    _statusAtual = widget.statusSelecionado;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'entregue':
        return Colors.greenAccent.shade700;
      case 'sem solução':
        return Colors.red;
      case 'aguardando cliente':
        return Colors.purple.shade700;
      case 'em andamento':
        return Colors.orange;
      default:
        return Colors.blueAccent.shade700;
    }
  }

  Future<void> salvarDadosEAtualizar (String status) async {
    await DatabaseHelper.salvarStatusLocal(widget.os.id, status, motivoFalha);
    await statusSync.updateStatusFirebase(widget.os.id, status, motivoFalha);
    widget.onStatusChanged(status);
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.pop(context, true);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final searchColor = context.appbarButtonColor;
    //final valueListenable = ValueNotifier(widget.statusSelecionado);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: searchColor,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: context.isMobile,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(['sem solução', 'entregue'].contains(widget.os.status)
                      ? 'Finalizado'
                      : 'Mudar status',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${widget.cliente.nome ?? "Desconhecido"} • ${widget.os.modelo ?? "Desconhecido"}',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 5,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        //Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (_) => DetalhesServicoPage(
                              servico: widget.os, cliente: widget.cliente,
                            )
                        )
                        );
                      },
                      icon: const Icon(Icons.visibility),
                      label: const Text('Ver detalhes'),
                    ),
                    const Spacer(),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.blueAccent.shade700,
                        backgroundColor: Colors.blueAccent.withValues(alpha: 0.1),
                      ),
                      onPressed: () {
                        if (!widget.checkAssinatura) {
                          _navegarPremium();
                          return;
                        }
                        LauncherHelper.fazerLigacao(numero: widget.cliente.telefone ?? '');
                      },
                      icon: const Icon(Icons.phone),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.green.shade700,
                        backgroundColor: Colors.green.withValues(alpha: 0.1),
                      ),
                      onPressed: () {
                        if (!widget.checkAssinatura) {
                          _navegarPremium();
                          return;
                        }
                        LauncherHelper.abrirWhatsApp(telefone: widget.cliente.telefone ?? '', mensagem: 'Olá ${widget.cliente.nome}, tudo bem?');
                      },
                      icon: const Icon(RemixIcon.whatsappFillDir),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: ['sem solução', 'entregue'].contains(widget.os.status)
                      ? false
                      : true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // alignment: WrapAlignment.center,
                    // spacing: 8, // espaço horizontal
                    // runSpacing: 8, // espaço vertical
                    children: _statusList
                        .where((status) => status != widget.os.status)
                        .map((status) {

                      // ATUALIZADO: Usando a variável local _statusAtual
                      final selecionado = _statusAtual == status;

                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          // ATUALIZADO: Agora atualizamos o estado local do modal
                          setState(() {
                            _statusAtual = status;
                          });

                          valueListenable.value = status;

                          // Continuamos notificando a tela de trás (opcional, dependendo da sua regra de negócio)

                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: selecionado
                                ? _getStatusColor(status).withValues(alpha: 0.1)
                                : Colors.transparent,
                            border: Border.all(
                              color: selecionado
                                  ? _getStatusColor(status)
                                  : Colors.grey.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status),
                                  shape: BoxShape.circle,
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  status.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              if (selecionado)
                                Icon(Icons.check_circle, color: _getStatusColor(status), size: 18)
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder(
                    valueListenable: valueListenable,
                    builder: (context, value, child) {

                      final isDisabled = value == '' && !['sem solução', 'entregue'].contains(widget.os.status);

                      return Visibility(
                        visible: widget.checkAssinatura,
                        replacement: CustomElevatedButton(
                          click: () {
                            Navigator.pop(context);
                            _navegarPremium();
                          },
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          label: 'Recurso PRO',
                          posicao: IconAlignment.end,
                          icon: const Icon(Icons.lock),
                        ),
                        child: CustomElevatedButton(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            click: isDisabled ? null : () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => const LoadingWidget(
                                  message: [
                                    'Salvando status',
                                    'Atualizando dados',
                                    'Sincronizando...',
                                  ],
                                ),
                              );

                              await Future.delayed(const Duration(milliseconds: 50));

                              try {

                                // SEM PAGAMENTO
                                if (_statusAtual == 'entregue' && widget.os.formaPgto1 == '') {

                                  await salvarDadosEAtualizar(_statusAtual);

                                  if (!context.mounted) return;
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (_) => DetalhesServicoPage(
                                        servico: widget.os, cliente: widget.cliente,
                                      )
                                  )
                                  );

                                  AppFlushbar.success('Status atualizado com sucesso!');

                                  // SEM SOLUÇÃO
                                } else if (_statusAtual == 'sem solução') {
                                  if (!context.mounted) return;
                                  Navigator.of(context, rootNavigator: true).pop();
                                  showDialog(
                                      context: context,
                                      builder: (_) => _DialogMotivo(
                                          callback: (motivo) async {
                                            motivoFalha = motivo;
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (_) => const LoadingWidget(
                                                message: [
                                                  'Salvando status',
                                                  'Atualizando dados',
                                                  'Sincronizando...',
                                                ],
                                              ),
                                            );
                                            await salvarDadosEAtualizar(_statusAtual);
                                            AppFlushbar.success('Status atualizado com sucesso!');
                                          }
                                      )
                                  );

                                  // MUDAR DE ATRASADO PARA ANDAMENTO NOVAMENTE COM PRAZO
                                  //} else if (widget.os.status == 'atrasado' && _statusAtual == 'em andamento') {
                                  // aqui vou colocar o codigo perguntando se o usuario que definir uma nova data de entrega


                                  // COLOCAR AQUI UM DIALOGO QUANDO O USUARIO MARCAR COMO AGUARDANDO CLIENTE PEDIR PARA MANDAR MSG NO WHATSAPP

                                  // Para abrir o WhatsApp:
                                  // await LauncherHelper.abrirWhatsApp(
                                  //   context: context,
                                  //   telefone: widget.cliente.telefone,
                                  //   mensagem: "Olá, seu aparelho já está pronto!",
                                  // );

                                  // REABRIR OS
                                } else if (['sem solução', 'entregue'].contains(widget.os.status)) {
                                  await salvarDadosEAtualizar('em andamento');
                                  AppFlushbar.success('OS de ${widget.cliente.nome?.toUpperCase()} do aparelho ${widget.os.modelo} Reaberta com sucesso!');

                                  // ATUALIZAR
                                } else {
                                  await salvarDadosEAtualizar(_statusAtual);
                                  AppFlushbar.success('Status atualizado com sucesso!');
                                }

                              } catch (e) {
                                if (!context.mounted) return;
                                Navigator.of(context, rootNavigator: true).pop();
                                AppFlushbar.error(
                                  'Erro ao salvar status',
                                );
                              }
                            },
                            label: ['sem solução', 'entregue'].contains(widget.os.status)
                                ? 'Reabrir OS'
                                : 'Atualizar'
                        ),
                      );
                    }
                ),
              ],
            )
        ),
      ),
    );
  }

  void _navegarPremium () {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumPage()));
  }

}

class _DialogMotivo extends StatefulWidget {
  final Function(String motivo) callback;

  const _DialogMotivo({
    required this.callback,
  });

  @override
  State<_DialogMotivo> createState() => _DialogMotivoState();
}

class _DialogMotivoState extends State<_DialogMotivo> {

  final motivoController = TextEditingController();

  @override
  void dispose() {
    motivoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.warning_amber_rounded,
        color: Colors.redAccent,
        size: 48,
      ),
      title: const Text('Motivo'),
      content: CustomTextField(
        hintText: 'Descreva o motivo (Opcional)',
        maxLenght: 100,
        controller: motivoController,
        maxLines: 4,
      ),
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  side: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: const Text('Finalizar'),
                onPressed: () {
                  Navigator.pop(context);
                  widget.callback(motivoController.text);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}