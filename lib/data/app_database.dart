import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDB {
  static final AppDB _singleton = AppDB._();
  static AppDB get instance => _singleton;
  Completer<Database>? _dbOpenCompleter;

  AppDB._();

  static Future<T?> useGet<T>(
      String key,
      StoreRef<String, Map<String, dynamic>> store,
      T Function(Map<String, dynamic> map) mapper) async {
    final db = await AppDB.instance.db;

    if (db != null) {
      final map = await store.record(key).get(db);

      if (map != null) {
        return mapper(map);
      }
    }

    return null;
  }

  static Future<T?> useTransaction<T>(
      Future<T?> Function(Transaction transaction) creator) async {
    return (await AppDB.instance.db)
        ?.transaction((transaction) async => creator(transaction));
  }

  Future<Database?> get db async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();

      _openDatabase();
    }

    return _dbOpenCompleter?.future;
  }

  Future<void> _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'dummy_score_game.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);

    _dbOpenCompleter?.complete(database);
  }
}
