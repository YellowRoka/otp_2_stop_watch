import 'package:otp2/business/models/stopwatch_snapshot.dart';

abstract class StopwatchRepository {
  void startTimer();
  void pauseTimer();
  void stopTimer();   // Stop and reset the timer
  void recordLap();
  void dispose();

  Stream<StopwatchSnapshot> get stopwatchSnapshotStream;
}
