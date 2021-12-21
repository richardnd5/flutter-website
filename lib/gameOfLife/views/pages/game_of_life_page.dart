import 'package:flutter/material.dart';
import 'package:flutter_website/gameOfLife/services/game_of_life_service.dart';
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

    painterSize = screenSize!.width < screenSize!.height
        ? Size(
            screenSize!.width - padding,
            screenSize!.width - padding,
          )
        : Size(
            screenSize!.height * .8 - padding,
            screenSize!.height * .8 - padding,
          );

    var grid = context.watch<GameOfLifeService>().grid;
    var timerValue = context.watch<GameOfLifeService>().timerValue;
    int generationCount = context.watch<GameOfLifeService>().generationCount;

    double sliderValue = context.watch<GameOfLifeService>().sliderValue;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        shrinkWrap: true,
        children: [
          _buildHeading(),
          if (grid != null) _buildPainter(painterSize!, grid),
          _buildLowerSection(generationCount, context, timerValue, sliderValue),
        ],
      ),
    );
  }

  Center _buildPainter(Size painterSize, List<List<int>> grid) {
    return Center(
      child: GestureDetector(
        onTapUp: (details) => _handleTap(context, grid, details),
        child: Card(
          child: CustomPaint(
            size: painterSize,
            painter: GameOfLifePainter(
              screenSize: painterSize,
              columns: grid.length,
              rows: grid[0].length,
              dotList: grid,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildHeading() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        "Epic Conway's Game of Life",
        style: TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Card _buildLowerSection(
    int generationCount,
    BuildContext context,
    int timerValue,
    double sliderValue,
  ) {
    var sliderRange = Provider.of<GameOfLifeService>(context).sliderRange;

    return Card(
      child: Column(
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 60),
              Text('Generation:'),
              SizedBox(width: 8),
              SizedOverflowBox(
                size: Size(100, 26),
                alignment: Alignment.centerLeft,
                child: Text(
                  '$generationCount',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: _generateRandomGrid,
            child: Text('Generate Another Random Grid'),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: context.watch<GameOfLifeService>().simulationOn
                ? null
                : () => _setNextState(),
            child: Text('Go to next generation'),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Run Simulation'),
              Switch(
                value: context.watch<GameOfLifeService>().simulationOn,
                onChanged: _handleToggle,
              )
            ],
          ),
          Slider(
            min: sliderRange.lowerBound,
            max: sliderRange.upperBound,
            value: sliderValue,
            onChanged: (value) => _handleSlider(value),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              '$timerValue ms per generation',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
