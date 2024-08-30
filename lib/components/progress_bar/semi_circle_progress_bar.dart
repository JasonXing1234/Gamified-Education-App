import 'package:flutter/material.dart';
import 'dart:math';

import 'package:quiz/styles/app_colors.dart';

class SemiCircleProgressBar extends StatelessWidget {
  final double progress;

  const SemiCircleProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 225, // Width of the widget
      height: 225, // Half of the width to make a semi-circle
      child: CustomPaint(
        painter: SemiCircleProgressPainter(progress: progress),
      ),
    );
  }
}


class SemiCircleProgressPainter extends CustomPainter {
  final double progress; // Value between 0.0 and 1.0

  SemiCircleProgressPainter({required this.progress});

  final AppColors appColors = const AppColors();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintBlue = Paint()
      ..color = appColors.royalBlue
      ..strokeWidth = 30.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final Paint paintGrey = Paint()
      ..color = appColors.grey
      ..strokeWidth = 30.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final double radius = size.width;

    const double startAngle = - 185 * pi / 180;
    final double sweepAngle = 190 * pi / 180 * progress; // Sweep for the progress value
    final Rect rect = Rect.fromLTRB(0, 0, radius, radius); // Shapes stays as a circle

    // Grey
    canvas.drawArc(rect, startAngle, 190 * pi / 180, false, paintGrey);

    // Progress
    canvas.drawArc(rect, startAngle, sweepAngle, false, paintBlue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
