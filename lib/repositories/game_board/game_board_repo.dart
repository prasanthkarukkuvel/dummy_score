import 'package:dummy_score/services/game_board/game_board_service.dart';
import 'package:dummy_score/services/game_board/models/game_board.dart';

class _GameBoardRepoFactory {
  Future<GameBoard?> createGame(List<String> players) async {
    final gameBoard = await GameBoardService.create();

    return gameBoard;
  }
}

// ignore: non_constant_identifier_names
final GameBoardRepo = _GameBoardRepoFactory();
