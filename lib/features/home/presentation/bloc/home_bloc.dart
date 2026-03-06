import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_movies_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase _getMoviesUseCase;

  HomeBloc(this._getMoviesUseCase) : super(HomeInitial()) {
    on<GetMoviesEvent>(_onGetMovies);
  }

  Future<void> _onGetMovies(
      GetMoviesEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());
    try {
      final movies = await _getMoviesUseCase();
      emit(HomeLoaded(movies));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}