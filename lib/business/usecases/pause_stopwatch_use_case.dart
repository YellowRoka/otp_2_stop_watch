import 'package:injectable/injectable.dart';
import 'package:otp2/business/repositories/stopwatch_repository.dart';

@injectable
class PauseStopwatchUseCase {
  final StopwatchRepository _repository;

  PauseStopwatchUseCase(this._repository);

  void call() => _repository.pauseTimer();
}
