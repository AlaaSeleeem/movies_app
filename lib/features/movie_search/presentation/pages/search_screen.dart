import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_assets.dart';
import 'package:movies_app/features/movies/presentation/screens/movie_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [

      // ── Search Bar ──────────────────────────────────
      Padding(
        padding: EdgeInsets.all(16.w),
        child: TextField(
          onChanged: (value) {
            context.read<MovieSearchBloc>().add(OnQueryChanged(value));
          },
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: Padding(
              padding: EdgeInsets.all(12.w),
              child: Image.asset(AppAssets.searchIcon, color: Colors.white),
            ),
            filled: true,
            fillColor: const Color(0xFF282A28),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
            // ── Results Grid ────────────────────────────────
            Expanded(
              child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(child: CircularProgressIndicator(color: AppColors.yellow));
                  }
                  
                  if (state is SearchLoaded) {
                return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,       
                    crossAxisSpacing: 12.w,    
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 0.7,     
                  ),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];


                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            MovieDetailsScreen.routeName,
                            arguments: movie.id,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.network(
                                  movie.imageUrl,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(color: Colors.white10),
                                ),
                              ),
                              // Rating Badge 
                              Positioned(
                                top: 8.h, left: 6.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xB5121312),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('${movie.rating}', style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                                      SizedBox(width: 2.w),
                                      Icon(Icons.star, color: AppColors.yellow, size: 12.sp),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return Center(
                    child: Image.asset(AppAssets.emptySearch, width: 124.w),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}