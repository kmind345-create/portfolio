import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 3,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.textMuted,
              height: 1.6,
            ),
          ),
        ],
        const SizedBox(height: 8),
        Container(
          width: 48,
          height: 3,
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.cyan, AppTheme.green],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
