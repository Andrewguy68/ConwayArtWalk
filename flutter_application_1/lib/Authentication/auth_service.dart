import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//This Has been reused from my previous project (Hang out) which I have modified.
class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  static String toEmail(String email) => email.trim().toLowerCase();

  Stream<User?> get authState => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<User> signInAsGuest() async {
    // added for guest login features.
    if (_auth.currentUser?.isAnonymous == true) {
      return _auth.currentUser!;
    }
    final cred = await _auth.signInAnonymously();
    return cred.user!;
  }

  Future<User> signUp(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: toEmail(email),
      password: password, // min 6 chars
    );
    final user = cred.user!;
    try {
      await _db.collection('users').doc(user.uid).set({
        'email': toEmail(email),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {
      try {
        await user.delete();
      } catch (_) {}
      rethrow;
    }
    return user;
  }

  Future<User> logIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: toEmail(email),
      password: password,
    );
    return cred.user!;
  }

  Future<void> logOut() => _auth.signOut();
}

String authErrorMessage(Object error) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'email-already-in-use':
        return 'That email is already registered.';
      case 'weak-password':
        return 'That password is too weak. Use at least 6 characters.';
      case 'invalid-email':
        return 'Enter a valid email address.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait a bit and try again.';
      case 'network-request-failed':
        return 'No internet connection. Check your network and try again.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled for this project.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
  if (error is FirebaseException) {
    return 'Could not reach the server. Please try again.';
  }
  return 'Something went wrong. Please try again.';
}
