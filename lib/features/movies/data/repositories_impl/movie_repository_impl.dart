import 'package:movies_app/features/movies/data/data_source/movie_details_remote_data_source.dart';
import 'package:movies_app/features/movies/domain/entities/movie.dart';
import 'package:movies_app/features/movies/domain/entities/movie_details.dart';
import 'package:movies_app/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    return await remoteDataSource.getMovieDetails(movieId);
  }

  @override
  Future<List<Movie>> getSuggestedMovies(int movieId) async {
    return await remoteDataSource.getMovieSuggestions(movieId);
  }
}