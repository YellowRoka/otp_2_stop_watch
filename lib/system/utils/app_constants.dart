final class AppConstants {
  static const String appTitle = 'OTP Stopwatch';
  static const String initialTimeDisplay = '00:00:00';

  static const String errorTitle = 'Error';
  static const String pageNotFoundPrefix = 'Page not found:';

  static const String startButtonLabel = 'Start';
  static const String pauseButtonLabel = 'Pause';
  static const String resetButtonLabel = 'Reset';
  static const String lapButtonLabel = 'Lap';
  static const String lapListPrefix = 'Lap';
  static const String durationPadChar = '0';
  static const String digitalDisplayLabel = 'Digital';
  static const String analogDisplayLabel = 'Analog';

  static const String splashPath = '/';
  static const String stopwatchPath = '/stopwatch';
  static const String splashRouteName = 'splash';
  static const String stopwatchRouteName = 'stopwatch';

  static const double pagePadding = 16;
  static const double sectionSpacing = 32;
  static const double splashIconSize = 72;
  static const double splashTitleFontSize = 28;
  static const double timeDisplayFontSize = 48;
  static const double buttonMinWidth = 84;
  static const double buttonMinHeight = 44;
  static const double displayCardRadius = 8;
  static const double displayCardPadding = 24;
  static const double analogDisplaySize = 240;
  static const double analogOuterStrokeWidth = 8;
  static const double analogMajorTickLength = 16;
  static const double analogMinorTickLength = 8;
  static const double analogMajorTickStrokeWidth = 3;
  static const double analogMinorTickStrokeWidth = 1.5;
  static const double analogMinuteHandStrokeWidth = 6;
  static const double analogSecondHandStrokeWidth = 3;
  static const double analogCentisecondHandStrokeWidth = 2;
  static const double analogCenterDotRadius = 7;

  static const Duration splashDelay = Duration(seconds: 2);
  static const Duration stopwatchTickInterval = Duration(milliseconds: 10);
  static const Duration displayModeSwitchDuration = Duration(milliseconds: 220);

  static const int durationPadWidth = 2;
  static const int listDisplayIndexOffset = 1;
  static const int minutesPerHour = 60;
  static const int secondsPerMinute = 60;
  static const int millisecondsPerSecond = 1000;
  static const int centisecondsDivisor = 10;
  static const int analogTickCount = 60;
  static const int analogMajorTickInterval = 5;
}
