import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../models/movie_model.dart';

class MovieSearchRepositoryImpl implements MovieSearchRepository {
  @override
  Future<List<MovieSearchEntity>> searchMovies(String query) async {
    final String url = 'https://yts.mx/api/v2/list_movies.json?query_term=$query';
    
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data['status'] == 'ok' && data['data']['movies'] != null) {
          final List moviesJson = data['data']['movies'];
          return moviesJson.map((m) => MovieSearchModel.fromJson(m)).toList();
        }
      }
      return []; 
    } catch (e) {

      print("API Error: $e"); 
      return [];
    }
  }
}