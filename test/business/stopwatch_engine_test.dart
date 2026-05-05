import 'package:flutter_test/flutter_test.dart';
import 'package:otp2/business/data_sources/local/stop_watch_data_source.dart';
import 'package:otp2/business/services/stopwatch_engine.dart';

void main() {
  late StopWatchDataSource dataSource;
  late StopwatchEngine engine;

  setUp(() {
    dataSource = StopWatchDataSource();
    engine = StopwatchEngine(dataSource);
  });

  tearDown(() {
    engine.dispose();
  });

  test('start starts the stopwatch and elapsed time increases', () async {
    engine.start();

    await Future<void>.delayed(const Duration(milliseconds: 35));

    expect(dataSource.isRunning.value, isTrue);
    expect(dataSource.elapsedTime.value, greaterThan(Duration.zero));
  });

  test('pause pauses the stopwatch and elapsed time stops increasing', () async {
    engine.start();
    await Future<void>.delayed(const Duration(milliseconds: 35));

    engine.pause();
    final pausedTime = dataSource.elapsedTime.value;

    await Future<void>.delayed(const Duration(milliseconds: 35));

    expect(dataSource.isRunning.value, isFalse);
    expect(dataSource.elapsedTime.value, pausedTime);
  });

  test('stop resets elapsed time to zero and stops the stopwatch', () async {
    engine.start();
    await Future<void>.delayed(const Duration(milliseconds: 35));

    engine.stop();

    expect(dataSource.isRunning.value, isFalse);
    expect(dataSource.elapsedTime.value, Duration.zero);
    expect(dataSource.laps.value, isEmpty);
  });

  test('multiple start calls while running do not speed up the stopwatch',
      () async {
    engine.start();
    engine.start();
    engine.start();

    await Future<void>.delayed(const Duration(milliseconds: 55));

    expect(dataSource.isRunning.value, isTrue);
    expect(dataSource.elapsedTime.value, greaterThan(Duration.zero));
    expect(
      dataSource.elapsedTime.value,
      lessThan(const Duration(milliseconds: 120)),
    );
  });

  test('recordLap stores the current elapsed time', () async {
    engine.start();
    await Future<void>.delayed(const Duration(milliseconds: 35));

    engine.recordLap();

    expect(dataSource.laps.value, hasLength(1));
    expect(dataSource.laps.value.single, greaterThan(Duration.zero));
  });
}
