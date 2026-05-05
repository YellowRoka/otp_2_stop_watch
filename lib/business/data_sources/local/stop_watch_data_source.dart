import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class StopWatchDataSource {
  final BehaviorSubject<Duration> elapsedTime = BehaviorSubject<Duration>.seeded(Duration.zero);
  final BehaviorSubject<bool> isRunning = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<List<Duration>> laps = BehaviorSubject<List<Duration>>.seeded([]);
}
