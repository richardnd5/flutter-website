import 'package:flutter/material.dart';
import 'package:flutter_website/pixel/services/canvas_service.dart';
import 'package:flutter_website/pixel/views/show_snack_bar.dart';
import 'package:flutter_website/pixel/views/two_finger_interactive_viewer.dart'
    as viewer;
import 'package:provider/provider.dart';
import 'my_painter.dart';

class PixelPage extends StatefulWidget {
  const PixelPage({Key? key}) : super(key: key);

  @override
  _PixelPageState createState() => _PixelPageState();
}

class _PixelPageState extends State<PixelPage> {
  CanvasService? canvas;

  bool safetyLocked = true;
  bool toggleDrag = false;

  Offset? panDownPos;
  Offset? panUpdatePos;

  Matrix4? vector4;

  viewer.TransformationController transformController =
      viewer.TransformationController();

  Rect? selectRect;
  @override
  void initState() {
    transformController.addListener(() {
      setState(() {
        vector4 = transformController.value;
      });
      print('transformation controller: ${transformController.value.row0}');
    });

    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      canvas = Provider.of<CanvasService>(context, listen: false);
      canvas!.startCanvasService(Size(16, 16), MediaQuery.of(context).size);
    });
  }

  @override
  void dispose() {
    transformController.dispose();
    super.dispose();
  }

  savePressed() {
    ScaffoldMessenger.of(context).clearSnackBars();

    canvas!.saveAndIncrement();

    if (canvas?.showPreviousFrame == true) {
      canvas?.clearCanvas();
      canvas?.loadBlankCanvas();
      canvas?.drawPreviousCanvas();
    }
  }

  saveOnChangeToggle() {
    Provider.of<CanvasService>(context, listen: false).toggleSaveOnEachChange();
  }

  toggleShowPreviousFrame() {
    canvas?.toggleShowPreviousFrame();
  }

  toggleGrid() {
    canvas?.toggleGrid();
  }

  playPressed() {
    ScaffoldMessenger.of(context).clearSnackBars();
    canvas?.playAnimation();
  }

  stopPressed() {
    // canvas?.stopAnimation();
  }

  clearAnimation() {
    canvas?.clearAnimation();
  }

  clearAnimationPressed() {
    ScaffoldMessenger.of(context).clearSnackBars();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Are you sure you want to clear the animation?'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              clearAnimation();
              showSnackBar(context, 'Animation Cleared');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  clearCanvasPressed() {
    setState(() {
      safetyLocked = true;
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    canvas?.resetCanvasToScreenDimensions(
        canvas?.gridDimensions ?? Size(20, 20),
        canvas?.screenSize ?? Size(100, 100));
  }

  handleCanvasTap(Offset localPosition) {
    print('tap localPosition:    $localPosition');
    setState(() {
      safetyLocked = true;
    });
    canvas?.checkTapPosition(localPosition);
  }

  handlePan(Offset localPosition) {
    // print(localPosition);
    canvas?.checkTapPosition(localPosition, isDrag: true);
  }

  handlePanDown(Offset localPosition) {
    setState(() {
      panDownPos = localPosition;
    });
    // print('pan down: $localPosition');
  }

  handlePanUpdate(Offset localPosition) {
    int toTheRight = localPosition.dx >= panDownPos!.dx ? 1 : -1;
    int downFrom = localPosition.dy >= panDownPos!.dy ? 1 : -1;

    double width = localPosition.dx - panDownPos!.dx;
    double height = localPosition.dy - panDownPos!.dy;

    Rect rect = Offset(panDownPos!.dx, panDownPos!.dy) & Size(width, height);
    // print('pan update: $localPosition');
    setState(() {
      panUpdatePos = localPosition;
      selectRect = rect;
    });
  }

  handlePanUp(Offset velocity) {
    var cellSize = Provider.of<CanvasService>(context, listen: false).cellSize;

    var left = selectRect!.left + (selectRect!.left % cellSize);
    var right = selectRect!.right + (selectRect!.right % cellSize);
    var bottom = selectRect!.bottom + (selectRect!.bottom % cellSize);
    var top = selectRect!.top + (selectRect!.top % cellSize);

    print(selectRect);

    setState(() {
      selectRect = Rect.fromLTRB(left, top, right, bottom);
      panDownPos = null;
    });
  }

  // _GestureType _getGestureType(ScaleUpdateDetails details) {
  //   final double scale = !widget.scaleEnabled ? 1.0 : details.scale;
  //   final double rotation = !_rotateEnabled ? 0.0 : details.rotation;
  //   if ((scale - 1).abs() > rotation.abs()) {
  //     return _GestureType.scale;
  //   } else if (rotation != 0.0) {
  //     return _GestureType.rotate;
  //   } else {
  //     return _GestureType.pan;
  //   }
  // }

  handleDrag(DragUpdateDetails details) {}

  handleStart(ScaleStartDetails details) {
    print(
        'pointerCound: ${details.pointerCount} focal point: ${details.focalPoint}   local focal point: ${details.localFocalPoint}');
  }

  handleUpdate(ScaleUpdateDetails details) {
    // print(
    // 'pointerCound: ${details.pointerCount} focal point: ${details.focalPoint}   local focal point: ${details.localFocalPoint} scale ${details.scale}');

    if (details.pointerCount == 1) {
      // Offset newOffset = Offset(
      //     details.localFocalPoint.dx -
      //         (details.scale <= 1.0
      //             ? 0
      //             : details.localFocalPoint.dx / details.scale),
      //     details.localFocalPoint.dy -
      //         (details.scale <= 1.0
      //             ? 0
      //             : details.localFocalPoint.dy -
      //                 (details.localFocalPoint.dy / details.scale)));

      // if (details.scale > 1) {
      //   // newOffset =
      // }

      // print(details.localFocalPoint.dx-(details.localFocalPoint.dx / ));

      print(vector4?.row0);

      var newOffset =
          Offset(details.localFocalPoint.dx, details.localFocalPoint.dy);
      handlePan(newOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    var service = context.watch<CanvasService>();
    bool saveOnEachChange = service.saveOnEachChange;
    bool showPreviousFrame = service.showPreviousFrame;
    bool grid = service.grid;

    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          drawerEnableOpenDragGesture: false,
          drawer: buildDrawer(saveOnEachChange, showPreviousFrame, grid),
          appBar: AppBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 32),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: service.firstIndex
                      ? null
                      : MaterialStateProperty.resolveWith(
                          (states) => Colors.blue),
                ),
                onPressed:
                    service.firstIndex ? null : () => canvas?.goBackAFrame(),
                child: Icon(Icons.arrow_left_rounded),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: service.lastIndex
                      ? null
                      : MaterialStateProperty.resolveWith(
                          (states) => Colors.blue),
                ),
                onPressed:
                    service.lastIndex ? null : () => canvas?.goForwardAFrame(),
                child: Icon(Icons.arrow_right_rounded),
              ),
              Spacer(),
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: context.watch<CanvasService>().canvasSaved
                      ? null
                      : savePressed,
                  child: Icon(Icons.create_rounded),
                ),
              ),
            ],
          ),
          persistentFooterButtons: _buildButtons(grid, context),
          body: viewer.TwoFingerInteractiveViewer(
            transformationController: transformController,
            onInteractionStart: (details) => handleStart(details),
            onInteractionUpdate: (details) => handleUpdate(details),
            onInteractionEnd: (details) =>
                print('velocity: ${details.velocity}'),

            // onInteractionUpdate: canvas?.selectMode == false
            //     ? (details) {
            //         handlePan(details.localFocalPoint);
            //       }
            //     : null,

            maxScale: 50,
            child: GestureDetector(
              // onPanEnd: (details) =>
              //     print('pan end: ${details.primaryVelocity}'),
              // onHorizontalDragUpdate: (details) => handleDrag(details),
              // onVerticalDragUpdate: (details) => handleDrag(details),
              // onScaleUpdate: ,
              // onScaleStart: (details) =>
              //     print('on scale start ${details.pointerCount}'),
              // onScaleUpdate: (details) => handlePan(details.localFocalPoint),
              // onPanUpdate: canvas?.selectMode == true
              //     ? (details) => handlePanUpdate(details.localPosition)
              //     : null,
              // onPanEnd: (details) =>
              //     handlePanUp(details.velocity.pixelsPerSecond),
              // onLongPress: canvas?.selectMode == false
              //     ? () {
              //         setState(() => toggleDrag = true);
              //       }
              //     : null,
              // onLongPressStart: canvas?.selectMode == false
              //     ? (details) {
              //         print('long press start');
              //         canvas?.setPanDownColor(details.localPosition);
              //       }
              //     : null,
              // onLongPressMoveUpdate: toggleDrag && canvas?.selectMode == false
              //     ? (details) {
              //         handlePan(details.localPosition);
              //       }
              //     : null,
              // onPanUpdate: toggleDrag && canvas?.selectMode == false
              //     ? (details) {
              //         handlePan(details.localPosition);
              //       }
              //     : null,
              // onLongPressEnd: (_) => setState(() => toggleDrag = false),
              onTapDown: (details) {
                print(details.kind);
                handleCanvasTap(details.localPosition);
              },
              // onTapUp: (details) => handleCanvasTap(details.localPosition),
              child: CustomPaint(
                size: Size(5000, 5000),
                painter: CanvasPainter(
                  service.currentScreen,
                  gridToggle: grid,
                  gridColor: service.gridLineColor,
                  gridLineWidth: service.gridLineWidth,
                  gridDimensions: service.gridDimensions,
                  cellSize: service.cellSize,
                  backgroundColor:
                      toggleDrag ? Color(0xFFc1dbc8) : Colors.white,
                  selectRect: canvas?.selectMode == true
                      ? Rect.fromPoints(panDownPos ?? Offset(0, 0),
                          panUpdatePos ?? Offset(0, 0))
                      : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  lockPressed() {
    setState(() {
      safetyLocked = !safetyLocked;
    });
  }

  toggleSelectMode() {
    if (canvas?.selectMode != null) canvas!.setSelectMode(!canvas!.selectMode);
  }

  undoPressed() {
    canvas?.undoPressed();
  }

  redoPressed() {
    canvas?.redoPressed();
  }

  List<Widget> _buildButtons(bool grid, BuildContext context) {
    return [
      // Column(
      //   children: [
      //     ElevatedButton(
      //       onPressed: undoPressed,
      //       child: Icon(Icons.undo),
      //       style: ButtonStyle(
      //         minimumSize:
      //             MaterialStateProperty.resolveWith((states) => Size(8, 8)),
      //         backgroundColor: canvas?.canUndo == true
      //             ? MaterialStateProperty.resolveWith((states) => Colors.red)
      //             : null,
      //       ),
      //     ),
      //     ElevatedButton(
      //       onPressed: redoPressed,
      //       child: Icon(Icons.redo),
      //       style: ButtonStyle(
      //         minimumSize:
      //             MaterialStateProperty.resolveWith((states) => Size(8, 8)),
      //         backgroundColor: canvas?.canRedo == true
      //             ? MaterialStateProperty.resolveWith((states) => Colors.blue)
      //             : null,
      //       ),\

      //     ),
      //   ],
      // ),
      ElevatedButton(
        onPressed: toggleSelectMode,
        child: Icon(Icons.select_all),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) =>
              canvas?.selectMode == false ? Colors.grey : Colors.purple),
          minimumSize: MaterialStateProperty.resolveWith(
            (states) => Size(8, 8),
          ),
        ),
      ),
      Card(
        child: IntrinsicWidth(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.resolveWith(
                          (states) => Size(8, 8)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => safetyLocked
                              ? Colors.blueGrey
                              : Colors.transparent)),
                  onPressed: lockPressed,
                  child: Icon(Icons.lock),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.resolveWith(
                        (states) => Size(8, 8)),
                    backgroundColor: !safetyLocked
                        ? MaterialStateProperty.resolveWith(
                            (states) => Colors.red)
                        : null,
                  ),
                  onPressed: !safetyLocked ? clearCanvasPressed : null,
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
      ElevatedButton(
        style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.resolveWith((states) => Size(8, 8)),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => grid ? Colors.white10 : Colors.lightBlue)),
        onPressed: toggleGrid,
        child: Icon(Icons.grid_4x4),
      ),
      ElevatedButton(
        style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.resolveWith((states) => Size(8, 8)),
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.green)),
        onPressed: playPressed,
        child: Icon(Icons.play_arrow),
      ),
    ];
  }

  Drawer buildDrawer(
    bool saveOnEachChange,
    bool showPreviousFrame,
    bool grid,
  ) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Row(
              children: [
                Switch(
                  value: saveOnEachChange,
                  onChanged: (_) => saveOnChangeToggle(),
                ),
                Text('Save On Change'),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Switch(
                  value: showPreviousFrame,
                  onChanged: (_) => toggleShowPreviousFrame(),
                ),
                Text('Show Previous Frame'),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Switch(
                  value: grid,
                  onChanged: (_) => toggleGrid(),
                ),
                Text('Toggle Grid'),
              ],
            ),
          ),
          ListTile(
            title: Text('Clear Animation'),
            leading: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.red)),
              onPressed: clearAnimationPressed,
              child: Icon(Icons.delete_forever),
            ),
          )
        ],
      ),
    );
  }
}
