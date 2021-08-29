import 'package:dummy_score/presentation/router/router_config.dart';
import 'package:dummy_score/presentation/screens/board_game.dart';
import 'package:dummy_score/presentation/screens/game_modes.dart';
import 'package:dummy_score/presentation/screens/new_players.dart';
import 'package:dummy_score/presentation/screens/player_selection.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.board:
        return buildRoute((_) => const BoardHome(key: Key("BoardHome")));
      case RouteNames.gameModes:
        return buildRoute((_) => const GameModes(key: Key("GameModes")));
      case RouteNames.newPlayers:
        return buildRoute((_) => NewPlayers(
              screenArgs:
                  NewPlayersScreenArgs.fromArguments(settings.arguments),
            ));
      case RouteNames.playerSelection:
        return buildRoute((_) => PlayerSelection());
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
