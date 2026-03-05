import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateProfile(UserModel user);
  Future<void> deleteAccount();
  Future<UserModel?> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> updateProfile(UserModel user) async {
    final uid = _auth.currentUser?.uid ?? 'test_user';
    await _firestore.collection('users').doc(uid).set(
      user.toJson(),
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> deleteAccount() async {
    final uid = _auth.currentUser?.uid ?? 'test_user';
    await _firestore.collection('users').doc(uid).delete();
    await _auth.currentUser?.delete();
  }

  @override
  Future<UserModel?> getProfile() async {
    final uid = _auth.currentUser?.uid ?? 'test_user';
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.data() == null) return null;
    return UserModel.fromJson(doc.data()!);
  }
}