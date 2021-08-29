import 'package:dummy_score/presentation/layouts/comfort_layout.dart';
import 'package:dummy_score/presentation/router/router_config.dart';
import 'package:flutter/material.dart';

class BoardHome extends StatelessWidget {
  const BoardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComfortLayout(title: 'Dummy Score', children: <Widget>[
      Padding(
          padding: const EdgeInsets.fromLTRB(8, 72, 8, 8),
          child: Center(
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.gameModes),
              child: const Text('START NEW GAME'),
            ),
          )),
    ]);
  }
}
