part of 'recent_games_bloc.dart';

enum RecentGamesStatus { loading, success, failure, noData }

class RecentGamesState extends Equatable {
  const RecentGamesState._({this.status = RecentGamesStatus.loading});

  const RecentGamesState.loading() : this._();

  const RecentGamesState.success() : this._(status: RecentGamesStatus.success);

  const RecentGamesState.noData() : this._(status: RecentGamesStatus.noData);

  const RecentGamesState.failure() : this._(status: RecentGamesStatus.failure);

  final RecentGamesStatus status;

  @override
  List<dynamic> get props => [status];
}
