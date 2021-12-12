import 'package:flutter/material.dart';

class ExpandingPageContainer extends StatefulWidget {
  const ExpandingPageContainer({
    Key? key,
    required this.startOffset,
    this.startSize = const Size(0, 0),
    this.child,
    required this.shrinkFinished,
    required this.animateFinished,
    required this.color,
    required this.width,
  }) : super(key: key);

  final Offset startOffset;
  final Size startSize;
  final Widget? child;
  final VoidCallback shrinkFinished;
  final VoidCallback animateFinished;
  final Color color;
  final double width;

  @override
  _ExpandingPageContainerState createState() => _ExpandingPageContainerState();
}

class _ExpandingPageContainerState extends State<ExpandingPageContainer>
    with TickerProviderStateMixin {
  bool initialLoad = false;

  double height = 0;
  double width = 0;

  late AnimationController controller;
  late Animation anim;
  bool showBackButton = false;

  Duration duration = const Duration(milliseconds: 600);
  Curve curve = Curves.elasticOut;

  bool isAnimating = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    anim = Tween<Offset>(
        begin: const Offset(0, 0),
        end: Offset(
          widget.startOffset.dx,
          widget.startOffset.dy,
        )).animate(controller)
      ..addListener(() async {
        if (controller.status == AnimationStatus.dismissed) {
          widget.shrinkFinished();
        }
        if (controller.status == AnimationStatus.completed) {
          setState(() {
            isAnimating = false;
            widget.animateFinished();
          });
          // await Future.delayed(const Duration(milliseconds: 0));
          // setState(() {
          //   showBackButton = true;
          // });
        }
      });
    controller.forward();
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var size = MediaQuery.of(context).size;
      setState(() {
        initialLoad = true;
        height = size.height;
        width = size.width;
        showBackButton = true;
        isAnimating = true;
      });
    });
  }

  shrink() {
    controller.reverse();
    setState(() {
      initialLoad = false;
      showBackButton = false;
      height = widget.startSize.height;
      width = widget.startSize.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: widget.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            curve: curve,
            duration: duration,
            top: !initialLoad ? widget.startOffset.dy : 0,
            left: !initialLoad ? widget.startOffset.dx : 0,
            child: AnimatedContainer(
              curve: curve,
              duration: duration,
              width: !initialLoad ? widget.startSize.width : width,
              height: !initialLoad ? widget.startSize.height : height,
              color: widget.color,
              child: Stack(
                children: [
                  AnimatedOpacity(
                    duration: duration,
                    opacity: showBackButton ? 1 : 0,
                    child: widget.child,
                  ),
                  GestureDetector(
                    onTap: isAnimating ? null : shrink,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 50),
                      opacity: showBackButton ? 1 : 0,
                      child: const SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 32,
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
      ),
    );
  }
}
