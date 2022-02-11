enum GameBoardActionStatus { init, created, deleting, deleted }

class GameBoard {
  final String id;
  final int? startTime;
  final int? endTime;
  GameBoardActionStatus actionStatus;

  GameBoard(
      {required this.id,
      this.startTime,
      this.endTime,
      this.actionStatus = GameBoardActionStatus.init});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'actionStatus': actionStatus.index
    };
  }

  static GameBoard fromMap(Map<String, dynamic> map) {
    return GameBoard(
        id: map['id'] as String,
        startTime: map['startTime'] as int?,
        endTime: map['endTime'] as int?,
        actionStatus:
            GameBoardActionStatus.values[map['actionStatus'] as int? ?? 0]);
  }
}
