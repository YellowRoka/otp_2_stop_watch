import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp2/business/data_sources/local/stop_watch_data_source.dart';
import 'package:otp2/business/repositories/stopwatch_repository.dart';
import 'package:otp2/business/repositories/stopwatch_repository_impl.dart';
import 'package:otp2/business/services/stopwatch_engine.dart';
import 'package:otp2/business/usecases/pause_stopwatch_use_case.dart';
import 'package:otp2/business/usecases/record_lap_use_case.dart';
import 'package:otp2/business/usecases/reset_stopwatch_use_case.dart';
import 'package:otp2/business/usecases/start_stopwatch_use_case.dart';
import 'package:otp2/di/injection.dart';
import 'package:otp2/ui/stop_watch_page/bloc/stopwatch_bloc.dart';
import 'package:otp2/ui/stop_watch_page/stopwatch_view.dart';

void main() {
  late StopwatchEngine engine;
  late StopwatchBloc bloc;

  setUp(() async {
    await getIt.reset();

    final dataSource = StopWatchDataSource();
    engine = StopwatchEngine(dataSource);
    final repository = StopwatchRepositoryImpl(stopwatchEngine: engine);

    bloc = StopwatchBloc(
      stopwatchRepository: repository,
      startStopwatchUseCase: StartStopwatchUseCase(repository),
      pauseStopwatchUseCase: PauseStopwatchUseCase(repository),
      resetStopwatchUseCase: ResetStopwatchUseCase(repository),
      recordLapUseCase: RecordLapUseCase(repository),
    );

    getIt.registerSingleton<StopwatchRepository>(repository);
    getIt.registerSingleton<StopwatchBloc>(bloc);
  });

  tearDown(() async {
    await bloc.close();
    engine.dispose();
    await getIt.reset();
  });

  testWidgets(
    'buttons update the stopwatch UI',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StopwatchView(),
        ),
      );

    expect(find.text('00:00:00'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Pause'), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);
    expect(find.text('Lap'), findsOneWidget);

    await tester.tap(find.text('Start'));
    await tester.pump(const Duration(milliseconds: 60));
    await tester.pump();

    expect(find.text('00:00:00'), findsNothing);

    final runningTime = _visibleStopwatchTime(tester);

    await tester.tap(find.text('Pause'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));
    await tester.pump();

    expect(_visibleStopwatchTime(tester), runningTime);

    await tester.tap(find.text('Reset'));
    await tester.pump();
    await tester.pump();

    expect(find.text('00:00:00'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'lap button records and displays the current elapsed time',
    (tester) async { 
      await tester.pumpWidget(
      const MaterialApp(
        home: StopwatchView(),
      ),
    );

    await tester.tap(find.text('Start'));
    await tester.pump(const Duration(milliseconds: 60));
    await tester.pump();
    await tester.tap(find.text('Lap'));
    await tester.pump();
    await tester.pump();

    expect(find.textContaining('Lap 1:'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}

String _visibleStopwatchTime(WidgetTester tester) {
  final timePattern = RegExp(r'^\d{2}:\d{2}:\d{2}$');
  final textWidgets = tester.widgetList<Text>(find.byType(Text));

  return textWidgets
      .map((widget) => widget.data)
      .whereType<String>()
      .firstWhere(timePattern.hasMatch);
}
