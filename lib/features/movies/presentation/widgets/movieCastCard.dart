import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/cast.dart';
class Moviecastcard extends StatelessWidget {
  final Cast cast;
  const Moviecastcard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(cast.image, width: 60, height: 60, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: Colors.grey)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cast.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(cast.characterName, style: TextStyle(color: Colors.white.withOpacity(0.6))),
            ],
          ),
        ],
      ),
    );
  }
}
