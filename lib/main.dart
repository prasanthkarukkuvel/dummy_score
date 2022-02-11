import 'package:dummy_score/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'observers/simple_bloc_observer/simple_bloc_observer.dart';
import 'presentation/router/app_router.dart';
import 'presentation/screens/board_game.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(
    router: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dummy Score',
      theme: AppTheme.darkTheme,
      home: const BoardHome(),
      onGenerateRoute: (settings) => router.generateRoute(settings),
    );
  }
}
