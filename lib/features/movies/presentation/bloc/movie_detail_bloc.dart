import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/use_cases/GetMovieDetails.dart';
import '../../domain/use_cases/GetSuggestedMovies.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetails getMovieDetails;
  final GetSuggestedMovies getSuggestedMovies;


  MovieDetailBloc({required this.getMovieDetails, required this.getSuggestedMovies}) : super(MovieDetailInitial()) {
    on<LoadMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final results = await Future.wait([
          getMovieDetails(event.movieId),
          getSuggestedMovies(event.movieId), // You'll need to inject this use case too
        ]);
        emit(MovieDetailLoaded(
            results[0] as MovieDetails,
            results[1] as List<Movie>
        ));
      } catch (e) {
        emit(MovieDetailError(e.toString()));
      }
    });

  }
}
