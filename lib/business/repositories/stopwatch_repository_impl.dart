import 'package:injectable/injectable.dart';
import 'package:otp2/business/models/stopwatch_snapshot.dart';
import 'package:otp2/business/repositories/stopwatch_repository.dart';
import 'package:otp2/business/services/stopwatch_engine.dart';

@LazySingleton(as: StopwatchRepository)
class StopwatchRepositoryImpl implements StopwatchRepository {
  final StopwatchEngine stopwatchEngine;

  StopwatchRepositoryImpl({required this.stopwatchEngine});

  @override
  void startTimer() => stopwatchEngine.start();

  @override
  void pauseTimer() => stopwatchEngine.pause();

  @override
  void stopTimer() => stopwatchEngine.stop();

  @override
  void recordLap() => stopwatchEngine.recordLap();

  @override
  Stream<StopwatchSnapshot> get stopwatchSnapshotStream => stopwatchEngine.snapshotStream;

  @override
  void dispose() => stopwatchEngine.dispose();
}
