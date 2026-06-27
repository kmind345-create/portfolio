import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';

class AnimatedSkillBar extends StatefulWidget {
  final SkillModel skill;
  final int index;
  final bool animate;

  const AnimatedSkillBar({
    super.key,
    required this.skill,
    required this.index,
    required this.animate,
  });

  @override
  State<AnimatedSkillBar> createState() => _AnimatedSkillBarState();
}

class _AnimatedSkillBarState extends State<AnimatedSkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fillAnimation = Tween<double>(begin: 0, end: widget.skill.level).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(AnimatedSkillBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      Future.delayed(Duration(milliseconds: widget.index * 80), () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(widget.skill.icon, size: 16, color: widget.skill.color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.skill.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _fillAnimation,
                builder: (_, __) => Text(
                  '${(_fillAnimation.value * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 13,
                    color: widget.skill.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.bgCard,
              borderRadius: BorderRadius.circular(3),
            ),
            child: AnimatedBuilder(
              animation: _fillAnimation,
              builder: (_, __) => FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _fillAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: LinearGradient(
                      colors: [
                        widget.skill.color.withOpacity(0.7),
                        widget.skill.color,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.skill.color.withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
          delay: Duration(milliseconds: widget.index * 60),
          duration: 400.ms,
        );
  }
}
