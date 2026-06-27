import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';

class ExperienceTimeline extends StatelessWidget {
  final List<ExperienceModel> items;

  const ExperienceTimeline({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.asMap().entries.map((e) {
        final isLast = e.key == items.length - 1;
        return _TimelineItem(
          item: e.value,
          index: e.key,
          isLast: isLast,
        );
      }).toList(),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final ExperienceModel item;
  final int index;
  final bool isLast;

  const _TimelineItem({
    required this.item,
    required this.index,
    required this.isLast,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line + dot
        SizedBox(
          width: 32,
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (_, __) => Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: widget.item.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.item.color
                            .withOpacity(_pulseAnimation.value * 0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              if (!widget.isLast)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    width: 1.5,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.item.color.withOpacity(0.4),
                          widget.item.color.withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.role,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      widget.item.company,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.item.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.item.period,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.item.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textMuted,
                    height: 1.65,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: widget.index * 150),
          duration: 500.ms,
        )
        .slideX(
          begin: -0.1,
          end: 0,
          delay: Duration(milliseconds: widget.index * 150),
          duration: 500.ms,
        );
  }
}
