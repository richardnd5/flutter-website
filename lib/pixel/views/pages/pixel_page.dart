import 'package:flutter/material.dart';
import 'package:flutter_website/pixel/services/canvas_service.dart';
import 'package:flutter_website/pixel/views/components/two_finger_interactive_viewer.dart'
    as viewer;
import 'package:flutter_website/pixel/views/functions/show_snack_bar.dart';
import 'package:flutter_website/pixel/views/pages/components/pixel_button.dart';
import 'package:flutter_website/pixel/views/pages/components/pixel_drawer.dart';
import 'package:provider/provider.dart';

import '../components/my_painter.dart';

class PixelPage extends StatefulWidget {
  const PixelPage({Key? key}) : super(key: key);

  @override
  _PixelPageState createState() => _PixelPageState();
}

class _PixelPageState extends State<PixelPage> {
  late CanvasService canvas;

  viewer.TransformationController transformController =
      viewer.TransformationController();

  @override
  void initState() {
    transformController.addListener(() {});

    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      canvas.startCanvasService(
        CanvasService.globalCanvasSize,
        MediaQuery.of(context).size,
      );
    });
  }

  @override
  void dispose() {
    transformController.dispose();
    super.dispose();
  }

  _handleNewFramePressed() {
    ScaffoldMessenger.of(context).clearSnackBars();

    canvas.saveAndIncrement();
    if (canvas.showPreviousFrame == true) {
      canvas.clearCanvas();
      canvas.loadBlankCanvas();
      canvas.drawPreviousCanvas();
    }
  }

  playPressed() {
    ScaffoldMessenger.of(context).clearSnackBars();
    canvas.playAnimation();
  }

  clearAnimationPressed() {
    ScaffoldMessenger.of(context).clearSnackBars();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Are you sure you want to clear the animation?'),
        actions: [
          TextButton(
            child: const Text('No'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              canvas.clearAnimation();
              showSnackBar(context, 'Animation Cleared');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  clearCanvasPressed() {
    canvas.safetyLocked = true;
    ScaffoldMessenger.of(context).clearSnackBars();
    canvas.resetCanvasToScreenDimensions(
      canvas.gridDimensions,
      canvas.screenSize,
    );
  }

  handleCanvasTap(Offset localPosition) {
    canvas.safetyLocked = true;
    canvas.checkTapPosition(localPosition);
  }

  handleStart(ScaleStartDetails details) {
    canvas.getCellOnOrNot(details.localFocalPoint);
  }

  handleUpdate(ScaleUpdateDetails details) {
    if (details.pointerCount == 1) {
      var newOffset =
          Offset(details.localFocalPoint.dx, details.localFocalPoint.dy);
      canvas.checkTapPosition(newOffset, isDrag: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    canvas = Provider.of<CanvasService>(context, listen: false);
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          drawerEnableOpenDragGesture: false,
          drawer: const PixelDrawer(),
          appBar: AppBar(),
          floatingActionButton: _buildFloatingActionSection(),
          persistentFooterButtons: [
            _buildClearComponent(),
            _buildToggleGridButton(),
            _buildPlayButton(),
          ],
          body: _buildCanvas(),
        ),
      ),
    );
  }

  Widget _buildCanvas() {
    return viewer.TwoFingerInteractiveViewer(
      transformationController: transformController,
      onInteractionStart: handleStart,
      onInteractionUpdate: handleUpdate,
      onInteractionEnd: (details) => canvas.setDragToNull(),
      maxScale: 1,
      child: GestureDetector(
        onTapUp: (details) => handleCanvasTap(details.localPosition),
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: CanvasPainter(canvas),
        ),
      ),
    );
  }

  Row _buildFloatingActionSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 32),
        _buildBackButton(),
        const SizedBox(width: 8),
        _buildForwardButton(),
        const Spacer(),
        _buildNewFrameButton(),
      ],
    );
  }

  Widget _buildClearComponent() {
    return Card(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              _buildLockButton(),
              const SizedBox(width: 8),
              _buildClearButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewFrameButton() {
    var canvasSaved = context.watch<CanvasService>().canvasSaved;
    return PixelButton(
      minSize: const Size(100, 42),
      onPressed: canvasSaved ? null : _handleNewFramePressed,
      child: const Icon(Icons.create_rounded),
    );
  }

  Widget _buildForwardButton() {
    var service = context.watch<CanvasService>();
    return PixelButton(
      backgroundColor: service.lastIndex ? null : Colors.blue,
      onPressed: service.lastIndex ? null : () => canvas.goForwardAFrame(),
      child: const Icon(Icons.arrow_right_rounded),
    );
  }

  Widget _buildBackButton() {
    return PixelButton(
      backgroundColor: canvas.firstIndex ? null : Colors.blue,
      onPressed: canvas.firstIndex ? null : () => canvas.goBackAFrame(),
      child: const Icon(Icons.arrow_left_rounded),
    );
  }

  Widget _buildLockButton() {
    return PixelButton(
      backgroundColor:
          canvas.safetyLocked ? Colors.blueGrey : Colors.transparent,
      onPressed: () => canvas.safetyLocked = !canvas.safetyLocked,
      child: const Icon(Icons.lock),
    );
  }

  Widget _buildClearButton() {
    return PixelButton(
      backgroundColor: !canvas.safetyLocked ? Colors.red : null,
      onPressed: !canvas.safetyLocked ? clearCanvasPressed : null,
      child: const Icon(Icons.delete),
    );
  }

  Widget _buildPlayButton() {
    return PixelButton(
      backgroundColor: Colors.green,
      onPressed: playPressed,
      child: const Icon(Icons.play_arrow),
    );
  }

  Widget _buildToggleGridButton() {
    return PixelButton(
      backgroundColor:
          context.watch<CanvasService>().grid ? Colors.white : Colors.lightBlue,
      onPressed: canvas.toggleGrid,
      child: Icon(
        Icons.grid_4x4,
        color: context.watch<CanvasService>().grid
            ? Colors.lightBlue
            : Colors.white,
      ),
    );
  }
}
