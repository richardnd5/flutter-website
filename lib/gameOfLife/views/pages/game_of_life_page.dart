import 'package:flutter/material.dart';
import 'package:flutter_website/gameOfLife/services/game_of_life_service.dart';
import 'package:flutter_website/views/helpers/page_gradient.dart';
import 'package:provider/provider.dart';

import '../components/game_of_life_painter.dart';

class GameOfLifePage extends StatefulWidget {
  const GameOfLifePage({Key? key}) : super(key: key);

  @override
  _GameOfLifePageState createState() => _GameOfLifePageState();
}

class _GameOfLifePageState extends State<GameOfLifePage> {
  Size? painterSize;
  Size? screenSize;

  GameOfLifeService? game;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      game = Provider.of<GameOfLifeService>(context, listen: false);
      game?.createRandomGrid();
    });
    super.initState();
  }

  _handleTap(
    BuildContext context,
    List<List<int>> dotList,
    TapUpDetails details,
  ) {
    int divider =
        dotList[0].length > dotList.length ? dotList[0].length : dotList.length;
    double squareWidth = screenSize!.width / divider;
    double squareHeight = screenSize!.height / divider;

    print(details.localPosition);

    var flattened = dotList.expand((pair) => pair).toList();

    //       var dotPosition = Offset(j * squareWidth, i * squareHeight);
    // Rect rect = Offset(dotPosition.dx, dotPosition.dy) &
    //     Size(squareWidth, squareHeight);

    // dotList.asMap().forEach((i, row) {
    //   row.asMap().forEach((j, column) {
    //     if (column == 1) {
    // var dotPosition = Offset(j * squareWidth, i * squareHeight);
    // Rect rect = Offset(dotPosition.dx, dotPosition.dy) &
    //     Size(squareWidth, squareHeight);

    //       print(rect);
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    var watched = context.watch<GameOfLifeService>();

    _setPainterSize();

    var grid = context.watch<GameOfLifeService>().grid;
    var timerValue = context.watch<GameOfLifeService>().timerValue;
    int generationCount = context.watch<GameOfLifeService>().generationCount;

    double sliderValue = context.watch<GameOfLifeService>().sliderValue;

    return Container(
      decoration: pageGradient(Colors.blue, Colors.lightBlue),
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          toolbarHeight: 80,
          title: const Text("Epic Conway's Game of Life"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildPainter(painterSize!, grid),
              _buildOptionsSection(
                  generationCount, context, timerValue, sliderValue),
            ],
          ),
        ),
      ),
    );
  }

  void _setPainterSize() {
    painterSize = screenSize!.width < screenSize!.height
        ? Size(screenSize!.width, screenSize!.width)
        : Size(screenSize!.height * .8, screenSize!.height * .8);
  }

  Center _buildPainter(Size painterSize, List<List<int>> grid) {
    return Center(
      child: GestureDetector(
        onTapUp: (details) => _handleTap(context, grid, details),
        child: CustomPaint(
          size: painterSize,
          painter: GameOfLifePainter(
            screenSize: painterSize,
            columns: grid.length,
            rows: grid.isEmpty ? 0 : grid[0].length,
            dotList: grid,
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsSection(
    int generationCount,
    BuildContext context,
    int timerValue,
    double sliderValue,
  ) {
    var watched = context.watch<GameOfLifeService>();
    var sliderRange = watched.sliderRange;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
          ),
          Slider(
            min: sliderRange.lowerBound,
            max: sliderRange.upperBound,
            value: sliderValue,
            onChanged: game?.handleSlider,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                '$timerValue ms per generation',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32,
                  child: Text(
                    'Generation: ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Container(
                  height: 32,
                  alignment: Alignment.center,
                  child: Text(
                    '$generationCount',
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: game?.createRandomGrid,
                  child: const Icon(Icons.restore),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
                const SizedBox(width: 16),
                Text(
                  'Run',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch(
                  value: watched.simulationOn,
                  onChanged: game?.handleToggle,
                ),
                ElevatedButton(
                  onPressed:
                      watched.simulationOn ? null : () => game?.setNextState(),
                  child: const Icon(
                    Icons.next_plan,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(32, 32),
                    maximumSize: const Size(32, 32),
                    primary: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
