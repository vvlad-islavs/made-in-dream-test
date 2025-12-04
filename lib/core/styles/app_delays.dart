class AppDelays {
  /// Медленное значение длительности анимации.
  static const Duration slowDelay = Duration(milliseconds: 500);

  /// Дефолтное значение длительности анимации.
  static const Duration defaultDelay = Duration(milliseconds: 250);

  /// Быстрое значение длительности анимации.
  static const Duration fastDelay = Duration(milliseconds: 100);

  /// Минимальное значение задержки.
  static const Duration safetyDelay = Duration(milliseconds: 20);

  /// Нулевое значение задержки.
  static const Duration zeroDelay = Duration.zero;

  static const all = [slowDelay, defaultDelay, fastDelay];
}
