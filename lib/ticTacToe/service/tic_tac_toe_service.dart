import 'package:flutter/material.dart';

import './extensions/game_cell_extension.dart';
import '../enums/player_type.dart';
import '../models/game_cell.dart';
import '../models/player.dart';

enum GameState { playing, playerWon, draw }

class TicTacToeService extends ChangeNotifier {
  TicTacToeService() {
    restartGame();
  }

  List<Player> playerList = [Player(PlayerType.x), Player(PlayerType.o)];

  int get cellCount => numberOfRows * numberOfColumns;
  final int numberOfRows = 3;
  final int numberOfColumns = 3;
  Map<int, GameCell> gameCells = {};

  int totalPlayerCount = 2;
  int turnCount = 0;
  int currentPlayer = 0;
  int winRadius = 3;
  GameState state = GameState.playing;

  List<Map<int, GameCell>> stateHistory = [];

  void updateCell(int index) {
    if (gameCells.length <= index) return;

    if (gameCells[index]!.empty == true) {
      gameCells[index]!.filled = true;
      gameCells[index]!.type = playerList[currentPlayer].type;

      if (gameCells.haveWinningPlayer()) {
        state = GameState.playerWon;
      } else if (gameCells.allFilled()) {
        state = GameState.draw;
      } else {
        _goToNextTurn();
      }
      _addStateToGameHistory();
      notifyListeners();
    }
  }

  void handleGoBack() {
    if (stateHistory.length > 1) {
      stateHistory.removeLast();
      gameCells = stateHistory.last;
      notifyListeners();
    } else {
      restartGame();
    }
  }

  void restartGame() {
    for (var i = 0; i < cellCount; i++) {
      gameCells[i] = GameCell(index: i);
    }
    turnCount = 0;
    currentPlayer = 0;
    stateHistory = [];
    state = GameState.playing;
    notifyListeners();
  }

  void _addStateToGameHistory() {
    var gameCellsCopy = gameCells.map<int, GameCell>(
        (key, value) => MapEntry(key, GameCell.clone(value)));

    stateHistory.add(gameCellsCopy);
  }

  void _goToNextTurn() {
    turnCount++;
    currentPlayer = currentPlayer == 0 ? 1 : 0;
  }
}
