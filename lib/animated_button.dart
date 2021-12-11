import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton(
    this.child, {
    Key? key,
    this.buttonDown,
    this.buttonUp,
    this.size,
  }) : super(key: key);

  final VoidCallback? buttonDown;
  final VoidCallback? buttonUp;
  final Size? size;
  final Widget child;

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  bool buttonDown = false;

  final double shrinkAmount = 0.4;

  late AnimationController controller1;
  late Animation anim;

  @override
  void initState() {
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
    );

    anim = Tween(begin: 1.0, end: 0.92).animate(controller1);

    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  handleButtonDown() async {
    if (mounted) {
      controller1.forward();
      setState(() => buttonDown = true);
      if (widget.buttonDown != null) {
        widget.buttonDown!();
      }
    }
  }

  handleButtonUp() async {
    if (mounted) {
      controller1.reverse();
      setState(() => buttonDown = false);
      if (widget.buttonUp != null) {
        widget.buttonUp!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = widget.size ?? MediaQuery.of(context).size;
    return GestureDetector(
      onTapDown: (details) => handleButtonDown(),
      onTapUp: (details) => handleButtonUp(),
      onTapCancel: () => controller1.reverse(),
      child: AnimatedBuilder(
        animation: anim,
        builder: (context, _) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: size.width,
            height: size.height,
            alignment: Alignment.center,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(anim.value),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
