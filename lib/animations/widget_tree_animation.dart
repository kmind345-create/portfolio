import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WidgetTreeNode {
  final String label;
  final Offset position;
  final Color color;
  final List<int> children;

  const WidgetTreeNode({
    required this.label,
    required this.position,
    required this.color,
    required this.children,
  });
}

class WidgetTreePainter extends CustomPainter {
  final double progress; // 0.0 to 1.0
  final List<WidgetTreeNode> nodes;
  final double pulseValue;

  WidgetTreePainter({
    required this.progress,
    required this.nodes,
    required this.pulseValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final totalNodes = nodes.length;
    final visibleCount = (progress * totalNodes).ceil();

    // Draw edges first
    final edgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < min(visibleCount, totalNodes); i++) {
      final node = nodes[i];
      for (final childIdx in node.children) {
        if (childIdx < visibleCount) {
          final child = nodes[childIdx];
          final edgeProgress = (progress * totalNodes - i).clamp(0.0, 1.0);
          final start = _scale(node.position, size);
          final end = _scale(child.position, size);
          final current = Offset.lerp(start, end, edgeProgress)!;

          edgePaint.color = node.color.withOpacity(0.3 * edgeProgress);
          canvas.drawLine(start, current, edgePaint);
        }
      }
    }

    // Draw nodes
    for (int i = 0; i < min(visibleCount, totalNodes); i++) {
      final node = nodes[i];
      final nodeProgress = ((progress * totalNodes) - i).clamp(0.0, 1.0);
      final pos = _scale(node.position, size);

      // Pulse ring on root
      if (i == 0 && nodeProgress >= 1.0) {
        final ringPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = node.color.withOpacity(0.3 * (1 - pulseValue));
        canvas.drawCircle(pos, 22 + pulseValue * 12, ringPaint);
      }

      // Node circle
      final bgPaint = Paint()
        ..color = node.color.withOpacity(0.15 * nodeProgress)
        ..style = PaintingStyle.fill;
      final borderPaint = Paint()
        ..color = node.color.withOpacity(0.7 * nodeProgress)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      final radius = 18.0 * nodeProgress;
      canvas.drawCircle(pos, radius, bgPaint);
      canvas.drawCircle(pos, radius, borderPaint);

      // Label
      if (nodeProgress > 0.7) {
        final textOpacity = ((nodeProgress - 0.7) / 0.3).clamp(0.0, 1.0);
        final textPainter = TextPainter(
          text: TextSpan(
            text: node.label,
            style: TextStyle(
              fontSize: 9,
              color: node.color.withOpacity(textOpacity),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          pos + Offset(-textPainter.width / 2, radius + 4),
        );
      }
    }
  }

  Offset _scale(Offset normalized, Size size) {
    return Offset(normalized.dx * size.width, normalized.dy * size.height);
  }

  @override
  bool shouldRepaint(WidgetTreePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.pulseValue != pulseValue;
}

class WidgetTreeAnimation extends StatefulWidget {
  const WidgetTreeAnimation({super.key});

  @override
  State<WidgetTreeAnimation> createState() => _WidgetTreeAnimationState();
}

class _WidgetTreeAnimationState extends State<WidgetTreeAnimation>
    with TickerProviderStateMixin {
  late AnimationController _buildController;
  late AnimationController _pulseController;
  late Animation<double> _buildAnimation;
  late Animation<double> _pulseAnimation;

  static const List<WidgetTreeNode> _nodes = [
    WidgetTreeNode(
      label: 'MaterialApp',
      position: Offset(0.5, 0.08),
      color: AppTheme.cyan,
      children: [1],
    ),
    WidgetTreeNode(
      label: 'Scaffold',
      position: Offset(0.5, 0.22),
      color: AppTheme.cyan,
      children: [2, 3],
    ),
    WidgetTreeNode(
      label: 'AppBar',
      position: Offset(0.25, 0.38),
      color: AppTheme.green,
      children: [4],
    ),
    WidgetTreeNode(
      label: 'Column',
      position: Offset(0.75, 0.38),
      color: AppTheme.green,
      children: [5, 6],
    ),
    WidgetTreeNode(
      label: 'Text',
      position: Offset(0.25, 0.55),
      color: AppTheme.purple,
      children: [],
    ),
    WidgetTreeNode(
      label: 'Container',
      position: Offset(0.6, 0.55),
      color: AppTheme.purple,
      children: [7],
    ),
    WidgetTreeNode(
      label: 'ListView',
      position: Offset(0.88, 0.55),
      color: AppTheme.amber,
      children: [8],
    ),
    WidgetTreeNode(
      label: 'Image',
      position: Offset(0.6, 0.72),
      color: AppTheme.amber,
      children: [],
    ),
    WidgetTreeNode(
      label: 'Card',
      position: Offset(0.88, 0.72),
      color: AppTheme.cyan,
      children: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _buildController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _buildAnimation = CurvedAnimation(
      parent: _buildController,
      curve: Curves.easeInOut,
    );
    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _buildController.forward();
    });
  }

  @override
  void dispose() {
    _buildController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_buildAnimation, _pulseAnimation]),
      builder: (context, _) {
        return CustomPaint(
          painter: WidgetTreePainter(
            progress: _buildAnimation.value,
            nodes: _nodes,
            pulseValue: _pulseAnimation.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}
