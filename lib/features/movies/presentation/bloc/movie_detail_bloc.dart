import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/GetMovieDetails.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetails getMovieDetails;

  MovieDetailBloc({required this.getMovieDetails}) : super(MovieDetailInitial()) {
    on<LoadMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final movie = await getMovieDetails(event.movieId);
        emit(MovieDetailLoaded(movie));
      } catch (e) {
        emit(MovieDetailError(e.toString()));
      }
    });
  }
}