import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/player_type.dart';
import '../../service/tic_tac_toe_service.dart';

class TicTacToeCell extends StatefulWidget {
  const TicTacToeCell(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  State<TicTacToeCell> createState() => _TicTacToeCellState();
}

class _TicTacToeCellState extends State<TicTacToeCell> {
  @override
  Widget build(BuildContext context) {
    var cell = context.watch<TicTacToeService>().gameCells[widget.index];

    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
          color: Colors.transparent,
          child: LayoutBuilder(builder: (context, constraints) {
            var smaller = constraints.maxWidth < constraints.maxHeight
                ? constraints.maxWidth
                : constraints.maxHeight;
            return cell!.filled
                ? Center(
                    child: Icon(
                      cell.type == PlayerType.x
                          ? Icons.close
                          : Icons.circle_outlined,
                      size: smaller - 16,
                      color: cell.type == PlayerType.x
                          ? Colors.orange
                          : Colors.red,
                    ),
                  )
                : Container();
          })),
    );
  }

  void onTap(BuildContext context) {
    Provider.of<TicTacToeService>(context, listen: false)
        .updateCell(widget.index);
  }
}
