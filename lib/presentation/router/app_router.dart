import 'package:dummy_score/presentation/router/router_config.dart';
import 'package:dummy_score/presentation/screens/board_game.dart';
import 'package:dummy_score/presentation/screens/game_modes.dart';
import 'package:dummy_score/presentation/screens/new_players.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.Default:
        return buildRoute((_) => const BoardHome(key: Key("BoardHome")));
      case RouteNames.GameModes:
        return buildRoute((_) => const GameModes(key: Key("GameModes")));
      case RouteNames.NewPlayers:
        return buildRoute((_) => NewPlayers(
              screenArgs:
                  NewPlayersScreenArgs.fromArguments(settings.arguments),
            ));
      default:
        return buildRoute((_) => Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            ));
    }
  }

  MaterialPageRoute<dynamic> buildRoute(Widget Function(BuildContext) builder) {
    return MaterialPageRoute(builder: builder);
  }
}
