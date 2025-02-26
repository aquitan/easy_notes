import 'package:easy_notes/repository/auth/abstract_auth_reository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository implements AbstractAuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepository({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  @override
  Future<User> register(String email, String password) async {
    final userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    final user = userCredentials.user;

    if (user != null) {
      return user;
    } else {
      throw const Failure(
        message: 'Failed to sign up',
        code: 'user-credential-null',
      );
    }
  }


  @override
  Future<User> login(String email, String password) async {
    final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    final user = userCredentials.user;

    if (user != null) {
      return user;
    } else {
      throw const Failure(
        message: 'Failed to sign in',
        code: 'user-credential-null',
      );
    }
  }
}

class Failure implements Exception {
  final String message;
  final String code;

  const Failure({required this.message, required this.code});
}