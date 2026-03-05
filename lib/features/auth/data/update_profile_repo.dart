import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateProfileRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ── Update Profile ────────────────────────────────────────
  Future<void> updateProfile({
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    final uid = _auth.currentUser?.uid ?? 'test_user';
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'phone': phone,
      'avatarIndex': avatarIndex,
    }, SetOptions(merge: true));
  }

  // ── Delete Account ────────────────────────────────────────
  Future<void> deleteAccount() async {
    final uid = _auth.currentUser?.uid ?? 'test_user';
    await _firestore.collection('users').doc(uid).delete();
    await _auth.currentUser?.delete();
  }

  // ── Get Profile ───────────────────────────────────────────
  Future<Map<String, dynamic>?> getProfile() async {
    final uid = _auth.currentUser?.uid ?? 'test_user';
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }
}