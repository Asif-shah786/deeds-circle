import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_challenge.dart';
import '../models/challenge.dart';

class UserChallengeRepository {
  final FirebaseFirestore _firestore;

  UserChallengeRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<UserChallenge>> getUserChallengesStream(String userId) {
    return _firestore
        .collection('user_challenges')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => UserChallenge.fromFirestore(doc)).toList());
  }

  Future<List<UserChallenge>> getUserChallenges(String userId) async {
    try {
      final snapshot = await _firestore.collection('user_challenges').where('userId', isEqualTo: userId).get();

      return snapshot.docs.map((doc) => UserChallenge.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get user challenges: $e');
    }
  }

  Future<UserChallenge?> getById(String id) async {
    try {
      final doc = await _firestore.collection('user_challenges').doc(id).get();
      if (!doc.exists) return null;
      return UserChallenge.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get user challenge: $e');
    }
  }

  Future<DocumentReference> create(UserChallenge challenge) async {
    try {
      final docRef = _firestore.collection('user_challenges').doc();
      final data = challenge.toJson();

      // Convert DateTime to Timestamp
      data['lastUpdated'] = Timestamp.fromDate(challenge.lastUpdated);
      data['joinedAt'] = Timestamp.fromDate(challenge.joinedAt);

      await docRef.set(data);
      return docRef;
    } catch (e) {
      throw Exception('Failed to create user challenge: $e');
    }
  }

  Future<void> update(UserChallenge challenge) async {
    try {
      final data = challenge.toJson();

      // Convert DateTime to Timestamp
      data['lastUpdated'] = Timestamp.fromDate(challenge.lastUpdated);
      data['joinedAt'] = Timestamp.fromDate(challenge.joinedAt);

      await _firestore.collection('user_challenges').doc(challenge.id).update(data);
    } catch (e) {
      throw Exception('Failed to update user challenge: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      await _firestore.collection('user_challenges').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete user challenge: $e');
    }
  }

  Future<void> markVideoAsCompleted(String userChallengeId, String videoId, String videoTitle) async {
    try {
      final docRef = _firestore.collection('user_challenges').doc(userChallengeId);
      final doc = await docRef.get();

      if (!doc.exists) throw Exception('User challenge not found');

      final userChallenge = UserChallenge.fromFirestore(doc);

      // Don't mark as completed if already completed
      if (userChallenge.completedVideoIds.contains(videoId)) return;

      // Get challenge to get reward amount and total videos
      final challengeDoc = await _firestore.collection('challenges').doc(userChallenge.challengeId).get();
      if (!challengeDoc.exists) throw Exception('Challenge not found');

      final challenge = Challenge.fromFirestore(challengeDoc);

      // Update completed videos and earned amount
      final newCompletedVideos = [...userChallenge.completedVideoIds, videoId];
      final newEarnedAmount = userChallenge.earnedAmount + challenge.rewardAmount;

      // Calculate new progress
      final newProgress = (newCompletedVideos.length / challenge.totalVideos) * 100;

      // Check if challenge is completed
      final isCompleted = newCompletedVideos.length >= challenge.totalVideos;

      // Create last completed video data
      final lastCompletedVideo = {
        'videoId': videoId,
        'completedAt': Timestamp.now(),
        'title': videoTitle,
      };

      // Update all fields
      await docRef.update({
        'completedVideoIds': newCompletedVideos,
        'earnedAmount': newEarnedAmount,
        'lastCompletedVideo': lastCompletedVideo,
        'lastUpdated': Timestamp.now(),
        'progress': newProgress,
        'status': isCompleted ? 'completed' : 'active',
        'completedAt': isCompleted ? Timestamp.now() : null,
      });

      // If challenge is completed, update challenge status
      if (isCompleted) {
        await _firestore.collection('challenges').doc(userChallenge.challengeId).update({
          'status': 'completed',
          'completedAt': Timestamp.now(),
        });
      }
    } catch (e) {
      throw Exception('Failed to mark video as completed: $e');
    }
  }
}
