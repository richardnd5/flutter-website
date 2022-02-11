import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_website/gameOfLife/helpers/closed_range.dart';
import 'package:flutter_website/gameOfLife/helpers/rescale.dart';

class GameOfLifeService extends ChangeNotifier {
  List<List<int>> get grid => _grid;
  List<List<int>> _grid = [];
  int get generationCount => _generationCount;
  int _generationCount = 0;

  int get columns => _columns;
  int _columns = 15;

  int get rows => _rows;
  int _rows = 15;

  Timer? _timer;
  int timerValue = 300;

  ClosedRange get sliderRange => _sliderRange;
  ClosedRange _sliderRange = ClosedRange(0, 500);

  double get sliderValue => _sliderValue;
  double _sliderValue = 400.0;

  bool get simulationOn => _simulationOn;
  bool _simulationOn = false;

  createRandomGrid() {
    _grid = List.generate(
      _columns,
      (_) => List.generate(rows, (_) => getRandomState()),
    );
    _generationCount = 0;
    handleSlider(_sliderValue);
    notifyListeners();
  }

  setNextState() {
    List<List<int>> newArray =
        List.generate(columns, (_) => List.generate(rows, (_) => 0));

    _grid.asMap().forEach(
      (i, col) {
        col.asMap().forEach(
          (j, row) {
            var state = _grid[i][j];
            var neighbors = countNeighbors(_grid, i, j);
            if (state == 0 && neighbors == 3) {
              // if cell is off and has 3 neighbors
              newArray[i][j] = 1;
            } else if (state == 1 && (neighbors < 2 || neighbors > 3)) {
              // if cell is on and has 'too few' or 'too many' neighbors
              newArray[i][j] = 0;
            } else {
              // keep the cell the same
              newArray[i][j] = state;
            }
          },
        );
      },
    );

    _grid = newArray;
    _generationCount++;
    notifyListeners();
  }

  setNewTimerValue() {
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: timerValue),
      (timer) => setNextState(),
    );
  }

  stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  handleToggle(bool state) {
    _simulationOn = state;
    state ? setNewTimerValue() : stopTimer();
    notifyListeners();
  }

  handleSlider(double value) {
    _sliderValue = value;
    double rescaledValue =
        Rescale(from: ClosedRange(0, 500), to: ClosedRange(300, 4))
            .rescale(value);
    timerValue = rescaledValue.toInt();
    if (simulationOn) setNewTimerValue();
    notifyListeners();
  }

  int countNeighbors(List<List<int>> worldArray, int x, int y) {
    var sum = 0;

    for (var i = -1; i < 2; i++) {
      for (var j = -1; j < 2; j++) {
        var col = (x + i + columns) % columns; // the % adds wrap around
        var row = (y + j + rows) % rows; // the % adds wrap around
        sum += worldArray[col][row];
      }
    }

    sum -= worldArray[x][y];
    return sum;
  }

  int getRandomState({int percentChanceOn = 20}) {
    var random = Random();
    var randomNum = random.nextInt(100);
    return randomNum < percentChanceOn ? 1 : 0;
  }
}
