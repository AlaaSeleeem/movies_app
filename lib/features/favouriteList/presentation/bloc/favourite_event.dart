import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckFavoriteStatusEvent extends FavoriteEvent {
  final int movieId;

  CheckFavoriteStatusEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class AddFavoriteEvent extends FavoriteEvent {
  final int movieId;

  AddFavoriteEvent(this.movieId);
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final int movieId;

  RemoveFavoriteEvent(this.movieId);
}

class GetAllFavoritesEvent extends FavoriteEvent {}