import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:otp2/business/models/stopwatch_snapshot.dart';
import 'package:otp2/ui/stop_watch_page/bloc/state_enums/stop_watch_display_mode_enum.dart';
import 'package:otp2/ui/stop_watch_page/bloc/state_enums/stop_watch_state_enum.dart';

part 'stopwatch_state.freezed.dart';

@freezed
abstract class StopwatchState with _$StopwatchState {
  const factory StopwatchState({
    @Default(StopwatchStatusEnum.initial) StopwatchStatusEnum status,
    @Default(StopwatchSnapshot.initial()) StopwatchSnapshot snapshot,
    @Default(StopwatchDisplayModeEnum.digital)StopwatchDisplayModeEnum displayMode,
  }) = _StopwatchState;
}
