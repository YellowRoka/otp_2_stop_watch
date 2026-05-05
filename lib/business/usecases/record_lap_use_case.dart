import 'package:injectable/injectable.dart';
import 'package:otp2/business/repositories/stopwatch_repository.dart';

@injectable
class RecordLapUseCase {
  final StopwatchRepository _repository;

  RecordLapUseCase(this._repository);

  void call() => _repository.recordLap();
}
