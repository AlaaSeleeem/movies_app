import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';

// Events
abstract class SearchEvent {}

class OnQueryChanged extends SearchEvent {
  final String query;
  OnQueryChanged(this.query);
}

// States
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<MovieEntity> movies;
  SearchLoaded(this.movies);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<OnQueryChanged>((event, emit) async {
      if (event.query.isEmpty) {
        emit(SearchInitial());
        return;
      }
      emit(SearchLoading());
      try {
        final movies = await repository.searchMovies(event.query);
        emit(SearchLoaded(movies));
      } catch (e) {
        emit(SearchError("Check your internet connection"));
      }
    });
  }
}
