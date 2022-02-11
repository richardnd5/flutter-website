import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';

class PolarPlayViewModel extends ChangeNotifier {
  Size screenSize;
  late double x;
  late double y;

  late double angle;
  late double radius;

  Timer? timer;

  PolarPlayViewModel(this.screenSize) {
    init(screenSize);
  }

  init(Size screenSize) {
    radius = screenSize.width / 3;
    angle = math.pi / 4;
    setCoords();
    // moveAroundCircle();
  }

  moveAroundCircle() {
    timer = Timer.periodic(Duration(milliseconds: 17), (timer) {
      angle += 0.1;
      // radius -= radius * math.sin(angle);
      // print(radius);
      setCoords();
      notifyListeners();
    });
  }

  setCoords() {
    x = screenSize.width / 2 + radius * math.cos(angle);
    y = screenSize.height / 2 + radius * math.sin(angle);
  }
}
