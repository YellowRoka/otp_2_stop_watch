import 'package:injectable/injectable.dart';
import 'package:otp2/business/repositories/stopwatch_repository.dart';

@injectable
class ResetStopwatchUseCase {
  final StopwatchRepository _repository;

  ResetStopwatchUseCase(this._repository);

  void call() => _repository.stopTimer();
}
