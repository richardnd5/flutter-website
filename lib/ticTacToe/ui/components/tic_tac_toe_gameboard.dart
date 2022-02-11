import 'package:flutter/material.dart';
import 'package:flutter_website/ticTacToe/ui/components/tic_tac_toe_cell.dart';
import 'package:provider/provider.dart';

import '../../service/tic_tac_toe_service.dart';
import 'tic_tac_toe_lines.dart';

class TicTacToeGameBoard extends StatelessWidget {
  const TicTacToeGameBoard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<TicTacToeService>();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: TicTacToeLines(),
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: vm.numberOfColumns,
              mainAxisExtent: size / (vm.cellCount / vm.numberOfColumns),
              childAspectRatio: vm.numberOfRows / vm.numberOfColumns,
            ),
            itemBuilder: (context, i) => TicTacToeCell(i),
            itemCount: context.watch<TicTacToeService>().cellCount,
          ),
        ],
      ),
    );
  }
}
