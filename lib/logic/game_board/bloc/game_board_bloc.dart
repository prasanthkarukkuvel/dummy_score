import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_board_event.dart';
part 'game_board_state.dart';

class GameBoardBloc extends Bloc<GameBoardEvent, GameBoardState> {
  GameBoardBloc() : super(const GameBoardState.initial());

  @override
  Stream<GameBoardState> mapEventToState(
    GameBoardEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
