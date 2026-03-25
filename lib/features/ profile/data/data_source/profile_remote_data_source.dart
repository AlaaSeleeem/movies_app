import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class ProfileRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  // ── Profile ───────────────────────────────────────────────
  Future<UserEntity> getProfile() async {
    final doc = await _firestore
        .collection('users')
        .doc(_uid)
        .get();
    return UserEntity(
      name: doc['name'],
      phone: doc['phone'],
      avatarIndex: doc['avatarIndex'],
    );
  }

  Future<void> updateProfile(UserEntity user) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .update({
      'name': user.name,
      'phone': user.phone,
      'avatarIndex': user.avatarIndex,
    });
  }

  Future<void> deleteAccount() async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .delete();
    await _auth.currentUser!.delete();
  }

  // ── Watchlist ─────────────────────────────────────────────
  Future<void> addToWatchlist({
    required int movieId,
    required String title,
    required String image,
    required double rating,
  }) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('watchlist')
        .doc(movieId.toString())
        .set({
      'id': movieId,
      'title': title,
      'image': image,
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeFromWatchlist(int movieId) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('watchlist')
        .doc(movieId.toString())
        .delete();
  }

  Stream<List<Map<String, dynamic>>> getWatchlist() {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('watchlist')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  Future<bool> isInWatchlist(int movieId) async {
    final doc = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('watchlist')
        .doc(movieId.toString())
        .get();
    return doc.exists;
  }

  // ── History ───────────────────────────────────────────────
  Future<void> addToHistory({
    required int movieId,
    required String title,
    required String image,
    required double rating,
  }) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('history')
        .doc(movieId.toString())
        .set({
      'id': movieId,
      'title': title,
      'image': image,
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> getHistory() {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('history')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }
}