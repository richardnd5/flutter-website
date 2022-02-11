import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class PendulumViewModel extends ChangeNotifier {
  Size size;

  double bobRadius = 20;
  late double angle;
  late Offset origin;
  late double length;
  late Offset bob;

  double aVel = 0.0;
  double aAcc = 0.0;

  Timer? timer;

  PendulumViewModel(this.size) {
    init(size);
  }

  init(Size size) {
    angle = pi / 5;
    origin = Offset(size.width / 2, 0);
    length = size.height / 2;
    setBobPos();
  }

  setBobPos() {
    bob = Offset(
      origin.dx + length * sin(angle),
      origin.dy + length * cos(angle),
    );
    notifyListeners();
  }

  startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 17), (timer) {
      aAcc = -0.01 * sin(angle);
      angle += aVel;
      aVel += aAcc;
      aVel *= 0.99;

      setBobPos();
      notifyListeners();
    });
  }

  stopTimer() {
    timer?.cancel();
  }
}
