import 'package:dummy_score/logic/recent_games/bloc/recent_games_bloc.dart';
import 'package:dummy_score/presentation/layouts/comfort_layout.dart';
import 'package:dummy_score/presentation/router/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final providers = [
  BlocProvider<RecentGamesBloc>(
    create: (BuildContext context) => RecentGamesBloc(),
    lazy: true,
  )
];

class BoardHome extends StatelessWidget {
  const BoardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComfortLayout(title: 'Dummy Score', children: <Widget>[
      Container(
          padding: const EdgeInsets.fromLTRB(8, 72, 8, 8),
          child: Center(
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.gameModes),
              child: const Text('START NEW GAME'),
            ),
          )),
      BlocProvider(
          create: (context) => RecentGamesBloc()..add(RecentGamesLoad()),
          child: Builder(
            builder: (context) => createRecentGames(context),
          ))
    ]);
  }

  Widget createRecentGames(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<RecentGamesBloc>(context),
      builder: (context, RecentGamesState state) {
        switch (state.status) {
          case RecentGamesStatus.failure:
            return const Center(child: Text('Oops something went wrong!'));
          case RecentGamesStatus.success:
            return const Center(child: Text('Loaded'));
          case RecentGamesStatus.noData:
            return const Center(child: Text('No data'));
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
