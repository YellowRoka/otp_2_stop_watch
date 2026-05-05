import 'package:otp2/system/utils/app_constants.dart';

extension WatcherFormat on Duration {
  String toDurationDisplay() {

    final minutes = inMinutes
      .remainder(AppConstants.minutesPerHour)
      .toString()
      .padLeft(
        AppConstants.durationPadWidth,
        AppConstants.durationPadChar,
      );

    final seconds = inSeconds
      .remainder(Duration.secondsPerMinute)
      .toString()
      .padLeft(
        AppConstants.durationPadWidth,
        AppConstants.durationPadChar,
      );

    final milliseconds = (inMilliseconds.remainder(AppConstants.millisecondsPerSecond) ~/AppConstants.centisecondsDivisor)
      .toString()
      .padLeft(
        AppConstants.durationPadWidth,
        AppConstants.durationPadChar,
      );

    return '$minutes:$seconds:$milliseconds';
  }
}
