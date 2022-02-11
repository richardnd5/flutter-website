import 'package:flutter/material.dart';
import 'package:flutter_website/polarPlay/pendulum_view_model.dart';
import 'package:flutter_website/polarPlay/polar_play_view_model.dart';
import 'package:flutter_website/views/helpers/page_gradient.dart';
import 'package:provider/provider.dart';

class PolarPlayPage extends StatelessWidget {
  const PolarPlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PolarPlayViewModel(size)),
        ChangeNotifierProvider(create: (context) => PendulumViewModel(size)),
      ],
      builder: (context, builder) {
        var vm = Provider.of<PendulumViewModel>(context, listen: false);
        return Scaffold(
          body: Container(
            decoration: pageGradient(Colors.purple, Colors.pink),
            child: Stack(
              children: [
                CustomPaint(
                  size: size,
                  painter: PolarPlayPainter(
                    vm: context.watch<PendulumViewModel>(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 64),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: vm.running
                              ? Provider.of<PendulumViewModel>(context,
                                      listen: false)
                                  .stopTimer
                              : Provider.of<PendulumViewModel>(context,
                                      listen: false)
                                  .startTimer,
                          style: ElevatedButton.styleFrom(
                              primary: vm.running ? Colors.red : Colors.green),
                          child: Text(vm.running ? 'Stop' : 'Start'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PolarPlayPainter extends CustomPainter {
  PolarPlayPainter({
    // required this.screenSize,
    required this.vm,
    Key? key,
  });

  // final Size screenSize;
  final PendulumViewModel vm;

  Paint blue = Paint()..color = Colors.blue;
  Paint black = Paint()
    ..color = Colors.black
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
// hypo = length
    canvas.drawLine(vm.origin, vm.bob, black);
    drawBob(canvas, vm.bob, vm.bobRadius);
  }

  void drawBob(Canvas canvas, Offset bob, double bobRadius) {
    canvas.drawCircle(
        bob,
        bobRadius,
        (Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill));
    canvas.drawCircle(
      bob,
      bobRadius,
      (black..style = PaintingStyle.stroke),
    );
  }

  drawGraph(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      black,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      black,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
