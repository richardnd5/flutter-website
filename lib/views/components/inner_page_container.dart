import 'package:flutter/material.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';

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
    return Container(
      child: widget.child,
    );
  }
}
