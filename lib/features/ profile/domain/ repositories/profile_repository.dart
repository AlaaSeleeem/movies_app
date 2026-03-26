import '../entities/user_entity.dart';

abstract class ProfileRepository {
  // ── Profile ───────────────────────────────────────────────
  Future<UserEntity> getProfile();
  Future<void> updateProfile(UserEntity user);
  Future<void> deleteAccount();
  Future<bool> isInWatchlist(int movieId);

  // ── Watchlist ─────────────────────────────────────────────
  Future<void> addToWatchlist({
    required int movieId,
    required String title,
    required String image,
    required double rating,
  });

  Future<void> removeFromWatchlist(int movieId);

  Stream<List<Map<String, dynamic>>> getWatchlist();

  // ── History ───────────────────────────────────────────────
  Future<void> addToHistory({
    required int movieId,
    required String title,
    required String image,
    required double rating,
  });

  Stream<List<Map<String, dynamic>>> getHistory();
}