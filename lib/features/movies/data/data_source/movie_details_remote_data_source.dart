import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_suggestion_model.dart';
import 'movie_detail_model.dart';

class MovieDetailsRemoteDataSource {
  final http.Client client;

  MovieDetailsRemoteDataSource({http.Client? client})
      : client = client ?? http.Client();

  // ── Get Movie Details ─────────────────────────────────────
  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    final url = Uri.parse(
      'https://yts.mx/api/v2/movie_details.json?movie_id=$movieId&with_cast=true&with_images=true',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MovieDetailModel.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  // ── Get Movie Suggestions ─────────────────────────────────
  Future<List<MovieSuggestionModel>> getMovieSuggestions(int movieId) async {
    final url = Uri.parse(
      'https://yts.mx/api/v2/movie_suggestions.json?movie_id=$movieId',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final movies = data['data']['movies'] as List? ?? [];
      return movies.map((m) => MovieSuggestionModel.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load movie suggestions');
    }
  }
}