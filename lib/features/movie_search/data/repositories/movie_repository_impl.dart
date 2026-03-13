import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  @override
  Future<List<MovieEntity>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('https://yts.mx/api/v2/list_movies.json?query_term=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List moviesJson = data['data']['movies'] ?? [];
      return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
