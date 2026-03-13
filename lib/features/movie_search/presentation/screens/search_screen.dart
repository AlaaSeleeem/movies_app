import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_bloc.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // Search Input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (val) =>
                    context.read<SearchBloc>().add(OnQueryChanged(val)),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Marvel",
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // Result Area
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading)
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    );
                  if (state is SearchError)
                    return Center(child: Text(state.message));
                  if (state is SearchLoaded) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = constraints.maxWidth > 900
                            ? 5
                            : (constraints.maxWidth > 600 ? 3 : 2);
                        return GridView.builder(
                          padding: const EdgeInsets.all(12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemCount: state.movies.length,
                          itemBuilder: (context, index) =>
                              MovieCard(movie: state.movies[index]),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Icon(
                      Icons.movie_filter,
                      size: 100,
                      color: Colors.white10,
                    ),
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
