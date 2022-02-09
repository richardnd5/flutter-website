import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/views/helpers/page_gradient.dart';
import 'package:flutter_website/views/constants/static_colors.dart';
import 'package:flutter_website/views/pages/about/about_page.dart';
import 'package:flutter_website/views/pages/home/components/home_page_expanding_cell.dart';
import 'package:provider/provider.dart';
import 'home_page_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<HomePageViewModel>(context, listen: false).init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInOnInitWidget(
      isVisible: true,
      child: Stack(
        children: [
          _buildBackground(context),
          const HomePageExpandingCell(PageType.about),
          const HomePageExpandingCell(PageType.contact),
          const HomePageExpandingCell(PageType.music),
          const HomePageExpandingCell(PageType.coding),
        ],
      ),
    );
  }

  GestureDetector _buildBackground(BuildContext context) {
    Color topColor =
        context.watch<HomePageViewModel>().selectedPage?.getPageColor() ??
            AppColors.bgTopGradient;

    return GestureDetector(
      onTap: () {
        Provider.of<HomePageViewModel>(context, listen: false).selectedPage =
            null;
        Provider.of<NavState>(context, listen: false).goTo(homePageConfig);
      },
      child: AnimatedContainer(
        duration: HomePageViewModel.animDuration,
        curve: HomePageViewModel.curve,
        decoration: pageGradient(
          topColor.withAlpha(150),
          AppColors.bgBottomGradient,
        ),
      ),
    );
  }
}
