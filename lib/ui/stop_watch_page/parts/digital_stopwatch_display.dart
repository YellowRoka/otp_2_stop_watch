import 'package:flutter/material.dart';
import 'package:otp2/business/utils/duration_ext.dart';
import 'package:otp2/system/utils/app_constants.dart';
import 'package:otp2/ui/stop_watch_page/parts/time_display.dart';

class DigitalStopwatchDisplay extends StatelessWidget {
  final Duration elapsedTime;

  const DigitalStopwatchDisplay({super.key, required this.elapsedTime});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.displayCardPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.displayCardRadius),
          gradient: LinearGradient(
            colors: [
              colorScheme.primaryContainer,
              colorScheme.secondaryContainer,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
              AppConstants.digitalDisplayLabel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: colorScheme.onPrimaryContainer,fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: AppConstants.pagePadding),

            TimeDisplay(time: elapsedTime.toDurationDisplay()),

          ],
        ),
      ),
    );
  }
}
