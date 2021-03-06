import 'package:flutter_website/gameOfLife/services/game_of_life_service.dart';
import 'package:flutter_website/navigation/nav_route_parser.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/pixel/services/canvas_service.dart';
import 'package:flutter_website/pixel/services/sound_service.dart';
import 'package:flutter_website/ticTacToe/service/tic_tac_toe_service.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';
import 'package:provider/provider.dart';

final appProviders = [
  ChangeNotifierProvider(
    create: (context) => NavState(),
    lazy: false,
  ),
  ChangeNotifierProvider(
    create: (context) => HomePageViewModel(
      Provider.of<NavState>(context, listen: false),
    ),
    lazy: false,
  ),
  ChangeNotifierProxyProvider<NavState, NavRouterDelegate>(
    create: (context) => NavRouterDelegate(
      Provider.of<NavState>(context, listen: false),
    ),
    update: (context, state, delegate) {
      delegate!.state = state;
      return delegate;
    },
  ),
  ProxyProvider2<NavState, HomePageViewModel, NavRouteParser>(
    create: (context) => NavRouteParser(
      Provider.of<NavState>(context, listen: false),
      Provider.of<HomePageViewModel>(context, listen: false),
    ),
    update: (context, state, vm, parser) {
      parser!.state = state;
      return parser;
    },
  ),
  ChangeNotifierProvider(create: (_) => SoundService()),
  ChangeNotifierProvider(create: (_) => CanvasService()),
  ChangeNotifierProvider(
    create: (context) => GameOfLifeService(),
    lazy: false,
  ),
  ChangeNotifierProvider(create: (_) => TicTacToeService()),
];
