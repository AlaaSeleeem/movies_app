import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class WatchlistUpdated extends ProfileState {
  final bool isInWatchlist;
  const WatchlistUpdated(this.isInWatchlist);

  @override
  List<Object> get props => [isInWatchlist];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}