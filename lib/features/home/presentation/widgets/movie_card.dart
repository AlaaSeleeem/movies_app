import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/movie_entity.dart';
import '../../../../../core/constants/app_colors.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final double width;
  final double height;

  const MovieCard({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        children: [
          // ── Movie Poster ───────────────────────────────
          SizedBox(
            width: width,
            height: height,
            child: Image.network(
              movie.coverImage,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.grey,
                child: Icon(Icons.movie, color: AppColors.white),
              ),
            ),
          ),

          // ── Rating Badge ───────────────────────────────
          Positioned(
            top: 11.h,
            left: 9.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xB5121312),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.rating.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.star, color: AppColors.yellow, size: 15.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}