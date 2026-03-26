import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/movie_entity.dart';

class MovieSearchCard extends StatelessWidget {
  final MovieSearchEntity movie;
  const MovieSearchCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Stack(
        children: [
          Image.network(movie.imageUrl, fit: BoxFit.cover, height: double.infinity, width: double.infinity),
          Positioned(
            top: 5, left: 5,
            child: Container(
              padding: const EdgeInsets.all(4),
              color: Colors.black54,
              child: Row(
                children: [
                  Text(movie.rating.toString(), style: const TextStyle(color: Colors.white)),
                  const Icon(Icons.star, color: Colors.yellow, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}