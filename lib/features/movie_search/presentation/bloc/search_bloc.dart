import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/movie_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final MovieSearchRepository repository;

  MovieSearchBloc(this.repository) : super(SearchInitial()) {
on<OnQueryChanged>((event, emit) async {
  if (event.query.trim().isEmpty) {
    emit(SearchInitial()); 
    return;
  }

  emit(SearchLoading()); 

  try {
    final movies = await repository.searchMovies(event.query);
    if (movies.isEmpty) {
      emit(SearchError("No movies found for '${event.query}'"));
    } else {
      emit(SearchLoaded(movies)); 
    }
  } catch (e) {
    emit(SearchError("Please check your internet connection"));
      }
    });
  }
}