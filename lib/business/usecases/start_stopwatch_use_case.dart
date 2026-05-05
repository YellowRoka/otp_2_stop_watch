import 'package:injectable/injectable.dart';
import 'package:otp2/business/repositories/stopwatch_repository.dart';

@injectable
class StartStopwatchUseCase {
  final StopwatchRepository _repository;

  StartStopwatchUseCase(this._repository);

  void call() => _repository.startTimer();
}
