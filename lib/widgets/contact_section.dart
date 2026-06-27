import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text(
            "LET'S BUILD SOMETHING",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  letterSpacing: 3,
                  fontSize: 13,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            "Get in Touch",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 16),
          const Text(
            "Have a Flutter project in mind? Let's talk.",
            style: TextStyle(fontSize: 16, color: AppTheme.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _ContactButton(
                icon: Icons.email_outlined,
                label: PortfolioData.email,
                color: AppTheme.cyan,
                onTap: () {
                  Clipboard.setData(
                      const ClipboardData(text: PortfolioData.email));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email copied to clipboard!'),
                      backgroundColor: AppTheme.bgCard,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              _ContactButton(
                icon: Icons.code,
                label: 'GitHub',
                color: AppTheme.green,
                onTap: () {}, // url_launcher: launchUrl(Uri.parse(PortfolioData.github))
              ),
              _ContactButton(
                icon: Icons.work_outline,
                label: 'LinkedIn',
                color: AppTheme.purple,
                onTap: () {},
              ),
              _ContactButton(
                icon: Icons.chat_bubble_outline,
                label: 'Twitter / X',
                color: AppTheme.amber,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 64),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppTheme.borderColor,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} ${PortfolioData.name} · Built with Flutter 💙',
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
}

class _ContactButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withOpacity(0.12)
                : AppTheme.bgCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.color.withOpacity(_hovered ? 0.5 : 0.2),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.15),
                      blurRadius: 16,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: widget.color),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  color: _hovered ? widget.color : AppTheme.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
