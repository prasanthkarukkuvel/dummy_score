part of 'game_board_bloc.dart';

enum GameBoardStatus { initial, ready, empty, failed }

class GameBoardState extends Equatable {
  const GameBoardState._({this.status = GameBoardStatus.initial});

  const GameBoardState.initial() : this._();

  const GameBoardState.ready() : this._(status: GameBoardStatus.ready);

  const GameBoardState.empty() : this._(status: GameBoardStatus.empty);

  const GameBoardState.failed() : this._(status: GameBoardStatus.failed);

  final GameBoardStatus status;

  @override
  List<dynamic> get props => [status];
}
