import 'package:flutter/material.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';
import 'package:flutter_website/views/components/inner_page_container.dart';
import 'package:provider/src/provider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final pageType = PageType.about;

  @override
  Widget build(BuildContext context) {
    return InnerPageContainer(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            // if (context.watch<HomePageViewModel>().selectedPage ==
            //     PageType.about)
            FadeInOnInitWidget(
              child: Text(
                'Welcome! This website is an experiment with new navigation patterns for the web. It is built in Flutter.',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              isVisible: context.watch<HomePageViewModel>().selectedPage ==
                  PageType.about,
            ),
          ],
        ),
      ),
    );
  }
}

class FadeInOnInitWidget extends StatefulWidget {
  const FadeInOnInitWidget({
    Key? key,
    required this.child,
    required this.isVisible,
    this.duration,
  }) : super(key: key);
  final Widget child;

  final bool isVisible;
  final Duration? duration;
  @override
  State<FadeInOnInitWidget> createState() => _FadeInOnInitWidgetState();
}

class _FadeInOnInitWidgetState extends State<FadeInOnInitWidget> {
  bool hasInit = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(
          milliseconds: HomePageViewModel.animDuration.inMilliseconds));
      setState(() {
        hasInit = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: Curves.easeInOut,
      opacity: hasInit
          ? widget.isVisible
              ? 1.0
              : 0.0
          : 0.0,
      duration: widget.duration ??
          Duration(milliseconds: widget.isVisible ? 500 : 200),
      child: widget.child,
    );
  }
}
