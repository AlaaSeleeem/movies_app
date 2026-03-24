import 'package:equatable/equatable.dart';

import '../../../movies/domain/entities/movie.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteStatusLoaded extends FavoriteState {
  final bool isFavorite;

  FavoriteStatusLoaded(this.isFavorite);

  @override
  List<Object?> get props => [isFavorite];
}

class FavoritesLoaded extends FavoriteState {
  final List<Movie> movies;

  FavoritesLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}