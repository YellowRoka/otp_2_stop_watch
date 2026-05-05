import 'package:flutter/material.dart';
import 'package:otp2/system/utils/app_constants.dart';

class TimeDisplay extends StatelessWidget {
  final String time;

  const TimeDisplay({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      time,
      style: TextStyle(
        fontSize: AppConstants.timeDisplayFontSize,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimaryContainer,
      ),
    );
  }
}
