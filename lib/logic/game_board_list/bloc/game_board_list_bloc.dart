import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_board_list_event.dart';
part 'game_board_list_state.dart';

class GameBoardListBloc extends Bloc<GameBoardListEvent, GameBoardListState> {
  GameBoardListBloc() : super(GameBoardListInitial());

  @override
  Stream<GameBoardListState> mapEventToState(
    GameBoardListEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
