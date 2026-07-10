import 'package:flutter/material.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class AcoesListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? badge;
  final bool hasIconPro;
  const AcoesListTile({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.badge,
    this.hasIconPro = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: theme.withValues(alpha: 0.15),
            child: Icon(icon, color: theme),
          ),
          title: Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(width: 5),
              badge ?? const SizedBox(),
            ],
          ),
          subtitle: Text(subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          trailing: hasIconPro ? const Icon(RemixIcon.vipCrownLine, color: Colors.amber, size: 20) : const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
