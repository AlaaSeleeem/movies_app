import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/presentation/widgets/movieCastCard.dart';

import '../../domain/entities/cast.dart';
class MovieCastList extends StatelessWidget {
  final List<Cast> cast;
  const MovieCastList({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) => Moviecastcard(cast:cast[index]),
          childCount: cast.length,
        ),
      ),
    );
  }
}
