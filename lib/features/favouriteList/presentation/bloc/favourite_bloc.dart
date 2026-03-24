import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/addToFavorites.dart';
import '../../domain/use_cases/getAllFavorites.dart';
import '../../domain/use_cases/getFavoriteStatus.dart';
import '../../domain/use_cases/removeFromFavorites.dart';
import 'favourite_event.dart';
import 'favourite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteStatus getStatus;
  final AddToFavorites addToFavorites;
  final RemoveFromFavorites remove;
  final GetAllFavorites getAll;

  FavoriteBloc({
    required this.getStatus,
    required this.addToFavorites,
    required this.remove,
    required this.getAll,
  }) : super(FavoriteInitial()) {
    on<CheckFavoriteStatusEvent>(_onCheckStatus);
    on<AddFavoriteEvent>(_onAdd);
    on<RemoveFavoriteEvent>(_onRemove);
    on<GetAllFavoritesEvent>(_onGetAll);
  }

  Future<void> _onCheckStatus(
      CheckFavoriteStatusEvent event,
      Emitter<FavoriteState> emit,
      ) async {
    emit(FavoriteLoading());

    try {
      final result = await getStatus(event.movieId);
      emit(FavoriteStatusLoaded(result));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> _onAdd(
      AddFavoriteEvent event,
      Emitter<FavoriteState> emit,
      ) async {
    emit(FavoriteStatusLoaded(true)); // optimistic

    try {
      await addToFavorites(event.movieId);
    } catch (e) {
      emit(FavoriteStatusLoaded(false)); // rollback
    }
  }

  Future<void> _onRemove(
      RemoveFavoriteEvent event,
      Emitter<FavoriteState> emit,
      ) async {
    emit(FavoriteStatusLoaded(false)); // optimistic

    try {
      await remove(event.movieId);
    } catch (e) {
      emit(FavoriteStatusLoaded(true)); // rollback
    }
  }

  Future<void> _onGetAll(
      GetAllFavoritesEvent event,
      Emitter<FavoriteState> emit,
      ) async {
    emit(FavoriteLoading());

    try {
      final movies = await getAll();
      emit(FavoritesLoaded(movies));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}