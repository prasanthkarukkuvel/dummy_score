part of 'recent_games_bloc.dart';

abstract class RecentGamesEvent extends Equatable {
  const RecentGamesEvent();

  @override
  List<Object> get props => [];
}

class RecentGamesLoad extends RecentGamesEvent {}
