class StopwatchSnapshot {
  final Duration elapsedTime;
  final List<Duration> laps;
  final bool isRunning;

  const StopwatchSnapshot({
    required this.elapsedTime,
    required this.laps,
    required this.isRunning,
  });

  const StopwatchSnapshot.initial():
    elapsedTime = Duration.zero,
    laps = const [],
    isRunning = false;
}
