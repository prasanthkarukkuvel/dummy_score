import 'package:dummy_score/data/app_database.dart';
import 'package:dummy_score/utils/uuid/uuid.dart';
import 'package:sembast/sembast.dart';
import 'models/game_board.dart';

class _GameBoardServiceFactory {
  static const String gameBoardStore = "dummy_score_game_board";

  final _store = stringMapStoreFactory.store(gameBoardStore);

  Future<GameBoard?> create() async {
    final gameBoard = GameBoard(
        id: uuidV4(), startTime: DateTime.now().millisecondsSinceEpoch);
    return AppDB.useTransaction((transaction) async => GameBoard.fromMap(
        await _store.record(gameBoard.id).put(transaction, gameBoard.toMap())));
  }

  Future<GameBoard?> get(String key) async =>
      AppDB.useGet(key, _store, GameBoard.fromMap);
}

// ignore: non_constant_identifier_names
final GameBoardService = _GameBoardServiceFactory();
