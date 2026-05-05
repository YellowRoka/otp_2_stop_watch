import 'dart:math';

import 'package:flutter/material.dart';
import 'package:otp2/system/utils/app_constants.dart';

class AnalogStopwatchDisplay extends StatelessWidget {
  final Duration elapsedTime;

  const AnalogStopwatchDisplay({
    required this.elapsedTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.displayCardPadding),
        child: SizedBox.square(
          dimension: AppConstants.analogDisplaySize,
          child: CustomPaint(
            painter: _AnalogStopwatchPainter(
              elapsedTime: elapsedTime,
              colorScheme: Theme.of(context).colorScheme,
            ),
          ),
        ),
      ),
    );
  }
}

class _AnalogStopwatchPainter extends CustomPainter {
  final Duration elapsedTime;
  final ColorScheme colorScheme;

  const _AnalogStopwatchPainter({
    required this.elapsedTime,
    required this.colorScheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final clockRadius = radius - AppConstants.analogOuterStrokeWidth;

    final facePaint = Paint()
      ..color = colorScheme.surface
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = colorScheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppConstants.analogOuterStrokeWidth;

    canvas.drawCircle(center, clockRadius, facePaint);
    canvas.drawCircle(center, clockRadius, borderPaint);

    _drawTicks(canvas, center, clockRadius);
    _drawHands(canvas, center, clockRadius);

    canvas.drawCircle(
      center,
      AppConstants.analogCenterDotRadius,
      Paint()..color = colorScheme.primary,
    );
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    for (var index = 0; index < AppConstants.analogTickCount; index++) {
      final isMajor = index % AppConstants.analogMajorTickInterval == 0;
      final angle = _angleForFraction(index / AppConstants.analogTickCount);
      final tickLength = isMajor ? AppConstants.analogMajorTickLength : AppConstants.analogMinorTickLength;
      final strokeWidth = isMajor ? AppConstants.analogMajorTickStrokeWidth : AppConstants.analogMinorTickStrokeWidth;
      final outer = _pointOnCircle(center, radius, angle);
      final inner = _pointOnCircle(center, radius - tickLength, angle);

      canvas.drawLine(
        outer,
        inner,
        Paint()
          ..color = colorScheme.outline
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  void _drawHands(Canvas canvas, Offset center, double radius) {
    final totalMilliseconds = elapsedTime.inMilliseconds;
    final totalSeconds = totalMilliseconds / AppConstants.millisecondsPerSecond;
    final minuteFraction = (totalSeconds / AppConstants.secondsPerMinute) % AppConstants.secondsPerMinute / AppConstants.secondsPerMinute;
    final secondFraction = (totalSeconds % AppConstants.secondsPerMinute) / AppConstants.secondsPerMinute;
    final centisecondFraction = (totalMilliseconds % AppConstants.millisecondsPerSecond) / AppConstants.millisecondsPerSecond;

    _drawHand(
      canvas,
      center,
      radius * 0.52,
      _angleForFraction(minuteFraction),
      colorScheme.primary,
      AppConstants.analogMinuteHandStrokeWidth,
    );
    _drawHand(
      canvas,
      center,
      radius * 0.72,
      _angleForFraction(secondFraction),
      colorScheme.secondary,
      AppConstants.analogSecondHandStrokeWidth,
    );
    _drawHand(
      canvas,
      center,
      radius * 0.82,
      _angleForFraction(centisecondFraction),
      colorScheme.tertiary,
      AppConstants.analogCentisecondHandStrokeWidth,
    );
  }

  void _drawHand(
    Canvas canvas,
    Offset center,
    double length,
    double angle,
    Color color,
    double strokeWidth,
  ) {
    canvas.drawLine(
      center,
      _pointOnCircle(center, length, angle),
      Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  double _angleForFraction(double fraction) => (fraction * 2 * pi) - (pi / 2);

  Offset _pointOnCircle(Offset center, double radius, double angle) {
    return Offset(
      center.dx + cos(angle) * radius,
      center.dy + sin(angle) * radius,
    );
  }

  @override
  bool shouldRepaint(covariant _AnalogStopwatchPainter oldDelegate) {
    return oldDelegate.elapsedTime != elapsedTime || oldDelegate.colorScheme != colorScheme;
  }
}
