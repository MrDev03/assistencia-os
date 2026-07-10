import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class AssinaturaBottomSheet extends StatefulWidget {
  /// Callback que retorna a assinatura salva (List<int>)
  final void Function(List<int>?) onSalvar;

  const AssinaturaBottomSheet({super.key, required this.onSalvar});

  /// 🌟 Método estático facilitador para chamar o BottomSheet de qualquer lugar
  static void mostrar(BuildContext context, {required void Function(List<int>?) onSalvar}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false, // Impede que o usuário feche clicando fora
      isScrollControlled: true, // Permite que o bottom sheet fique maior se necessário
      backgroundColor: Colors.transparent, // O fundo real fica no Container abaixo
      builder: (context) => AssinaturaBottomSheet(onSalvar: onSalvar),
    );
  }

  @override
  State<AssinaturaBottomSheet> createState() => _AssinaturaBottomSheetState();
}

class _AssinaturaBottomSheetState extends State<AssinaturaBottomSheet> {
  late final SignatureController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_controller.isNotEmpty) {
      final Uint8List? imagem = await _controller.toPngBytes();
      if (imagem != null) {
        widget.onSalvar(imagem.toList());
        if (mounted) Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Por favor, assine antes de salvar."),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      // Padding dinâmico que respeita a barra de navegação do Android/iOS
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 16,
        top: 12,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ocupa apenas o espaço necessário
        children: [
          // 1. Puxador (Drag Handle) moderno
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // 2. Cabeçalho com Título e Botão de Fechar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Assinatura",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 3. Área de Desenho (Canvas)
          Container(
            height: 220, // Altura um pouco maior para facilitar no celular
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.hardEdge, // Evita que a tinta vaze das bordas arredondadas
            child: Signature(
              controller: _controller,
              backgroundColor: Colors.white, // Mantém branco para simular papel
            ),
          ),
          const SizedBox(height: 24),

          // 4. Botões de Ação (Limpar e Salvar) expandidos
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _controller.clear(),
                  icon: const Icon(Icons.cleaning_services_rounded, size: 20),
                  label: const Text("Limpar"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _salvar,
                  icon: const Icon(Icons.check_rounded, size: 20),
                  label: const Text("Salvar"),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}