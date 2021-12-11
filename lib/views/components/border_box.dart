import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum BorderBoxState { pressed, unpressed }

class BorderBox extends StatefulWidget {
  const BorderBox(
    this.child, {
    Key? key,
    this.size = const Size(100, 100),
    this.onEnter,
    this.onExit,
    this.onTapDown,
    this.onTapUp,
  }) : super(key: key);

  final Size size;
  final Widget child;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  final Function(TapDownDetails)? onTapDown;
  final Function(TapUpDetails)? onTapUp;

  @override
  _BorderBoxState createState() => _BorderBoxState();
}

class _BorderBoxState extends State<BorderBox> {
  final Color startingColor = Color(0xFF27d66a);
  Color color = Colors.white;
  Color color2 = Color(0xFF41575e);

  BorderBoxState state = BorderBoxState.unpressed;
  @override
  void initState() {
    super.initState();
    color = startingColor;
  }

  onTapDown(TapDownDetails details) {
    setState(() {
      state = BorderBoxState.pressed;
    });
    if (widget.onTapDown != null) {
      widget.onTapDown!(details);
    }
  }

  onTapUp(TapUpDetails details) {
    setState(() {
      state = BorderBoxState.unpressed;
    });
    if (widget.onTapUp != null) {
      widget.onTapUp!(details);
    }
  }

  onEnterEvent(PointerEnterEvent event) {
    setState(() {
      color = Color(0xFF45ded1);
      color2 = Colors.black;
    });
    if (widget.onEnter != null) {
      widget.onEnter!(event);
    }
  }

  onExitEvent(PointerExitEvent event) {
    setState(() {
      color = startingColor;
      color2 = Color(0xFF41575e);
    });
    if (widget.onExit != null) {
      widget.onExit!(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        onPanUpdate: (_) => setState(() {
          state = BorderBoxState.unpressed;
        }),
        child: MouseRegion(
          onEnter: onEnterEvent,
          onExit: onExitEvent,
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              // curve: Curves.elasticOut,
              alignment: Alignment.center,
              width: state == BorderBoxState.pressed
                  ? widget.size.width - 24
                  : widget.size.width,
              height: state == BorderBoxState.pressed
                  ? widget.size.height - 24
                  : widget.size.height,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF656b6b),
                    offset: Offset(1, 1),
                    blurRadius: 7,
                    spreadRadius: 0,
                  )
                ],
                // color: color,
                border: Border.all(color: Colors.transparent),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  // radius: .3,
                  colors: [
                    color,
                    color2,
                  ],
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.size.width * 0.15)),
              ),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
