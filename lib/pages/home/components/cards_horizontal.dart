import 'package:flutter/material.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import '../../../custom_widgets/card.dart';
import '../../../custom_widgets/led_pulsante.dart';
import '../../../models/cliente_model/cliente_model.dart';
import '../../../models/servico_model/servico_model.dart';
import '../../all_os/all_os.dart';
import '../../clientes/lista_clientes.dart';
import '../../premium_page.dart';

class CardsHorizontal extends StatelessWidget {
  final List<Cliente> clientes;
  final List<Servico> servicos;
  final List<Servico> servicosPendentes;
  final bool subscription;

  const CardsHorizontal({
    super.key,
    required this.clientes,
    required this.servicos,
    required this.servicosPendentes,
    required this.subscription
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildResumoBox(
              iconColor: Colors.pinkAccent,
              theme,
              icon: Icons.assignment,
              label: "Serviços",
              value: servicos.length.toString(), //total.toString(),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllOs()))
          ),
          _buildResumoBox(
            iconColor: Colors.blue,
            theme,
            icon: Icons.people,
            label: "Clientes",
            value: clientes.length.toString(),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ListaClientesPage())),
          ),

          _buildResumoBox(
            iconColor: Colors.deepPurple,
            theme,
            icon: Icons.access_time_outlined,
            label: "Andamentos",
            value: !subscription ? '-' : servicosPendentes.length.toString(),
            led: !subscription ? const Icon(RemixIcon.vipCrownLine, color: Colors.amber, size: 18) : servicosPendentes.isNotEmpty ?
            LedPulse(
              size: 10,
              color: servicosPendentes.where((s) => s.status?.toLowerCase() == "atrasado").isNotEmpty ? Colors.red : Colors.green,
            ) : null,
            onTap: () {
              if (subscription) {
                //Navigator.push(context, MaterialPageRoute(builder: (_) => const ServicosRecentesPage()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumPage()));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResumoBox(ColorScheme theme,
      {required IconData icon,
        required String label,
        required String value,
        VoidCallback? onTap,
        Widget? led,
        required Color iconColor,
      }) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          onTap?.call();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: CustomCard(
            padding: const EdgeInsets.all(12),
            borderRadius: 20,
            child: Stack(
              children: [
                Positioned(top: 0, right: 0, child: Container(child: led)),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          icon, size: 20,
                          color: iconColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(value,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.onSurface)),
                      Text(label,
                          style: TextStyle(fontSize: 13, color: theme.onSurface.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
