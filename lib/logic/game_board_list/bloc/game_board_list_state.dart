part of 'game_board_list_bloc.dart';

abstract class GameBoardListState extends Equatable {
  const GameBoardListState();
  
  @override
  List<Object> get props => [];
}

class GameBoardListInitial extends GameBoardListState {}
