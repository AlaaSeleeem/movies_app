import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domian/entities/register_request.dart';
import 'auth_interface_data_source.dart';

class AuthFirebaseDataSource implements AuthInterfaceDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> execute({required RegisterRequest request}) async {
    try {
      // Created user in Firebase Auth
      // only username and password here for auth use the rest in firestore
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      // Saved extra  data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': request.name,
        'email': request.email,
        'phone': request.phone,
        'avatar': request.avaterId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Firebase registration failed');
    } catch (e) {
      throw Exception('Something went wrong during registration');
    }
  }
}