import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recent_games_event.dart';
part 'recent_games_state.dart';

class RecentGamesBloc extends Bloc<RecentGamesEvent, RecentGamesState> {
  RecentGamesBloc() : super(const RecentGamesState.loading());

  @override
  Stream<RecentGamesState> mapEventToState(
    RecentGamesEvent event,
  ) async* {
    yield const RecentGamesState.loading();

    if (event is RecentGamesLoad) {
      yield const RecentGamesState.success();
    }
  }
}
