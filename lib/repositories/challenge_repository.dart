import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/challenge.dart';

class ChallengeRepository {
  final FirebaseFirestore _firestore;

  ChallengeRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Challenge>> getPublicChallenges() async {
    try {
      final snapshot = await _firestore.collection('challenges').where('isPublic', isEqualTo: true).get();

      return snapshot.docs.map((doc) => Challenge.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get public challenges: $e');
    }
  }

  Future<List<Challenge>> getChallenges() async {
    try {
      final snapshot = await _firestore.collection('challenges').get();

      return snapshot.docs.map((doc) => Challenge.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get challenges: $e');
    }
  }

  Future<Challenge?> getById(String id) async {
    try {
      final doc = await _firestore.collection('challenges').doc(id).get();
      if (!doc.exists) return null;
      return Challenge.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get challenge: $e');
    }
  }

  Future<void> create(Challenge challenge) async {
    try {
      await _firestore.collection('challenges').doc(challenge.id).set(challenge.toJson());
    } catch (e) {
      throw Exception('Failed to create challenge: $e');
    }
  }

  Future<void> update(Challenge challenge) async {
    try {
      await _firestore.collection('challenges').doc(challenge.id).update(challenge.toJson());
    } catch (e) {
      throw Exception('Failed to update challenge: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      await _firestore.collection('challenges').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete challenge: $e');
    }
  }
}
