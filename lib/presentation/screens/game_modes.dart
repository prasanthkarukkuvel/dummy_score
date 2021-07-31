import 'package:dummy_score/presentation/layouts/comfort_layout.dart';
import 'package:dummy_score/presentation/router/router_config.dart';
import 'package:dummy_score/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'new_players.dart';

class GameModes extends StatelessWidget {
  const GameModes({Key? key}) : super(key: key);

  ListTile Function(String, String, void Function()?) tileCreator(
    TextTheme textTheme,
  ) {
    return (String title, String subtitle, void Function()? onTap) => ListTile(
          leading: const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(MdiIcons.cardsPlayingOutline,
                  color: AppTheme.primaryColor)),
          visualDensity: const VisualDensity(vertical: 2.5),
          title: Text(
            title,
            style: textTheme.headline6,
          ),
          subtitle: Text(subtitle),
          trailing: const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 32,
              )),
          onTap: onTap,
        );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var createTile = tileCreator(textTheme);

    toNewPlayers(String mode) {
      Navigator.pushNamed(context, RouteNames.NewPlayers,
          arguments: NewPlayersScreenArgs(gameMode: mode));
    }

    return ComfortLayout(title: 'Game Mode', children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 72, 8, 8),
        child: Column(
          children: <Widget>[
            createTile("Open Joker", "Full points, if no rummy on close",
                () => toNewPlayers("open-joker")),
            createTile("Closed Joker", "Full points, if no rummy on close",
                () => toNewPlayers("close-joker")),
            createTile("Custom Mode", "Create your own game",
                () => toNewPlayers("custom"))
          ],
        ),
      ),
    ]);
  }
}
