import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../custom_widgets/card.dart';
import '../../../models/empresa_model/empresa_model.dart';
import '../../empresa/empresa_info_page.dart';
import '../home.dart';

class UserCard extends StatelessWidget {

  final Empresa? empresa;
  final bool subscription;
  final ColorScheme theme;
  final String? cargoAtual;

  const UserCard({
    super.key,
    required this.empresa,
    required this.subscription,
    required this.theme,
    required this.cargoAtual,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomCard(
        padding: const EdgeInsets.all(16),
        child: !context.isTablet ? Row(
          children: [
            buildLogo(
              context: context,
              size: 42,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    empresa?.nome?.isEmpty ?? true ? "Bem-vindo!" : "Olá, ${empresa!.nome}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(FirebaseAuth.instance.currentUser?.email ?? "não logado. Faça login para salvar e sincronizar seus dados em nuvem",
                    style: TextStyle(color: theme.primary),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text("Cargo: ", style: TextStyle(fontWeight: FontWeight.bold, color: theme.onSurface)),
                      Text(cargoAtual ?? "-", style: TextStyle(color: theme.primary)),
                      const Spacer(),
                      if (subscription && context.isDesktop)...[
                        Text(subscription ? "Assistência OS Pro" : "Grátis", style: TextStyle(color: theme.primary)),
                        const SizedBox(width: 6),
                        const Icon(Icons.verified, color: Colors.blueAccent, size: 16),
                      ]
                    ],
                  ),
                ],
              ),
            )
          ],
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildLogo(
                context: context,
                size: 42,
            ),
            const SizedBox(height: 12),
            Text(
              empresa?.nome?.isEmpty ?? true ? "Bem-vindo!" : "Olá, ${empresa!.nome}",
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(FirebaseAuth.instance.currentUser?.email ?? "não logado. Faça login para salvar e sincronizar seus dados em nuvem",
              style: TextStyle(color: theme.primary),
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Cargo: ", style: TextStyle(fontWeight: FontWeight.bold, color: theme.onSurface)),
                Text(cargoAtual ?? "-", style: TextStyle(color: theme.primary)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Plano: ", style: TextStyle(fontWeight: FontWeight.bold, color: theme.onSurface)),
                Text(subscription ? "Assistência OS Pro" : "Grátis", style: TextStyle(color: theme.primary)),
                const SizedBox(width: 6),
                const Icon(Icons.verified, color: Colors.blueAccent, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogo ({
    required BuildContext context,
    double size = 50,
  }) {
    ImageProvider? image;

    // 1️⃣ Prioridade: imagem local (offline)
    if (empresa?.logoBytes != null && empresa?.logoBytes!.isNotEmpty == true) {
      image = MemoryImage(Uint8List.fromList(empresa!.logoBytes ?? []));
    }
    // 2️⃣ Fallback: imagem remota
    else if (empresa?.logoUrl != null && empresa?.logoUrl!.isNotEmpty == true) {
      image = NetworkImage(empresa?.logoUrl ?? '');
    }

    return Hero(
      tag: 'logoEmpresa',
      child: GestureDetector(
        onTap: () {
          if (!context.mounted) return;
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const DadosEmpresaPage()));
        },
        child: CircleAvatar(
          radius: size,
          backgroundColor: Colors.grey[200],
          backgroundImage: image,
          child: image == null
              ? const Icon(Icons.store,)
              : null,
        ),
      ),
    );
  }

}
