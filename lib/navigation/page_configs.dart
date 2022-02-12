import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/gameOfLife/views/pages/game_of_life_page.dart';
import 'package:flutter_website/navigation/fade_page.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/pixel/views/pages/pixel_page.dart';
import 'package:flutter_website/polarPlay/polar_play_page.dart';
import 'package:flutter_website/ticTacToe/ui/tic_tac_toe_page.dart';
import 'package:flutter_website/views/pages/about/about_page.dart';
import 'package:flutter_website/views/pages/coding/coding_page.dart';
import 'package:flutter_website/views/pages/contact/contact_page.dart';
import 'package:flutter_website/views/pages/home/home_page.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';
import 'package:flutter_website/views/pages/music/music_page.dart';

final homePageConfig = PageConfig(
  path: '/',
  page: const FadeTransitionPage(
    child: HomePage(),
  ),
);
final musicPageConfig = PageConfig(
  path: '/music',
  page: const FadeTransitionPage(
    child: MusicPage(),
  ),
);
final contactPageConfig = PageConfig(
  path: '/contact',
  page: const FadeTransitionPage(
    child: ContactPage(),
  ),
);
final codingPageConfig = PageConfig(
  path: '/coding',
  page: const FadeTransitionPage(
    child: CodingPage(),
  ),
);
final aboutPageConfig = PageConfig(
  path: '/about',
  page: const FadeTransitionPage(
    child: AboutPage(),
  ),
);
final pixelPageConfig = PageConfig(
  path: '/pixel',
  page: const FadeTransitionPage(
    child: PixelPage(),
  ),
);
final gameOfLifePageConfig = PageConfig(
  path: '/gameOfLife',
  page: const FadeTransitionPage(
    child: GameOfLifePage(),
  ),
);
final ticTacToePageConfig = PageConfig(
  path: '/ticTicToe',
  page: const FadeTransitionPage(
    child: TicTacToePage(),
  ),
);
final pendulumPageConfig = PageConfig(
  path: '/pendulum',
  page: const FadeTransitionPage(
    child: PolarPlayPage(),
  ),
);
final unknownPageConfig = PageConfig(
  path: '/404',
  page: const FadeTransitionPage(
    child: Scaffold(
      body: Text('Unknown!'),
    ),
  ),
);

class PageConfig {
  String path;
  Page page;

  PageConfig({
    required this.path,
    required this.page,
  });
}

SynchronousFuture<PageConfig> setPageConfig(
    HomePageViewModel vm, NavState state, RouteInformation routeInformation) {
  Uri? uri = Uri.tryParse(routeInformation.location ?? '');
  if (uri?.pathSegments.isEmpty == true) {
    if (vm.selectedPage != null) {
      vm.selectedPage = null;
    }
    return SynchronousFuture(homePageConfig);
  }
  if (uri?.pathSegments.length == 1) {
    // state.pop();

    if (uri?.pathSegments[0].contains('pixel') == true) {
      state.selectedPage = CustomPages.pixel;
      return SynchronousFuture(pixelPageConfig);
    }
    if (uri?.pathSegments[0].contains('gameOfLife') == true) {
      state.selectedPage = CustomPages.gameOfLife;
      return SynchronousFuture(gameOfLifePageConfig);
    }
    if (uri?.pathSegments[0].contains('music') == true) {
      vm.selectedPage = PageType.music;
      return SynchronousFuture(musicPageConfig);
    }
    if (uri?.pathSegments[0].contains('contact') == true) {
      vm.selectedPage = PageType.contact;
      return SynchronousFuture(contactPageConfig);
    }
    if (uri?.pathSegments[0].contains('coding') == true) {
      vm.selectedPage = PageType.coding;
      return SynchronousFuture(codingPageConfig);
    }
    if (uri?.pathSegments[0].contains('about') == true) {
      vm.selectedPage = PageType.about;
      return SynchronousFuture(aboutPageConfig);
    }
  }
  return SynchronousFuture(unknownPageConfig);
}
