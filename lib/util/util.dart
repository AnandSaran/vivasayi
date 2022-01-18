class Util {
  static final Util _util = Util._internal();

  factory Util() {
    return _util;
  }

  Util._internal();

  void delay(Function delayFunction, {Duration duration = Duration.zero}) {
    Future.delayed(duration, () {
      delayFunction();
    });
  }
}
