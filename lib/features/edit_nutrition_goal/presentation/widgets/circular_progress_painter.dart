import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Custom painter for drawing circular progress arc
class CircularProgressPainter extends CustomPainter {
  const CircularProgressPainter(this.color, this.percentage, this.strokeWidth);

  final Color color;
  final double percentage;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const startAngle = -90 * (math.pi / 180);
    final sweepAngle = (percentage.clamp(0, 100) / 100) * 2 * math.pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
