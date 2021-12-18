import 'package:flutter/material.dart';
import 'package:flutter_website/app.dart';
import 'package:flutter_website/providers/app_providers.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: appProviders,
      child: const App(),
    ),
  );
}
