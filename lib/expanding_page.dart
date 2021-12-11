import 'package:flutter/material.dart';

class ExpandingPage extends StatefulWidget {
  const ExpandingPage({
    Key? key,
    required this.startOffset,
    required this.child,
    required this.shrinkFinished,
    required this.color,
  }) : super(key: key);

  final Offset startOffset;
  final Widget child;
  final VoidCallback shrinkFinished;
  final Color color;

  @override
  _ExpandingPageState createState() => _ExpandingPageState();
}

class _ExpandingPageState extends State<ExpandingPage>
    with TickerProviderStateMixin {
  bool initialLoad = false;

  double height = 0;

  late AnimationController controller;
  late Animation anim;
  bool showBackButton = false;

  Duration duration = Duration(milliseconds: 300);

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    anim = Tween<Offset>(
        begin: Offset(0, 0),
        end: Offset(
          0,
          widget.startOffset.dy,
        )).animate(controller)
      ..addListener(() async {
        if (controller.status == AnimationStatus.dismissed) {
          widget.shrinkFinished();
        }
        if (controller.status == AnimationStatus.completed) {
          await Future.delayed(Duration(milliseconds: 400));
          setState(() {
            showBackButton = true;
          });
        }
      });
    controller.forward();
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var size = MediaQuery.of(context).size;
      setState(() {
        initialLoad = true;
        height = size.height;
      });
    });
  }

  shrink() {
    print('shrink called');
    controller.reverse();
    setState(() {
      initialLoad = false;
      showBackButton = false;
      height = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ListView(
      // alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          duration: duration,
          top: !initialLoad ? widget.startOffset.dy : 0,
          left: 0,
          child: AnimatedContainer(
            duration: duration,
            width: size.width,
            height: height,
            color: widget.color,
            child: Stack(
              children: [
                AnimatedOpacity(
                  duration: duration,
                  opacity: showBackButton ? 1 : 0,
                  child: widget.child,
                ),
                GestureDetector(
                  onTap: shrink,
                  child: AnimatedOpacity(
                    duration: duration,
                    opacity: showBackButton ? 1 : 0,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
