import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/movie_entity.dart';
import '../../../../../core/constants/app_colors.dart';
import 'movie_card.dart';

class CategorySection extends StatelessWidget {
  final String genre;
  final List<MovieEntity> movies;

  const CategorySection({
    super.key,
    required this.genre,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                genre,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  Text(
                    'See More',
                    style: TextStyle(
                      color: AppColors.yellow,
                      fontSize: 16.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.yellow,
                    size: 12.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        // ── Movies List ───────────────────────────────
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: movies.length > 3 ? 3 : movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: MovieCard(
                  movie: movies[index],
                  width: 146.w,
                  height: 220.h,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}