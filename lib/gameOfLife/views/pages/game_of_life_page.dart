import 'package:flutter/material.dart';
import 'package:flutter_website/gameOfLife/services/game_of_life_service.dart';
import 'package:flutter_website/pixel/views/components/two_finger_interactive_viewer.dart';
import 'package:flutter_website/views/helpers/page_gradient.dart';
import 'package:provider/provider.dart';
import '../components/game_of_life_painter.dart';

class GameOfLifePage extends StatefulWidget {
  const GameOfLifePage({Key? key}) : super(key: key);

  @override
  _GameOfLifePageState createState() => _GameOfLifePageState();
}

class _GameOfLifePageState extends State<GameOfLifePage> {
  double padding = 8;
  Size? painterSize;
  Size? screenSize;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _generateRandomGrid());
    super.initState();
  }

  _generateRandomGrid() {
    Provider.of<GameOfLifeService>(context, listen: false).createRandomGrid();
  }

  _setNextState() {
    Provider.of<GameOfLifeService>(context, listen: false).setNextState();
  }

  _handleToggle(bool state) {
    Provider.of<GameOfLifeService>(context, listen: false).handleToggle(state);
  }

  _handleSlider(double value) {
    Provider.of<GameOfLifeService>(context, listen: false).handleSlider(value);
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

    _setPainterSize();

    var grid = context.watch<GameOfLifeService>().grid;
    var timerValue = context.watch<GameOfLifeService>().timerValue;
    int generationCount = context.watch<GameOfLifeService>().generationCount;

    double sliderValue = context.watch<GameOfLifeService>().sliderValue;

    return Container(
      decoration: pageGradient(Colors.blue, Colors.lightBlue),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Epic Conway's Game of Life"),
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
        ? Size(
            screenSize!.width - padding,
            screenSize!.width - padding,
          )
        : Size(
            screenSize!.height * .8 - padding,
            screenSize!.height * .8 - padding,
          );
  }

  Center _buildPainter(Size painterSize, List<List<int>> grid) {
    return Center(
      child: TwoFingerInteractiveViewer(
        maxScale: 10,
        minScale: 1,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Run',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Switch(
                  value: watched.simulationOn,
                  onChanged: _handleToggle,
                ),
                ElevatedButton(
                  onPressed:
                      watched.simulationOn ? null : () => _setNextState(),
                  child: Icon(Icons.next_plan),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(32, 32),
                    maximumSize: Size(32, 32),
                  ),
                ),
              ],
            ),
          ),
          Slider(
            min: sliderRange.lowerBound,
            max: sliderRange.upperBound,
            value: sliderValue,
            onChanged: _handleSlider,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
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
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _generateRandomGrid,
                  child: Icon(Icons.restore),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
