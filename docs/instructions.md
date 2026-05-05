# OTP Stopwatch reprodukciós instrukciók

Az alábbi magyar nyelvű prompt/instrukció egy Flutter kódbázis pontos újraépítéséhez készült. A cél egy egyszerű, de rétegezett stopper alkalmazás, amely pragmatikus feature/module alapú struktúrát használ: a feature UI része a `ui` alatt van, a stopwatch üzleti logikája a `business` alatt, a rendszer szintű elemek pedig a `system` alatt.

## Alap cél

Hozz létre egy Flutter alkalmazást `otp2` néven, amely:

- Material 3 témát használ.
- `go_router` alapú navigációt használ.
- `get_it` + `injectable` alapú dependency injectiont használ.
- `flutter_bloc` + `freezed` alapú stopwatch state managementet használ.
- Tartalmaz splash oldalt, error oldalt és stopwatch oldalt.
- A stopwatch képes indulni, szünetelni, nullázódni és lap időket rögzíteni.
- A stopwatch kijelző digitális és analóg mód között válthat egy switch-csel.
- A display mode csak a Bloc state-ben tárolódik.
- A stopwatch idő, lap lista és running állapot a business rétegbeli engine/data source kombinációból jön streamként.

## Függőségek

A `pubspec.yaml` lényegi függőségei:

```yaml
environment:
  sdk: ^3.9.2

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_bloc: ^9.1.1
  equatable: ^2.0.5
  get_it: ^9.2.1
  injectable: ^3.0.0
  freezed_annotation: ^3.1.0
  go_router: ^17.2.3
  async: ^2.13.1
  rxdart: ^0.28.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  freezed: ^3.2.5
  build_runner: ^2.15.0
  injectable_generator: ^3.0.2
```

Generált fájlokhoz futtasd:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Mappastruktúra

Az alkalmazás lényegi struktúrája:

```text
lib/
  main.dart
  di/
    injection.dart
    injection.config.dart
  business/
    data_sources/local/stop_watch_data_source.dart
    models/stopwatch_snapshot.dart
    repositories/stopwatch_repository.dart
    repositories/stopwatch_repository_impl.dart
    services/stopwatch_engine.dart
    usecases/start_stopwatch_use_case.dart
    usecases/pause_stopwatch_use_case.dart
    usecases/reset_stopwatch_use_case.dart
    usecases/record_lap_use_case.dart
    utils/duration_ext.dart
  system/
    navigation/routes.dart
    theme/app_theme.dart
    utils/app_constants.dart
  ui/
    splash_page/splash_view.dart
    error_page/error_view.dart
    stop_watch_page/
      stopwatch_view.dart
      bloc/
        stopwatch_bloc.dart
        stopwatch_event.dart
        stopwatch_event.freezed.dart
        stopwatch_state.dart
        stopwatch_state.freezed.dart
        state_enums/
          stop_watch_display_mode_enum.dart
          stop_watch_state_enum.dart
      parts/
        analog_stopwatch_display.dart
        digital_stopwatch_display.dart
        display_mode_switch.dart
        laps_list.dart
        stopper_button.dart
        time_display.dart
        watch_control_buttons.dart
test/
  business/stopwatch_engine_test.dart
  ui/stopwatch_view_test.dart
docs/
  RQs.md
  instructions.md
```

Minden saját projekten belüli import `package:otp2/...` formájú abszolút import legyen. Relative importot ne használj.

## Main és DI

A `main.dart`:

- Hívja meg a `setupDependencies()` függvényt.
- Ezután indítsa a `MyApp` widgetet.
- A `MyApp` `MaterialApp.router` legyen.
- A title `AppConstants.appTitle`.
- A theme `AppTheme.light`.
- A router config `AppRouter.router`.

A `lib/di/injection.dart`:

- Hozzon létre globális `getIt = GetIt.instance` változót.
- Legyen rajta `@InjectableInit()`.
- A `setupDependencies()` hívja: `getIt.init()`.
- Importálja az `injection.config.dart` generált fájlt.

## System réteg

### AppConstants

Hozz létre `lib/system/utils/app_constants.dart` fájlt `final class AppConstants` osztállyal. Ebben legyen minden magic string, int, double és Duration:

- App cím: `OTP Stopwatch`
- Kezdeti idő: `00:00:00`
- Gomb feliratok: `Start`, `Pause`, `Reset`, `Lap`
- Lap prefix: `Lap`
- Kijelző label: `Digital`, `Analog`
- Route pathok: `/`, `/stopwatch`
- Route nevek: `splash`, `stopwatch`
- Splash késleltetés: 2 másodperc
- Stopwatch tick: 10 ms
- Display mode switch animation: 220 ms
- UI méretek: padding 16, section spacing 32, analog size 240, card radius 8, button min size 84x44 stb.
- Analóg óra rajzolásához szükséges stroke, tick és idő konstansok.

### Theme

`lib/system/theme/app_theme.dart`:

- `final class AppTheme`.
- `static ThemeData get light`.
- Material 3 legyen bekapcsolva.
- `ColorScheme.fromSeed(seedColor: Colors.blue, secondary: Colors.teal, tertiary: Colors.deepOrange)`.
- Scaffold háttér: `Color(0xFFF7F9FC)`.
- AppBar center title, elevation 0.
- CardTheme: fehér, elevation 0, border radius `AppConstants.displayCardRadius`.
- ElevatedButtonTheme: minimum size `AppConstants.buttonMinWidth` és `AppConstants.buttonMinHeight`.

### Router

`lib/system/navigation/routes.dart`:

- `AppRouter` osztály.
- `static final GoRouter router`.
- `initialLocation` legyen `AppConstants.splashPath`.
- Route-ok:
  - `/` -> `SplashView(targetLocation: AppConstants.stopwatchPath)`
  - `/stopwatch` -> `StopwatchView`
- `errorBuilder` adjon vissza `ErrorView(location: state.matchedLocation)`.

## Business réteg

### StopwatchSnapshot

`lib/business/models/stopwatch_snapshot.dart`:

- Immutable modell.
- Mező: `Duration elapsedTime`.
- Mező: `List<Duration> laps`.
- Mező: `bool isRunning`.
- Legyen normál const konstruktor.
- Legyen `const StopwatchSnapshot.initial()` konstruktor:
  - `elapsedTime = Duration.zero`
  - `laps = const []`
  - `isRunning = false`

### Data source

`lib/business/data_sources/local/stop_watch_data_source.dart`:

- Osztály neve: `StopWatchDataSource`.
- Annotáció: `@lazySingleton`.
- Tartalmazzon csak BehaviorSubjecteket, üzleti logika nélkül:
  - `BehaviorSubject<Duration>.seeded(Duration.zero)` elapsed time-hoz.
  - `BehaviorSubject<bool>.seeded(false)` running állapothoz.
  - `BehaviorSubject<List<Duration>>.seeded([])` lap listához.

### StopwatchEngine

`lib/business/services/stopwatch_engine.dart`:

- Osztály neve: `StopwatchEngine`.
- Annotáció: `@lazySingleton`.
- Konstruktorban kapjon `StopWatchDataSource`-t.
- Tartalmazzon privát `StreamSubscription<Duration>? _timerSubscription` mezőt.
- `snapshotStream` legyen `Rx.combineLatest3`, amely az elapsed time, laps és isRunning subjectekből `StopwatchSnapshot`-ot épít.
- `start()`:
  - Ha már fut, térjen vissza.
  - Állítsa `isRunning`-ot true-ra.
  - Indítson `Stream.periodic(AppConstants.stopwatchTickInterval)` streamet.
  - `scan` operátorral az előző elapsed értékről növelje az időt.
  - Listenelje az eredményt az elapsed subjectbe.
- `pause()`:
  - `isRunning` false.
  - Timer subscription cancel + null.
- `stop()`:
  - `isRunning` false.
  - Timer subscription cancel + null.
  - Elapsed zero.
  - Laps üres lista.
- `recordLap()`:
  - Az aktuális elapsed időt tegye hozzá a laps listához.
- `dispose()`:
  - Timer cancel.
  - Subjectek close.

### Repository

`lib/business/repositories/stopwatch_repository.dart`:

- Abstract class.
- Metódusok:
  - `void startTimer()`
  - `void pauseTimer()`
  - `void stopTimer()`
  - `void recordLap()`
  - `void dispose()`
  - `Stream<StopwatchSnapshot> get stopwatchSnapshotStream`

`lib/business/repositories/stopwatch_repository_impl.dart`:

- Osztály neve: `StopwatchRepositoryImpl`.
- Annotáció: `@LazySingleton(as: StopwatchRepository)`.
- Konstruktorban kapjon `StopwatchEngine stopwatchEngine`-t named required parameterként.
- Minden repository metódus delegáljon az engine megfelelő metódusára.

### Use case-ek

Hozz létre külön fájlokat:

- `StartStopwatchUseCase`
- `PauseStopwatchUseCase`
- `ResetStopwatchUseCase`
- `RecordLapUseCase`

Mindegyik:

- `@injectable` annotációt kapjon.
- Konstruktorban kapjon `StopwatchRepository`-t.
- `void call()` metódussal hívja a megfelelő repository metódust.

### Duration extension

`lib/business/utils/duration_ext.dart`:

- Extension neve: `WatcherFormat`.
- `String toDurationDisplay()` metódus.
- Formátum: `mm:ss:cc`, ahol `cc` centisecond.
- Használja az `AppConstants` idő és padding konstansait.

## UI réteg

### SplashView

`lib/ui/splash_page/splash_view.dart`:

- StatefulWidget.
- Konstruktorban kapjon `required String targetLocation`.
- `initState` indítson `Timer(AppConstants.splashDelay, ...)`.
- Ha mounted, `context.go(widget.targetLocation)`.
- UI: Scaffold centerben timer ikon, cím, progress indicator.

### ErrorView

`lib/ui/error_page/error_view.dart`:

- StatelessWidget.
- Konstruktorban kapjon `required String location`.
- AppBar title: `AppConstants.errorTitle`.
- Body: `Page not found: <location>` az AppConstants prefix használatával.

### Stopwatch enumok

`lib/ui/stop_watch_page/bloc/state_enums/stop_watch_display_mode_enum.dart`:

```dart
enum StopwatchDisplayModeEnum {
  digital,
  analog,
}
```

`lib/ui/stop_watch_page/bloc/state_enums/stop_watch_state_enum.dart`:

```dart
enum StopwatchStatusEnum {
  initial,
  running,
  paused,
}
```

### StopwatchEvent

`lib/ui/stop_watch_page/bloc/stopwatch_event.dart`:

- Freezed event.
- Importálja a snapshot modellt és display mode enumot.
- `part 'stopwatch_event.freezed.dart';`
- Eventek:
  - `start()`
  - `pause()`
  - `reset()`
  - `recordLap()`
  - `snapshotUpdated(StopwatchSnapshot snapshot)`
  - `displayModeChanged(StopwatchDisplayModeEnum displayMode)`

Megjegyzés: ha az IDE Freezed 3 mellett kéri, az event osztály lehet `sealed class StopwatchEvent with _$StopwatchEvent`. Az aktuális kódban `class StopwatchEvent with _$StopwatchEvent` forma szerepel.

### StopwatchState

`lib/ui/stop_watch_page/bloc/stopwatch_state.dart`:

- Freezed state.
- Fontos: Freezed 3 mellett `abstract class StopwatchState with _$StopwatchState` legyen, különben az IDE/Dart kérheti a getterek kézi override-ját.
- Egyetlen state konstruktor legyen, ne union state-ek.
- Mezők:
  - `status`, default `StopwatchStatusEnum.initial`
  - `snapshot`, default `StopwatchSnapshot.initial()`
  - `displayMode`, default `StopwatchDisplayModeEnum.digital`

Forma:

```dart
@freezed
abstract class StopwatchState with _$StopwatchState {
  const factory StopwatchState({
    @Default(StopwatchStatusEnum.initial) StopwatchStatusEnum status,
    @Default(StopwatchSnapshot.initial()) StopwatchSnapshot snapshot,
    @Default(StopwatchDisplayModeEnum.digital)
    StopwatchDisplayModeEnum displayMode,
  }) = _StopwatchState;
}
```

Ne írj kézzel getter override-okat a state osztályba. Nem kell `throw UnimplementedError()`.

### StopwatchBloc

`lib/ui/stop_watch_page/bloc/stopwatch_bloc.dart`:

- Annotáció: `@injectable`.
- `Bloc<StopwatchEvent, StopwatchState>`.
- Konstruktorban kapja:
  - `StopwatchRepository stopwatchRepository`
  - `StartStopwatchUseCase startStopwatchUseCase`
  - `PauseStopwatchUseCase pauseStopwatchUseCase`
  - `ResetStopwatchUseCase resetStopwatchUseCase`
  - `RecordLapUseCase recordLapUseCase`
- Kezdő state: `const StopwatchState()`.
- Iratkozzon fel a `stopwatchRepository.stopwatchSnapshotStream`-re.
- Minden snapshot érkezésnél adjon hozzá `StopwatchEvent.snapshotUpdated(snapshot)` eventet.
- `close()` cancelolja a subscriptiont.
- Event kezelés:
  - `start` -> `startStopwatchUseCase()`
  - `pause` -> `pauseStopwatchUseCase()`
  - `reset` -> `resetStopwatchUseCase()`
  - `recordLap` -> `recordLapUseCase()`
  - `snapshotUpdated` -> `emit(state.copyWith(snapshot: event.snapshot))`
  - `displayModeChanged` -> `emit(state.copyWith(displayMode: event.displayMode))`

Az aktuális állapot szerint a `status` mező létezik, de a bloc nem frissíti snapshot alapján. Ha később szükség lesz rá, snapshotból lehet számolni, de a jelenlegi kódbázis reprodukciójánál hagyd így.

### StopwatchView

`lib/ui/stop_watch_page/stopwatch_view.dart`:

- StatelessWidget.
- `BlocProvider<StopwatchBloc>` hozza létre a blocot `getIt<StopwatchBloc>()` segítségével.
- Scaffold AppBar title: `AppConstants.appTitle`.
- Body: `BlocBuilder<StopwatchBloc, StopwatchState>`.
- Column:
  - `DisplayModeSwitch(displayMode: state.displayMode)`
  - AnimatedSwitcher:
    - Ha `state.displayMode == StopwatchDisplayModeEnum.analog`, akkor `AnalogStopwatchDisplay(elapsedTime: state.snapshot.elapsedTime)`.
    - Különben `DigitalStopwatchDisplay(elapsedTime: state.snapshot.elapsedTime)`.
  - `WatchControlButtons`
  - `LapsList(laps: state.snapshot.laps)`

### DisplayModeSwitch

- StatelessWidget.
- Kapjon nem-nullable `StopwatchDisplayModeEnum displayMode` paramétert.
- Row-ban jelenjen meg `Digital` label, `Switch`, `Analog` label.
- Switch value: `displayMode == StopwatchDisplayModeEnum.analog`.
- `onChanged` küldjön `StopwatchEvent.displayModeChanged(...)` eventet a `context.read<StopwatchBloc>()`-on keresztül.

### WatchControlButtons

- StatelessWidget.
- Row, `MainAxisAlignment.spaceEvenly`.
- Négy `StopperButton`:
  - Start -> `StopwatchEvent.start()`
  - Pause -> `StopwatchEvent.pause()`
  - Reset -> `StopwatchEvent.reset()`
  - Lap -> `StopwatchEvent.recordLap()`
- Fontos: ne `getIt<StopwatchBloc>()`-ot használjon, hanem `context.read<StopwatchBloc>()`-ot, hogy a `StopwatchView` által biztosított bloc példány kapja az eventeket.

### DigitalStopwatchDisplay

- StatelessWidget.
- Kapjon `Duration elapsedTime` paramétert.
- Card + Container.
- Teljes szélesség, padding `AppConstants.displayCardPadding`.
- Gradient: `colorScheme.primaryContainer` és `colorScheme.secondaryContainer`.
- Label: `AppConstants.digitalDisplayLabel`.
- Idő: `TimeDisplay(time: elapsedTime.toDurationDisplay())`.

### AnalogStopwatchDisplay

- StatelessWidget.
- Kapjon `Duration elapsedTime`.
- Card + Padding + `SizedBox.square(dimension: AppConstants.analogDisplaySize)`.
- `CustomPaint` használjon privát `_AnalogStopwatchPainter`-t.
- Painter:
  - Rajzoljon számlapot.
  - Rajzoljon 60 ticket, minden 5. legyen major tick.
  - Rajzoljon három mutatót:
    - minute hand primary színnel
    - second hand secondary színnel
    - centisecond hand tertiary színnel
  - Középső pont primary színnel.
  - `shouldRepaint` akkor true, ha elapsed time vagy color scheme változott.

### LapsList

- Kapjon `List<Duration> laps`.
- A lista elemei jelenjenek meg `Lap 1: mm:ss:cc`, `Lap 2: ...` formában.
- Használja a `Duration.toDurationDisplay()` extensiont.

### TimeDisplay és StopperButton

- `TimeDisplay` jelenítse meg a kapott stringet nagy betűmérettel, `AppConstants.timeDisplayFontSize` használatával.
- `StopperButton` legyen újrahasználható gomb `title` és `onPressed` paraméterekkel.

## Tesztek

### StopwatchEngine tesztek

`test/business/stopwatch_engine_test.dart`:

- `StopWatchDataSource` és `StopwatchEngine` setUp-ban.
- tearDown-ban `engine.dispose()`.
- Tesztek:
  - start után `isRunning == true`, elapsed time nő.
  - pause után az idő nem nő tovább.
  - stop nullázza az elapsed time-ot és üríti a laps listát.
  - többszöri start futás közben ne gyorsítsa fel a stoppert.
  - recordLap rögzít egy nullánál nagyobb lap időt.

### StopwatchView widget tesztek

`test/ui/stopwatch_view_test.dart`:

- A DI-t tesztenként reseteld.
- Hozz létre kézzel:
  - `StopWatchDataSource`
  - `StopwatchEngine`
  - `StopwatchRepositoryImpl`
  - `StopwatchBloc`
  - Use case-ek
- Regisztráld `getIt`-be a repositoryt és a blocot.
- Teszteld:
  - A gombok látszanak.
  - Start után az idő elindul.
  - Pause után az idő megáll.
  - Reset után visszatér `00:00:00`-ra.
  - Lap gomb után megjelenik `Lap 1:`.

## Kódstílus és fontos megkötések

- Használj abszolút `package:otp2/...` importokat.
- Ne tedd a stopwatch üzleti logikáját a UI-ba.
- A data source csak állapottár legyen, a timer logika a `StopwatchEngine`-ben legyen.
- A repository csak delegáló adapter legyen az engine felé.
- A use case-ek vékonyak, de maradjanak meg a clean/pragmatikus architektúra miatt.
- A stopwatch UI feature a `ui/stop_watch_page` alatt legyen, azon belül `bloc`, `parts`, `state_enums`.
- A `displayMode` a Bloc state része legyen, ne kerüljön a business snapshotba.
- A `StopwatchState` egyetlen Freezed state legyen, ne `initial/running/paused/changedDisplayMode` union state-ek.
- Freezed 3 mellett a state legyen `abstract class`, és ne legyenek kézzel írt getter override-ok.
- A generált `.freezed.dart` és `injection.config.dart` fájlokat build_runnerrel kell előállítani.
