import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await http.get(
      Uri.parse(
        'https://yts.lt/api/v2/list_movies.json?limit=20&sort_by=rating',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final movies = data['data']['movies'] as List;
      return movies.map((m) => MovieModel.fromJson(m as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}