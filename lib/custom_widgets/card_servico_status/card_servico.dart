import 'dart:io';

import 'package:assistencia_os/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../db_helper/db_helper.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../../models/servico_model/servico_model.dart';
import '../card.dart';
import '../device_icon.dart';
import 'components/modal_status.dart';

class ServicoCard extends StatefulWidget {
  final Servico os;
  final Cliente cliente;
  final bool checkAssinatura;
  final VoidCallback onTap;

  const ServicoCard({
    super.key,
    required this.os,
    required this.cliente,
    required this.checkAssinatura,
    required this.onTap,
  });

  @override
  State<ServicoCard> createState() => _ServicoCardState();
}

class _ServicoCardState extends State<ServicoCard> {
  //final Stream<int> tempoStream =
  //Stream.periodic(const Duration(minutes: 1), (count) => count);

  String statusSelecionado = '';
  final isar = DatabaseHelper.isar;

  late Stream<int> tempoStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //definirStatus(widget.os.status);
    tempoStream = Stream.periodic(
      const Duration(minutes: 1),
      (x) => x,
    ).asBroadcastStream();
  }

  // void definirStatus(String? status) {
  //   statusSelecionado =
  //   _statusList.contains(status) ? status! : _statusList.first;
  // }

  @override
  Widget build(BuildContext context) {

      // Define cores e ícones baseados no status
    final statusConfig = _getStatusConfig(widget.os.status.toString(), widget.checkAssinatura);
    final statusColor = statusConfig['color'] as Color;
    final statusIcon = statusConfig['icon'] as IconData;
    final statusLabel = widget.checkAssinatura ? widget.os.status.toString() : "Status (Pro)";
    final dataEntrega = parseDataHora(widget.os.dataEntrega ?? "");

    return CustomCard(
      onTap: () async {

        final result = await _showAdaptiveModal();

        if (result == true) {
          setState(() {

          });
          //widget.onTap.call();
        }
      },
      borderRadius: 25,
      margin: const EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header do Card: Status e Data
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [

                  Expanded(
                    child: Text(widget.cliente.nome ?? "Desconhecido",
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),

                  // Status (tamanho fixo)
                  Animate(
                    onPlay: widget.os.status == 'em andamento' && widget.checkAssinatura ? (controller) => controller.repeat() : null,
                    effects: [
                      if (widget.os.status == 'em andamento' && widget.checkAssinatura)
                        const ShimmerEffect(
                          delay: Duration(milliseconds: 900),
                          duration: Duration(milliseconds: 500),
                        )
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: statusColor.withValues(alpha: 0.2),
                              blurRadius: 10,
                            )
                          ]
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, size: 12, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            statusLabel.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),//.animate(onPlay: (controller) => controller.repeat(period: const Duration(seconds: 1))).shimmer(duration: const Duration(milliseconds: 500)),
                  ),
                ],
              ),
            ),

            // Corpo do Card: Informações
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (dataEntrega != null)
                    StreamBuilder<int>(
                      stream: tempoStream,
                      builder: (context, snapshot) {

                        final diferenca = dataEntrega.difference(DateTime.now());

                        final isLate = diferenca.isNegative;

                        final String textoTempo;
                        // = isLate
                        //     ? "Atrasado há ${_formatarDuracao(diferenca.abs())}"
                        //     : "Faltam ${_formatarDuracao(diferenca)}";
                        if (isLate) {
                          textoTempo = "Atrasado há ${_formatarDuracao(diferenca.abs())}";
                          //DatabaseHelper.salvarStatusLocal(widget.os.id, 'atrasado');
                        } else {
                          textoTempo = "Faltam ${_formatarDuracao(diferenca)}";
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _InfoRow(
                            icon: _icon(Icons.timer_outlined),
                            label: "Prazo",
                            value: textoTempo,
                            rightTextColor: isLate ? Colors.red : Colors.green,
                          ),
                        );
                      },
                    ),
                  _InfoRow(
                    icon: _icon(Icons.date_range),
                    label: "Data",
                    value: widget.os.data ?? "Desconhecido",
                  ),
                  if (widget.os.status == 'sem solução')...[
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: _icon(Icons.eleven_mp_sharp),
                      label: "Motivo",
                      value: widget.os.motivo ?? 'Não informado',
                    )],
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: _icon(Icons.phone),
                    label: "Telefone",
                    value: widget.cliente.telefone ?? "Não informado",
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: DeviceIcon(tipo: widget.os.tipoDeAparelho.toString(), size: 16, color: Colors.grey[400],),
                    label: "Modelo",
                    value: widget.os.modelo ?? "Não informado",
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: _icon(Icons.build_circle_outlined),
                    label: "Serviços",
                    value: widget.os.servicos ?? "Não detalhado",

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon (icon) {
    return Icon(icon, size: 16, color: Colors.grey[400]);
  }

  String _formatarDuracao(Duration duracao) {
    if (duracao.inDays > 0) return "${duracao.inDays}d ${duracao.inHours % 24}h";
    if (duracao.inHours > 0) return "${duracao.inHours}h ${duracao.inMinutes % 60}m";
    return "${duracao.inMinutes}m";
  }

  Map<String, dynamic> _getStatusConfig(String status, bool isPremium) {
    if (!isPremium) return {'color': Colors.grey, 'icon': Icons.lock};

    switch (status.toLowerCase()) {
      case 'atrasado':
        return {'color': Colors.pink, 'icon': Icons.warning_amber_rounded};
      case 'sem solução':
        return {'color': Colors.red, 'icon': Icons.dangerous};
      case 'entregue':
        return {'color': Colors.greenAccent.shade700, 'icon': Icons.check_circle_outline};
      case 'aguardando cliente':
        return {'color': Colors.purple.shade700, 'icon': Icons.hourglass_top};
      case 'em andamento':
        return {'color': Colors.orange, 'icon': Icons.access_time};
      default:
        return {'color': Colors.blue, 'icon': Icons.info_outline};
    }
  }


  Future<bool?> _showAdaptiveModal() {
    final width = MediaQuery.of(context).size.width;

    if (width > 600) {
      // 👉 Dialog (desktop / tablet)
      return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: _buildModalContent(),
          );
        },
      );
    } else {
      // 👉 BottomSheet (mobile)
      return showModalBottomSheet<bool>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return _buildModalContent();
        },
      );
    }
  }

  Widget _buildModalContent() {
    return ModalStatus(
      os: widget.os,
      cliente: widget.cliente,
      statusSelecionado: statusSelecionado,
      onTap: widget.onTap,
      checkAssinatura: widget.checkAssinatura,
      onStatusChanged: (status) {
        setState(() {
          statusSelecionado = status;
        });
      },
    );
  }

}

class _InfoRow extends StatelessWidget {
  final Widget icon;
  final String label;
  final String value;
  final Color? rightTextColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.rightTextColor,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        icon,
        //Icon(icon, size: 16, color: Colors.grey[400]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        Expanded(
          child: Text(
            value == '' ? '---' : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: rightTextColor != null ? FontWeight.bold : FontWeight.w500,
              color: rightTextColor,
            ),
          ),
        ),
      ],
    );
  }
}


DateTime? parseDataHora(String dataHora) {
  try {
    final partes = dataHora.split(" • ");
    if (partes.length != 2) return null;
    final dataPartes = partes[0].split("/");
    final horaPartes = partes[1].split(":");
    final dia = int.parse(dataPartes[0]);
    final mes = int.parse(dataPartes[1]);
    final ano = int.parse(dataPartes[2]);
    final hora = int.parse(horaPartes[0]);
    final minuto = int.parse(horaPartes[1]);
    return DateTime(ano, mes, dia, hora, minuto);
  } catch (e) {
    return null;
  }
}