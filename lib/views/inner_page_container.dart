import 'package:flutter/material.dart';
import 'package:flutter_website/views/home/home_page_view_model.dart';

class InnerPageContainer extends StatefulWidget {
  const InnerPageContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<InnerPageContainer> createState() => _InnerPageContainerState();
}

class _InnerPageContainerState extends State<InnerPageContainer> {
  bool initialLoad = false;

  @override
  void initState() {
    _setInitialLoadInFuture();
    super.initState();
  }

  _setInitialLoadInFuture() async {
    await Future.delayed(HomePageViewModel.animDuration);
    setState(() {
      initialLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: widget.child,
    );
    return AnimatedOpacity(
      duration: Duration(milliseconds: 400),
      opacity: initialLoad ? 1.0 : 0,
      child: Container(
        width: size.width,
        height: size.height,
        child: widget.child,
      ),
    );
  }
}
