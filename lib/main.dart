import 'package:flutter/material.dart';
import 'package:flutter_website/app.dart';
import 'package:flutter_website/providers/app_providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: appProviders,
      child: const App(),
    ),
  );
}
