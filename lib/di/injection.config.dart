// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:otp2/business/data_sources/local/stop_watch_data_source.dart'
    as _i495;
import 'package:otp2/business/repositories/stopwatch_repository.dart' as _i534;
import 'package:otp2/business/repositories/stopwatch_repository_impl.dart'
    as _i944;
import 'package:otp2/business/services/stopwatch_engine.dart' as _i633;
import 'package:otp2/business/usecases/pause_stopwatch_use_case.dart' as _i217;
import 'package:otp2/business/usecases/record_lap_use_case.dart' as _i499;
import 'package:otp2/business/usecases/reset_stopwatch_use_case.dart' as _i1066;
import 'package:otp2/business/usecases/start_stopwatch_use_case.dart' as _i501;
import 'package:otp2/ui/stop_watch_page/bloc/stopwatch_bloc.dart' as _i430;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i495.StopWatchDataSource>(
      () => _i495.StopWatchDataSource(),
    );
    gh.lazySingleton<_i633.StopwatchEngine>(
      () => _i633.StopwatchEngine(gh<_i495.StopWatchDataSource>()),
    );
    gh.lazySingleton<_i534.StopwatchRepository>(
      () => _i944.StopwatchRepositoryImpl(
        stopwatchEngine: gh<_i633.StopwatchEngine>(),
      ),
    );
    gh.factory<_i217.PauseStopwatchUseCase>(
      () => _i217.PauseStopwatchUseCase(gh<_i534.StopwatchRepository>()),
    );
    gh.factory<_i499.RecordLapUseCase>(
      () => _i499.RecordLapUseCase(gh<_i534.StopwatchRepository>()),
    );
    gh.factory<_i1066.ResetStopwatchUseCase>(
      () => _i1066.ResetStopwatchUseCase(gh<_i534.StopwatchRepository>()),
    );
    gh.factory<_i501.StartStopwatchUseCase>(
      () => _i501.StartStopwatchUseCase(gh<_i534.StopwatchRepository>()),
    );
    gh.factory<_i430.StopwatchBloc>(
      () => _i430.StopwatchBloc(
        stopwatchRepository: gh<_i534.StopwatchRepository>(),
        startStopwatchUseCase: gh<_i501.StartStopwatchUseCase>(),
        pauseStopwatchUseCase: gh<_i217.PauseStopwatchUseCase>(),
        resetStopwatchUseCase: gh<_i1066.ResetStopwatchUseCase>(),
        recordLapUseCase: gh<_i499.RecordLapUseCase>(),
      ),
    );
    return this;
  }
}
