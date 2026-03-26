import '../../domain/entities/movie_entity.dart';

abstract class MovieSearchState {}

class SearchInitial extends MovieSearchState {}

class SearchLoading extends MovieSearchState {}

class SearchLoaded extends MovieSearchState {
  final List<MovieSearchEntity> movies;
  SearchLoaded(this.movies);
}

class SearchError extends MovieSearchState {
  final String message;
  SearchError(this.message);
}