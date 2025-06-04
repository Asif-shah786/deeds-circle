import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  // Add getter for firestore
  FirebaseFirestore get firestore => _firestore;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update last login
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user profile in Firestore
      final user = userCredential.user!;
      await _createUserProfile(user.uid, email, displayName);

      // Update display name
      await user.updateDisplayName(displayName);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return AppUser.fromFirestore(doc);
  }

  Future<void> _createUserProfile(String uid, String email, String displayName) async {
    final user = AppUser(
      id: uid,
      displayName: displayName,
      email: email,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      totalCompletedVideos: 0,
      totalEarnings: 0.0,
      totalPaid: 0.0,
      points: 0,
      isAdmin: false,
      preferredLanguage: 'en',
    );

    await _firestore.collection('users').doc(uid).set(user.toFirestore());
  }

  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found with this email.');
      case 'wrong-password':
        return Exception('Wrong password provided.');
      case 'email-already-in-use':
        return Exception('Email is already in use.');
      case 'weak-password':
        return Exception('Password is too weak.');
      case 'invalid-email':
        return Exception('Email is invalid.');
      default:
        return Exception(e.message ?? 'An error occurred.');
    }
  }
}
