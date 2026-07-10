import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:isar_community/isar.dart';

import '../../models/estoque_pecas_model/estoque_pecas_model.dart';
import '../../sync/modules/estoque_pecas_sync.dart';
import 'components/btn_blur.dart';
import 'components/build_image_peca.dart';
import 'nova_peca.dart';

class PecaDetalhesScreen extends StatefulWidget {
  final Isar isar;
  final int pecaId;
  final String cargoAtual;

  const PecaDetalhesScreen({
    super.key,
    required this.isar,
    required this.pecaId,
    required this.cargoAtual,
  });

  @override
  State<PecaDetalhesScreen> createState() => _PecaDetalhesScreenState();
}

class _PecaDetalhesScreenState extends State<PecaDetalhesScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? get user => FirebaseAuth.instance.currentUser;
  String? get uid => user?.uid;

  int _fotoAtual = 0;
  final PageController _pageController = PageController();
  final dateFormat = DateFormat('dd/MM/yyyy - HH:mm');

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _deletarPeca(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Confirmar Exclusão', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Tem certeza que deseja apagar esta peça do estoque? Essa ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      EstoquePecasSync().deletePeca(widget.pecaId);
      if (context.mounted) Navigator.pop(context);
    }
  }

  String formatCurrency(double value) {
    return value
        .toStringAsFixed(2)
        .replaceAll('.', ',')
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<EstoquePecas?>(
      stream: widget.isar.estoquePecas.watchObject(widget.pecaId, fireImmediately: true),
      builder: (context, snapshot) {
        final peca = snapshot.data;

        if (peca == null) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            // Define o ponto de quebra (breakpoint) para Desktop/Tablet
            final isDesktop = constraints.maxWidth > 850;

            if (isDesktop) {
              return _buildDesktopLayout(context, peca, theme);
            } else {
              return _buildMobileLayout(context, peca, theme);
            }
          },
        );
      },
    );
  }

  // ==========================================
  // LAYOUT DESKTOP / TABLET (Lado a Lado)
  // ==========================================
  Widget _buildDesktopLayout(BuildContext context, EstoquePecas peca, ThemeData theme) {
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AppbarBtnDesktop(onPressed: () => Navigator.pop(context)),
        actions: _buildAcoes(peca),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Esquerda: Galeria de Imagens Fixa
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                clipBehavior: Clip.antiAlias,
                child: _buildImageGallery(peca, theme),
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.05),
            ),
            const SizedBox(width: 40),

            // Direita: Detalhes Roláveis
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 40),
                  child: _buildDetalhesConteudo(peca, theme, isDesktop: true),
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // LAYOUT MOBILE (CustomScrollView com Overlap)
  // ==========================================
  Widget _buildMobileLayout(BuildContext context, EstoquePecas peca, ThemeData theme) {
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 380.0,
            floating: false,
            pinned: true,
            backgroundColor: theme.colorScheme.surface,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(
                child: BtnBlur(
                  tooltip: 'Voltar',
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: _buildAcoes(peca),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageGallery(peca, theme),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              // Efeito de sobreposição (overlap) correto que não quebra a árvore
              transform: Matrix4.translationValues(0, -32, 0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 100),
                child: _buildDetalhesConteudo(peca, theme, isDesktop: false),
              ),
            ).animate().slideY(begin: 0.1, duration: 400.ms, curve: Curves.easeOutCubic).fadeIn(),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // COMPONENTES REUTILIZÁVEIS
  // ==========================================

  // Botões de Ação (Editar e Deletar)
  List<Widget> _buildAcoes(EstoquePecas peca) {
    if (widget.cargoAtual != 'admin') return [];
    return [
      Center(
        child: BtnBlur(
          icon: const Icon(Icons.edit_rounded, size: 20),
          tooltip: 'Editar',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PecaFormScreen(isar: widget.isar, isEdit: true, peca: peca),
              ),
            );
          },
        ),
      ),
      const SizedBox(width: 8),
      Center(
        child: BtnBlur(
          icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 22),
          tooltip: 'Deletar',
          onPressed: () => _deletarPeca(context),
        ),
      ),
      const SizedBox(width: 16),
    ];
  }

  // Galeria de Imagens Unificada
  Widget _buildImageGallery(EstoquePecas peca, ThemeData theme) {
    if (peca.fotosUrl.isEmpty) {
      return Container(
        color: theme.colorScheme.surfaceVariant.withValues(alpha: 0.5),
        child: Icon(Icons.inventory_2_rounded, size: 80, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3)),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          itemCount: peca.fotosUrl.length,
          controller: _pageController,
          onPageChanged: (index) => setState(() => _fotoAtual = index),
          itemBuilder: (context, index) {
            return Hero(
              tag: peca.id,
              child: BuildImagePeca(
                caminhoLocal: index < peca.fotosLocal.length ? peca.fotosLocal[index] : null,
                url: index < peca.fotosUrl.length ? peca.fotosUrl[index] : null,
              ),
            );
          },
        ),

        // Gradiente Inferior
        Positioned(
          bottom: 0, left: 0, right: 0, height: 140,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter, end: Alignment.topCenter,
                colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
              ),
            ),
          ),
        ),

        // Dots (Bolinhas)
        if (peca.fotosUrl.length > 1)
          Positioned(
            bottom: 40, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(peca.fotosUrl.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _fotoAtual == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _fotoAtual == index ? Colors.white : Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),

        // Setas (Navegação Desktop)
        if (_fotoAtual > 0 && (Platform.isWindows || Platform.isMacOS))
          Positioned(
            left: 16, top: 0, bottom: 0,
            child: Center(
              child: BtnBlur(
                tooltip: 'Anterior',
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                onPressed: () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
              ),
            ),
          ),

        if (_fotoAtual < peca.fotosUrl.length - 1 && (Platform.isWindows || Platform.isMacOS))
          Positioned(
            right: 16, top: 0, bottom: 0,
            child: Center(
              child: BtnBlur(
                tooltip: 'Próximo',
                icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
                onPressed: () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
              ),
            ),
          ),
      ],
    );
  }

  // Conteúdo de Detalhes Unificado
  Widget _buildDetalhesConteudo(EstoquePecas peca, ThemeData theme, {required bool isDesktop}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título Principal e Qtd
        Visibility(
          visible: !isDesktop,
          child: const SizedBox(
            height: 15,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                peca.tipo ?? 'Peça sem título',
                style: TextStyle(fontSize: isDesktop ? 32 : 26, fontWeight: FontWeight.w800, height: 1.1),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                '${peca.quantidade} unid.',
                style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Badges
        Wrap(
          spacing: 8, runSpacing: 8,
          children: [
            _buildBadge(label: peca.usada ? 'Usada' : 'Nova', color: peca.usada ? Colors.orange : Colors.green),
            if (peca.aro) _buildBadge(label: 'Com Aro', color: Colors.blue),
            if (peca.qualidadeTela != null && peca.qualidadeTela!.isNotEmpty)
              _buildBadge(label: peca.qualidadeTela!, color: Colors.purple),
          ],
        ),
        const SizedBox(height: 24),

        // Modelos Compatíveis
        if (peca.modelosCompativeis.isNotEmpty) ...[
          _buildSectionTitle('Compatibilidade', theme),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: peca.modelosCompativeis.map((modelo) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
                ),
                child: Text(modelo, style: TextStyle(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
        ],

        // BLOCO 1: Visão Geral
        _buildSectionTitle('Visão Geral', theme),
        _buildGroupContainer(theme, children: [
          _buildInfoTile(theme, icon: Icons.devices_other_rounded, iconColor: Colors.blue, title: 'Modelo da Peça', value: peca.modelo ?? '-'),
          if (peca.descricao != null && peca.descricao!.isNotEmpty) ...[
            _buildDivider(theme),
            _buildInfoTile(theme, icon: Icons.description_rounded, iconColor: Colors.orange, title: 'Descrição', value: peca.descricao!),
          ],
          if (peca.barCode != null && peca.barCode!.isNotEmpty) ...[
            _buildDivider(theme),
            _buildInfoTile(theme, icon: CupertinoIcons.barcode, iconColor: Colors.indigo, title: 'Código de Barras / SKU', value: peca.barCode!),
          ],
        ]),
        const SizedBox(height: 24),

        // BLOCO 2: Financeiro
        _buildSectionTitle('Valores', theme),
        _buildGroupContainer(theme, children: [
          _buildInfoTile(
            theme,
            icon: Icons.attach_money_rounded, iconColor: Colors.redAccent,
            title: 'Valor de Custo',
            value: 'R\$ ${widget.cargoAtual != 'admin' ? '****' : formatCurrency(peca.valorCusto ?? 0.0)}',
            valueColor: widget.cargoAtual == 'admin' ? Colors.redAccent : null,
          ),
          _buildDivider(theme),
          _buildInfoTile(
            theme,
            icon: Icons.point_of_sale_rounded, iconColor: Colors.green,
            title: 'Valor de Venda (Colocada)',
            value: 'R\$ ${formatCurrency(peca.valorVenda ?? 0.0)}',
            valueColor: Colors.green, isBold: true,
          ),
        ]),
        const SizedBox(height: 24),

        // BLOCO 3: Sistema
        _buildSectionTitle('Registro no Sistema', theme),
        _buildGroupContainer(theme, children: [
          _buildInfoTile(theme, icon: Icons.calendar_today_rounded, iconColor: Colors.grey, title: 'Data de Cadastro', value: dateFormat.format(peca.dataCadastro)),
          _buildDivider(theme),
          _buildInfoTile(theme, icon: Icons.update_rounded, iconColor: Colors.grey, title: 'Última Atualização', value: dateFormat.format(peca.dataUltimaAtualizacao)),
        ]),
      ],
    );
  }

  // --- WIDGETS AUXILIARES ---
  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 10),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: theme.colorScheme.onSurfaceVariant),
      ),
    );
  }

  Widget _buildGroupContainer(ThemeData theme, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoTile(ThemeData theme, {required IconData icon, required Color iconColor, required String title, required String value, Color? valueColor, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(value, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.w600, color: valueColor ?? theme.colorScheme.onSurface)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Divider(height: 1, thickness: 1, indent: 58, color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4));
  }

  Widget _buildBadge({required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(backgroundColor: color, radius: 4),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}

// Widget auxiliar para AppBar de Desktop (caso queira usar um botão mais simples lá)
class AppbarBtnDesktop extends StatelessWidget {
  final VoidCallback onPressed;
  const AppbarBtnDesktop({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: onPressed,
    );
  }
}