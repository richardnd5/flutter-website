import 'package:flutter/material.dart';
import 'package:flutter_website/pixel/models/cell.dart';

import 'canvas_helper.dart';

class CanvasService extends ChangeNotifier {
  Size get gridDimensions => _gridDimensions;
  Size _gridDimensions = Size(50, 50);

  double get cellSize => _cellSize;
  late double _cellSize = 40;

  Size get screenSize => _screenSize;
  late Size _screenSize;

  double get gridLineWidth => _gridLineWidth;
  double _gridLineWidth = 0.1;
  Color gridLineColor = Colors.lightBlue;

  int get currentSelectedIndex => _currentSelectedIndex;
  int _currentSelectedIndex = 0;

  bool get firstIndex => _currentSelectedIndex <= 0;
  bool get lastIndex => _currentSelectedIndex >= _canvasAnimation.length - 1;

  List<Cell> get currentScreen => _currentScreen;
  List<Cell> _currentScreen = [];

  List<Cell> _currentCells = [];
  List<Cell> _previousCells = [];

  List<List<Cell>> _canvasAnimation = [];

  bool get playingAnimation => _playingAnimation;
  bool _playingAnimation = false;

  bool get loading => _loading;
  bool _loading = false;

  bool get canvasSaved => _canvasSaved;
  bool _canvasSaved = true;

  bool get saveOnEachChange => _saveOnEachChange;
  bool _saveOnEachChange = false;

  bool get showPreviousFrame => _showPreviousFrame;
  bool _showPreviousFrame = true;

  bool get grid => _grid;
  bool _grid = true;

  bool panDownState = true;

  bool get selectMode => _selectMode;

  bool _selectMode = false;

  bool get canRedo => editHistoryIndex >= _currentCanvasEditHistory.length - 1;
  bool get canUndo => _currentCanvasEditHistory.length > 0;

  int get editHistoryIndex => _editHistoryIndex;
  int _editHistoryIndex = 0;
  List<List<Cell>> _currentCanvasEditHistory = [];

  setSelectMode(bool value) {
    _selectMode = value;
    print(_selectMode);
    notifyListeners();
  }

  startCanvasService(Size gridDimensions, Size screenSize) {
    resetCanvasToScreenDimensions(gridDimensions, screenSize);
    _canvasAnimation.add(_currentCells);
    _currentCanvasEditHistory.add(_currentCells);
  }

  resetCanvasToScreenDimensions(Size gridDimensions, Size screenSize) {
    clearCanvas();
    _screenSize = screenSize;
    _gridDimensions = gridDimensions;
    _cellSize = (screenSize.width / gridDimensions.width);

    var count = 0;
    for (var i = 0; i < _gridDimensions.width; i++) {
      for (var v = 0; v < _gridDimensions.height; v++) {
        var xPos = i.toDouble();
        var yPos = v.toDouble();
        var color = Colors.black;

        Offset gridPos = Offset(xPos, yPos);
        _currentCells.add(
          Cell(
            color: color,
            gridPos: gridPos,
            on: false,
            number: count,
            size: _cellSize,
          ),
        );
        count++;
      }
    }
    _renderScreen();
  }

  toggleGrid() {
    _grid = !_grid;
    notifyListeners();
  }

  toggleShowPreviousFrame() {
    _showPreviousFrame = !_showPreviousFrame;
    _renderScreen();
    notifyListeners();
  }

  toggleSaveOnEachChange() {
    _saveOnEachChange = !_saveOnEachChange;
    notifyListeners();
  }

  setPanDownColor(Offset localPosition) {
    var foundCell = _currentCells.firstWhere(
        (cell) => tapWithinOffset(
            localPosition,
            Offset(cell.gridPos!.dx * cellSize, cell.gridPos!.dy * cellSize),
            cellSize),
        orElse: () =>
            Cell(color: Colors.black, gridPos: null, on: false, number: 0));
    if (foundCell.gridPos != null) {
      panDownState = !foundCell.on;
    }
  }

  checkTapPosition(Offset localPosition, {bool isDrag = false}) =>
      _getCellAtPosition(localPosition, isDrag);

  _getCellAtPosition(Offset localPosition, bool isDrag) {
    var foundCell = _currentCells.firstWhere(
        (cell) => tapWithinOffset(
            localPosition,
            Offset(cell.gridPos!.dx * cellSize, cell.gridPos!.dy * cellSize),
            cellSize),
        orElse: () =>
            Cell(color: Colors.black, gridPos: null, on: false, number: 0));
    if (foundCell.gridPos != null) {
      foundCell.on = isDrag ? panDownState : !foundCell.on;
      _canvasSaved = false;
      saveToEditHistory();
      saveToCurrentSlot();
      if (saveOnEachChange) saveAndIncrement();
      _renderScreen();
      notifyListeners();
    }
  }

  loadBlankCanvas() {
    resetCanvasToScreenDimensions(gridDimensions, screenSize);
  }

  drawPreviousCanvas() {
    _previousCells = _canvasAnimation[currentSelectedIndex - 1]
        .map(
          (e) => Cell(
            color: e.color.withOpacity(0.3),
            gridPos: e.gridPos,
            on: e.on,
            number: e.number,
            size: e.size,
          ),
        )
        .toList();
    _currentScreen.addAll(_previousCells);
    notifyListeners();
  }

  _renderScreen() {
    _currentScreen = [
      ..._currentCells,
      if (showPreviousFrame) ..._previousCells
    ];
    notifyListeners();
  }

  clearCanvas() {
    _currentCells = [];
    _previousCells = [];
    _currentScreen = [];
    notifyListeners();
  }

  clearAnimation() {
    _currentCells = [];
    _canvasSaved = false;
    _canvasAnimation = [];
    _previousCells = [];
    _currentSelectedIndex = 0;
    loadBlankCanvas();
    _renderScreen();
    notifyListeners();
  }

  bool saveAndIncrement() {
    if (!_canvasSaved /* && _currentCells.isNotEmpty */) {
      addCurrentCellsToAnimationArray();
      _canvasSaved = true;
      makeNewFrame();
      return true;
    }
    return false;
  }

  saveToCurrentSlot() {
    _currentCanvasEditHistory[_editHistoryIndex] = _currentCells;
    _canvasAnimation[currentSelectedIndex] = _currentCells;
  }

  saveToEditHistory() {
    final List<Cell> _copy = _currentCells
        .map<Cell>((e) => new Cell(
              color: e.color,
              gridPos: e.gridPos,
              on: e.on,
              number: e.number,
              size: e.size,
            ))
        .toList();
    _currentCanvasEditHistory.add(_copy);
  }

  redoPressed() {
    _editHistoryIndex++;
    clearCanvas();
    loadBlankCanvas();
    _currentCells = _currentCanvasEditHistory[currentSelectedIndex];
    // draw previous cells

    _renderScreen();
  }

  undoPressed() {
    if (editHistoryIndex > 0) {
      _editHistoryIndex--;
    }
    clearCanvas();
    loadBlankCanvas();

    _currentCells = _currentCanvasEditHistory[_editHistoryIndex - 1];
    // draw previous cells
    _renderScreen();
  }

  makeNewFrame() {
    _currentSelectedIndex += 1;
    clearCanvas();
    loadBlankCanvas();
    _renderScreen();
  }

  playAnimation(
      {Duration frameRate = const Duration(milliseconds: 100),
      bool loop = true}) async {
    bool previousValue = _showPreviousFrame;
    _showPreviousFrame = false;

    for (var i = 0; i < _canvasAnimation.length; i++) {
      _currentCells = _canvasAnimation[i];
      _currentSelectedIndex = i;
      _renderScreen();
      await Future.delayed(frameRate);
    }
    clearCanvas();
    loadBlankCanvas();
    _previousCells = _canvasAnimation[_currentSelectedIndex];
    _currentScreen = _currentCells;
    _renderScreen();
    _playingAnimation = false;
    _showPreviousFrame = previousValue;
    _canvasSaved = true;
  }

  goBackAFrame() {
    saveToCurrentSlot();
    if (_canvasAnimation.isNotEmpty && currentSelectedIndex > 0) {
      _currentSelectedIndex -= 1;
      clearCanvas();
      _currentCells = _canvasAnimation[currentSelectedIndex];
      _renderScreen();
      if (currentSelectedIndex - 1 > 0) {
        _previousCells = _canvasAnimation[currentSelectedIndex - 1];
        drawPreviousCanvas();
        _renderScreen();
      } else {
        notifyListeners();
      }
    } else {
      notifyListeners();
    }
  }

  goForwardAFrame() {
    saveToCurrentSlot();
    if (_canvasAnimation.length - 1 > currentSelectedIndex) {
      _currentSelectedIndex += 1;
      _currentCells = _canvasAnimation[currentSelectedIndex];
      if (currentSelectedIndex > 0) {
        _previousCells = _canvasAnimation[currentSelectedIndex - 1];
        drawPreviousCanvas();
      }
      _renderScreen();
    } else {
      notifyListeners();
    }
  }

  addCurrentCellsToAnimationArray() {
    final List<Cell> _secondList = _currentCells
        .map<Cell>((e) => new Cell(
              color: e.color,
              gridPos: e.gridPos,
              on: e.on,
              number: e.number,
              size: e.size,
            ))
        .toList();
    _canvasAnimation.add(_secondList);
  }
}
