import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:otp2/business/data_sources/local/stop_watch_data_source.dart';
import 'package:otp2/business/models/stopwatch_snapshot.dart';
import 'package:otp2/system/utils/app_constants.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class StopwatchEngine {
  final StopWatchDataSource stopWatchDataSource;

  StopwatchEngine(this.stopWatchDataSource);

  StreamSubscription<Duration>? _timerSubscription;

  Stream<StopwatchSnapshot> get snapshotStream => Rx.combineLatest3(
        stopWatchDataSource.elapsedTime.stream,
        stopWatchDataSource.laps.stream,
        stopWatchDataSource.isRunning.stream,
        ( Duration elapsedTime, List<Duration> laps, bool isRunning,) =>
          StopwatchSnapshot(
            elapsedTime: elapsedTime,
            laps: laps,
            isRunning: isRunning,
          ),
      );

  void start() {
    if (stopWatchDataSource.isRunning.value) return;

    stopWatchDataSource.isRunning.add(true);

    _timerSubscription = Stream
      .periodic(
        AppConstants.stopwatchTickInterval,
        (_) => AppConstants.stopwatchTickInterval,
      )
      .scan<Duration>(
        (acc, curr, _) => acc + curr,
        stopWatchDataSource.elapsedTime.value,
      ) /* run from last paused value */
      .listen(stopWatchDataSource.elapsedTime.add);
  }

  void pause() {
    stopWatchDataSource.isRunning.add(false);
    _timerSubscription?.cancel();
    _timerSubscription = null;
  }

  void stop() {
    stopWatchDataSource.isRunning.add(false);
    _timerSubscription?.cancel();
    _timerSubscription = null;
    stopWatchDataSource.elapsedTime.add(Duration.zero);
    stopWatchDataSource.laps.add([]);
  }

  void recordLap() {
    stopWatchDataSource.laps.add([...stopWatchDataSource.laps.value, stopWatchDataSource.elapsedTime.value]);
  }

  void dispose() {
    _timerSubscription?.cancel();
    stopWatchDataSource.elapsedTime.close();
    stopWatchDataSource.isRunning.close();
    stopWatchDataSource.laps.close();
  }
}
