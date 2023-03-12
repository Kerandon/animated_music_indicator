import 'dart:ui' as ui;
import 'package:animated_music_indicator/animated_music_indicator.dart';
import 'package:flutter/material.dart';

/// Paints the three different bar styles

class BarPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double width;
  final bool roundBars;
  final BarStyle barStyle;

  BarPainter({
    required this.progress,
    required this.width,
    required this.color,
    required this.roundBars,
    required this.barStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final paint = Paint()
      ..color = color
      ..strokeWidth = width * 0.70
      ..style = barStyle == BarStyle.circle
          ? PaintingStyle.fill
          : PaintingStyle.stroke
      ..strokeCap = roundBars ? StrokeCap.round : StrokeCap.square;

    final path = Path();

    if (barStyle == BarStyle.solid) {
      path
        ..moveTo(width / 2, height)
        ..lineTo(width / 2, 0);

      ui.PathMetrics pathMetrics = path.computeMetrics();

      ui.PathMetric pathMetric = pathMetrics.elementAt(0);
      Path extracted =
          pathMetric.extractPath(0.0, pathMetric.length * progress);

      canvas.drawPath(extracted, paint);
    } else if (barStyle == BarStyle.dash) {
      const maxNumberOfSegments = 8;
      final currentNumberOfSegments = maxNumberOfSegments * progress;
      paint.strokeWidth = height / (maxNumberOfSegments * 2);
      for (int i = 0; i < currentNumberOfSegments; i++) {
        const dashHeight = 1 / maxNumberOfSegments;
        path
          ..moveTo(width * 0.25,
              height - (height * dashHeight * i) - (height * (dashHeight / 2)))
          ..lineTo(
              width * 0.75,
              (height -
                  (height * dashHeight * i) -
                  (height * (dashHeight / 2))));
      }

      canvas.drawPath(path, paint);
    } else if (barStyle == BarStyle.circle) {
      const maxNumberOfSegments = 6;
      final currentNumberOfSegments = maxNumberOfSegments * progress;
      paint.strokeWidth = height / (maxNumberOfSegments + 5);
      for (int i = 0; i < currentNumberOfSegments; i++) {
        const dashHeight = 1 / maxNumberOfSegments;
        path.moveTo(width * 0.30,
            height - (height * dashHeight * i) - (height * (dashHeight / 2)));
        canvas.drawCircle(
            Offset(
                width / 2,
                height -
                    (height * dashHeight * i) -
                    (height * (dashHeight / 2))),
            height * 0.06,
            paint);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
