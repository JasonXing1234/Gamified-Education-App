import 'package:flutter/material.dart';

class HalfCircleBarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50.0;

    final angle = 3.14159 / 3; // 60 degrees for each segment
    final radius = size.width / 2;
    final center = Offset(size.width / 2, 0); // Shift the center to the top

    for (int i = 0; i < 3; i++) {
      final startAngle = i * angle + 3.14159; // Start from the top and move downward
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        angle - 0.05, // Slight gap between bars
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

