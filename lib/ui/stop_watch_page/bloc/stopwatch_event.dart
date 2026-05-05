import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:otp2/business/models/stopwatch_snapshot.dart';
import 'package:otp2/ui/stop_watch_page/bloc/state_enums/stop_watch_display_mode_enum.dart';

part 'stopwatch_event.freezed.dart';

@freezed
class StopwatchEvent with _$StopwatchEvent {
  const factory StopwatchEvent.start() = StartStopwatchEvent;
  const factory StopwatchEvent.pause() = PauseStopwatchEvent;
  const factory StopwatchEvent.reset() = ResetStopwatchEvent;
  const factory StopwatchEvent.recordLap() = RecordLapEvent;
  const factory StopwatchEvent.snapshotUpdated(StopwatchSnapshot snapshot) = SnapshotUpdatedEvent;
  const factory StopwatchEvent.displayModeChanged( StopwatchDisplayModeEnum displayMode) = DisplayModeChangedEvent;
}
