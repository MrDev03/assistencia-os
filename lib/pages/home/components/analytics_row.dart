import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../all_os/all_os.dart';
import '../../premium_page.dart';
import '../services/dashboard_data.dart';

class AnalyticsRow extends StatefulWidget {
  final DashboardData data;
  final bool isPro;
  const AnalyticsRow({
    super.key,
    required this.data,
    this.isPro = false,
    //required this.servicos,
  });

  @override
  State<AnalyticsRow> createState() => _AnalyticsRowState();
}

class _AnalyticsRowState extends State<AnalyticsRow> {

  void _navegarPremium () {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumPage()));
  }

  @override
  Widget build(BuildContext context) {

    final isPro = widget.isPro;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(

        children: [
          _CardAnalytics(
            label: "Todos",
            value: widget.data.servicos.length,
            color: Colors.blueAccent.shade700,
            icon: Icons.all_inclusive_rounded, //FluentIcons.arrow_up_square_settings_24_regular,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllOs())),
          ),
          _CardAnalytics(
            label: "Em Andamento",
            value: widget.data.emAndamento,
            color: Colors.orange,
            icon: Icons.access_time_rounded,
            onTap: () => !isPro ? _navegarPremium() : Navigator.push(context, MaterialPageRoute(builder: (_) => const AllOs(callStatus: 'em andamento'))),
          ),
          Animate(
            onPlay: widget.data.atrasados == 0 ? null : (controller) => controller.repeat(),
            effects: widget.data.atrasados == 0 ? null : [
              //FadeEffect(duration: Duration(milliseconds: 500)),
              //const ShimmerEffect(duration: Duration(seconds: 1), curve: Curves.easeInOut,),
              const ShakeEffect(
                duration: Duration(milliseconds: 200),
                delay: Duration(milliseconds: 900),
              )
            ],
            child: _CardAnalytics(
              label: "Atrasados",
              value: widget.data.atrasados,
              color: Colors.pink,
              icon: Icons.warning_outlined,
              onTap: () => !isPro ? _navegarPremium() : Navigator.push(context, MaterialPageRoute(builder: (_) => const AllOs(callStatus: 'atrasado'))),
            ),
          ),
          _CardAnalytics(
            label: "Sem Solução",
            value: widget.data.semSolucao,
            color: Colors.red,
            icon: Icons.dangerous,
            onTap: () => !isPro ? _navegarPremium() : Navigator.push(context, MaterialPageRoute(builder: (_) => const AllOs(callStatus: 'sem solução'))),
          ),
          _CardAnalytics(
            label: "Aguardando Cliente",
            value: widget.data.aguardandoCliente,
            color: Colors.purple.shade700,
            icon: Icons.hourglass_top,
            onTap: () => !isPro ? _navegarPremium() : Navigator.push(context, MaterialPageRoute(builder: (_) => const AllOs(callStatus: 'aguardando cliente'))),
          ),
          // _CardAnalytics(
          //   label: "Entregues",
          //   value: data.entregue,
          //   color: Colors.greenAccent.shade700,
          //   icon: Icons.done_all,
          // ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _CardAnalytics extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final IconData icon;
  final bool active;
  final VoidCallback? onTap;

  const _CardAnalytics({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    this.onTap,
    this.active = false
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        height: 115,
        width: 95,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.1, 0.6, 1],
            colors: [
              color,
              color.withValues(alpha: 0.8),
              color
            ]
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  " ${value.toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Visibility(
                  visible: active,
                  child: const Icon(
                    Icons.chevron_right_outlined,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon,
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 30,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

