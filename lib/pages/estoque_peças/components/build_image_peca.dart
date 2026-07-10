import 'dart:io';

import 'package:flutter/material.dart';

class BuildImagePeca extends StatelessWidget {
  final String? caminhoLocal;
  final String? url;
  final BoxFit fit = BoxFit.cover;
  const BuildImagePeca({
    super.key,
    this.caminhoLocal,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    /// 🔹 1️⃣ tenta imagem local (mais rápida e offline)
    if (caminhoLocal != null && caminhoLocal!.isNotEmpty) {
      print("Carregou imagem local: $caminhoLocal");
      final file = File(caminhoLocal!);

      if (file.existsSync()) {
        return Image.file(
          file,
          fit: fit,
          errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
        );
      }
    }

    /// 🔹 2️⃣ fallback para internet
    if (url != null && url!.isNotEmpty) {
      print("Carregou imagem da internet: $url");
      return Image.network(
        url!,
        fit: fit,
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (_, __, ___) => const Icon(Icons.cloud_off),
      );
    }

    /// 🔹 3️⃣ fallback final
    return const Center(
      child: Icon(Icons.image_not_supported),
    );
  }
}
