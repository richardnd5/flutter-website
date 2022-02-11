import '../../enums/player_type.dart';
import '../../models/game_cell.dart';

extension GameCellsExtension on Map<int, GameCell> {
  bool haveWinningPlayer() {
    bool row1 = _checkForSet(0, 1, 2);
    bool row2 = _checkForSet(3, 4, 5);
    bool row3 = _checkForSet(6, 7, 8);

    bool col1 = _checkForSet(0, 3, 6);
    bool col2 = _checkForSet(1, 4, 7);
    bool col3 = _checkForSet(2, 5, 8);

    bool diag1 = _checkForSet(0, 4, 8);
    bool diag2 = _checkForSet(2, 4, 6);

    return row1 || row2 || row3 || col1 || col2 || col3 || diag1 || diag2;
  }

  bool _checkForSet(int a, int b, int c) {
    final set = [this[a], this[b], this[c]].map((e) => e?.type);

    bool allPlayerX = set.every((type) => type == PlayerType.x);
    bool allPlayerO = set.every((type) => type == PlayerType.o);

    return allPlayerX || allPlayerO;
  }

  bool allFilled() => values.every((cell) => cell.filled);
}
