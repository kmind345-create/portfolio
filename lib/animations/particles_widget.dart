import 'dart:math';
import 'package:flutter/material.dart';

class Particle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double opacity;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
    required this.color,
  });
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlesPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()
        ..color = p.color.withOpacity(p.opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(p.x, p.y), p.radius, paint);
    }

    // Draw subtle connecting lines between close particles
    final linePaint = Paint()
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = particles[i].x - particles[j].x;
        final dy = particles[i].y - particles[j].y;
        final dist = sqrt(dx * dx + dy * dy);
        if (dist < 120) {
          final alpha = (1 - dist / 120) * 0.15;
          linePaint.color = const Color(0xFF00D4FF).withOpacity(alpha);
          canvas.drawLine(
            Offset(particles[i].x, particles[i].y),
            Offset(particles[j].x, particles[j].y),
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}

class ParticlesWidget extends StatefulWidget {
  const ParticlesWidget({super.key});

  @override
  State<ParticlesWidget> createState() => _ParticlesWidgetState();
}

class _ParticlesWidgetState extends State<ParticlesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final _random = Random();
  Size _size = Size.zero;

  final List<Color> _colors = const [
    Color(0xFF00D4FF),
    Color(0xFF00FF88),
    Color(0xFF7C3AED),
    Color(0xFFFFB800),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _controller.addListener(_update);
  }

  void _initParticles(Size size) {
    if (_particles.isNotEmpty) return;
    _size = size;
    for (int i = 0; i < 60; i++) {
      _particles.add(Particle(
        x: _random.nextDouble() * size.width,
        y: _random.nextDouble() * size.height,
        vx: (_random.nextDouble() - 0.5) * 0.4,
        vy: (_random.nextDouble() - 0.5) * 0.4,
        radius: _random.nextDouble() * 2 + 1,
        opacity: _random.nextDouble() * 0.4 + 0.1,
        color: _colors[_random.nextInt(_colors.length)],
      ));
    }
  }

  void _update() {
    if (_size == Size.zero) return;
    setState(() {
      for (final p in _particles) {
        p.x += p.vx;
        p.y += p.vy;
        if (p.x < 0 || p.x > _size.width) p.vx *= -1;
        if (p.y < 0 || p.y > _size.height) p.vy *= -1;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      _initParticles(Size(constraints.maxWidth, constraints.maxHeight));
      return CustomPaint(
        painter: ParticlesPainter(
          particles: _particles,
          progress: _controller.value,
        ),
        size: Size(constraints.maxWidth, constraints.maxHeight),
      );
    });
  }
}
