import '../enums/player_type.dart';

class GameCell {
  int index;
  bool filled;
  PlayerType type;

  GameCell({
    this.filled = false,
    this.type = PlayerType.none,
    this.index = 0,
  });

  bool get empty => !filled;

  factory GameCell.clone(GameCell source) {
    return GameCell(
      index: source.index,
      filled: source.filled,
      type: source.type,
    );
  }
}
