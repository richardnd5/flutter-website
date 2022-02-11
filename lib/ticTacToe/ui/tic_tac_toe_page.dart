import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_website/views/helpers/page_gradient.dart';
import 'package:provider/provider.dart';

import '../service/tic_tac_toe_service.dart';
import 'components/tic_tac_toe_gameboard.dart';

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({Key? key}) : super(key: key);

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<TicTacToeService>(context, listen: false);
    var size = MediaQuery.of(context).size;
    final smallestSize =
        size.width > size.height ? size.height * 0.8 : size.width * 0.8;

// subtracting 80 for padding
    double gameBoardSize = (smallestSize > 700 ? 700 : smallestSize) - 80;

    var gameState = context.watch<TicTacToeService>().state;
    bool gameOver =
        gameState == GameState.playerWon || gameState == GameState.draw;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: pageGradient(
              const Color(0xFFbbc6f0),
              const Color(0xFF0f1f61),
            ),
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "Player ${context.watch<TicTacToeService>().currentPlayer + 1}'s Turn",
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 16),
                  TicTacToeGameBoard(size: gameBoardSize),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _backButton(vm),
                      const SizedBox(width: 16),
                      _restartButton(vm),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          if (gameOver) _winModal(vm)
        ],
      ),
    );
  }

  ElevatedButton _backButton(TicTacToeService vm) {
    return ElevatedButton(
      onPressed: vm.handleGoBack,
      child: const Icon(Icons.restart_alt),
    );
  }

  ElevatedButton _restartButton(TicTacToeService vm) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
      ),
      onPressed: vm.restartGame,
      child: const Icon(Icons.fiber_new),
    );
  }

  Widget _winModal(TicTacToeService vm) {
    return Stack(
      children: [
        Container(color: Colors.black.withOpacity(0.6)),
        Align(
          alignment: Alignment.center,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    vm.state == GameState.draw
                        ? 'Everyone Wins!'
                        : 'Player ${vm.currentPlayer + 1} wins!',
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 16),
                  _restartButton(vm),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
