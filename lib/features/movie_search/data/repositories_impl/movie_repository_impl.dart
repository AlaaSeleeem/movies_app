import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../models/movie_model.dart';

class MovieSearchRepositoryImpl implements MovieSearchRepository {
  static const String _baseUrl = "https://movies-api.accel.li/api/v2/list_movies.json";

  @override
  Future<List<MovieSearchEntity>> searchMovies(String query) async {
    final Uri url = Uri.parse("$_baseUrl?query_term=$query");
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        
        if (body['status'] == 'ok' && body['data']['movies'] != null) {
          final List moviesJson = body['data']['movies'];
          return moviesJson.map((m) => MovieSearchModel.fromJson(m)).toList();
        }
      }
      return []; 
    } catch (e) {
      print("Search API Error: $e");
      return [];
    }
  }
}