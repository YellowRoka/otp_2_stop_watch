import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:otp2/business/models/stopwatch_snapshot.dart';
import 'package:otp2/business/repositories/stopwatch_repository.dart';
import 'package:otp2/business/usecases/pause_stopwatch_use_case.dart';
import 'package:otp2/business/usecases/record_lap_use_case.dart';
import 'package:otp2/business/usecases/reset_stopwatch_use_case.dart';
import 'package:otp2/business/usecases/start_stopwatch_use_case.dart';
import 'package:otp2/ui/stop_watch_page/bloc/stopwatch_event.dart';
import 'package:otp2/ui/stop_watch_page/bloc/stopwatch_state.dart';

@injectable
class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final StopwatchRepository stopwatchRepository;
  final StartStopwatchUseCase startStopwatchUseCase;
  final PauseStopwatchUseCase pauseStopwatchUseCase;
  final ResetStopwatchUseCase resetStopwatchUseCase;
  final RecordLapUseCase recordLapUseCase;

  StreamSubscription<StopwatchSnapshot>? _stopwatchSubscription;

  @override
  Future<void> close() async {
    _stopwatchSubscription?.cancel();
    return super.close();
  }

  StopwatchBloc({
    required this.stopwatchRepository,
    required this.startStopwatchUseCase,
    required this.pauseStopwatchUseCase,
    required this.resetStopwatchUseCase,
    required this.recordLapUseCase,
  }) : super(const StopwatchState()) {
    on<StartStopwatchEvent>(_onStart);
    on<PauseStopwatchEvent>(_onPause);
    on<ResetStopwatchEvent>(_onReset);
    on<RecordLapEvent>(_onRecordLap);
    on<SnapshotUpdatedEvent>(_onSnapshotUpdated);
    on<DisplayModeChangedEvent>(_onDisplayModeChanged);

    _stopwatchSubscription = stopwatchRepository.stopwatchSnapshotStream.listen(
      (snapshot) => add(StopwatchEvent.snapshotUpdated(snapshot)),
    );
  }
  

  void _onSnapshotUpdated(SnapshotUpdatedEvent event, Emitter<StopwatchState> emit) => emit(
    state.copyWith( snapshot: event.snapshot),
  );

  void _onDisplayModeChanged(DisplayModeChangedEvent event, Emitter<StopwatchState> emit) => emit(
    state.copyWith(displayMode: event.displayMode)
  );

  void _onStart(StartStopwatchEvent event, Emitter<StopwatchState> emit) => startStopwatchUseCase();
  void _onPause(PauseStopwatchEvent event, Emitter<StopwatchState> emit) => pauseStopwatchUseCase();
  void _onReset(ResetStopwatchEvent event, Emitter<StopwatchState> emit) => resetStopwatchUseCase();
  void _onRecordLap(RecordLapEvent event, Emitter<StopwatchState> emit) => recordLapUseCase();
}
