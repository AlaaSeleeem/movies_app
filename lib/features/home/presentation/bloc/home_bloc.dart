import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/use_cases/get_movies_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase _getMoviesUseCase;

  List<MovieEntity> _allMovies = [];

  HomeBloc(this._getMoviesUseCase) : super(HomeInitial()) {
    on<GetMoviesEvent>(_onGetMovies);
    on<FilterMoviesEvent>(_onFilterMovies);
  }

  Future<void> _onGetMovies(GetMoviesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final movies = await _getMoviesUseCase();
      _allMovies = movies;
      emit(HomeLoaded(movies));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onFilterMovies(FilterMoviesEvent event, Emitter<HomeState> emit) {

    if (event.genre == "All" || event.genre.isEmpty) {
      emit(HomeLoaded(_allMovies));
    } else {

      final selectedGenre = event.genre.toLowerCase().trim();

      final filteredMovies = _allMovies.where((movie) {

        return movie.genres.any((genre) =>
          genre.toLowerCase().trim() == selectedGenre
        );
      }).toList();

      emit(HomeLoaded(filteredMovies));
    }
  }
}
