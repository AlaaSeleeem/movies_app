import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_source/profile_remote_data_source.dart';
import '../../data/repositories_impl/profile_repository_impl.dart';
import '../../domain/use_cases/add_to_watchlist_use_case.dart';
import '../../domain/use_cases/add_to_history_use_case.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRemoteDataSource _dataSource = ProfileRemoteDataSource();
  late final AddToWatchlistUseCase _addToWatchlist;
  late final AddToHistoryUseCase _addToHistory;

  ProfileBloc() : super(ProfileInitial()) {
    final repo = ProfileRepositoryImpl(remoteDataSource: _dataSource);
    _addToWatchlist = AddToWatchlistUseCase(repo);
    _addToHistory = AddToHistoryUseCase(repo);

    on<ToggleWatchlistEvent>(_onToggleWatchlist);
    on<AddToHistoryEvent>(_onAddToHistory);
    on<CheckWatchlistEvent>(_onCheckWatchlist);
  }
  Future<void> _onToggleWatchlist(
      ToggleWatchlistEvent event,
      Emitter<ProfileState> emit,
      ) async {
    final currentState = state;

    bool currentValue = false;
    if (currentState is WatchlistUpdated) {
      currentValue = currentState.isInWatchlist;
    }

    final newValue = !currentValue;

    emit(WatchlistUpdated(newValue)); // 🔥 instant UI update

    try {
      if (newValue) {
        await _addToWatchlist(
          movieId: event.movieId,
          title: event.title,
          image: event.image,
          rating: event.rating,
        );
      } else {
        await _dataSource.removeFromWatchlist(event.movieId);
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onAddToHistory(
      AddToHistoryEvent event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      await _addToHistory(
        movieId: event.movieId,
        title: event.title,
        image: event.image,
        rating: event.rating,
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onCheckWatchlist(
      CheckWatchlistEvent event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      final isIn = await _dataSource.isInWatchlist(event.movieId);
      emit(WatchlistUpdated(isIn));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}