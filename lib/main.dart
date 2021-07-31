import 'package:dummy_score/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'presentation/router/app_router.dart';
import 'presentation/screens/board_game.dart';

void main() {
  runApp(MyApp(
    router: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  MyApp({required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dummy Score',
      theme: AppTheme.darkTheme,
      home: BoardHome(),
      onGenerateRoute: (settings) => router.generateRoute(settings),
    );
  }
}
