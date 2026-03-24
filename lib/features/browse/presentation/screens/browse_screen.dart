import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../home/presentation/bloc/home_event.dart';
import '../../../home/presentation/bloc/home_state.dart';
import '../widgets/genre_card.dart';
import '../widgets/movie_card.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int selectedGenreIndex = 0;
  final List<String> genres = ["Action", "Adventure", "Animation", "Biography"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            SizedBox(
              height: 48.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: genres.length,

                itemBuilder: (context, index) {
                  return GenreCard(
                    title: genres[index],
                    isSelected: selectedGenreIndex == index,
                    onTap: () {
                      setState(() {
                        selectedGenreIndex = index;
                      });

                      context.read<HomeBloc>().add(FilterMoviesEvent(genres[index]));
                    },
                  );
                },

              ),
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFFF6BD00)));
                  } else if (state is HomeLoaded) {
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 189 / 279,
                        crossAxisSpacing: 20.w,
                        mainAxisSpacing: 20.h,
                      ),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: state.movies[index]);
                      },
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 80.h,
        margin: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: const Color(0xFF282A28),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.home, color: Colors.white),
            const Icon(Icons.search, color: Colors.white),
            const Icon(Icons.explore, color: Color(0xFFF6BD00)),
            const Icon(Icons.person, color: Colors.white),
          ],
        ),
      ),
    );
  }
}