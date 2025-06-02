import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/leaderboard.dart';
import '../models/user_challenge.dart';

class LeaderboardRepository {
  final FirebaseFirestore _firestore;

  LeaderboardRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<Leaderboard> getLeaderboardForChallenge(String challengeId, String currentUserId) {
    return _firestore
        .collection('user_challenges')
        .where('challengeId', isEqualTo: challengeId)
        .orderBy('completedVideoIds', descending: true)
        .snapshots()
        .map((snapshot) {
      final entries = <LeaderboardEntry>[];
      LeaderboardEntry? currentUserEntry;
      var rank = 1;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final userId = doc.id;
        final entry = LeaderboardEntry.fromFirestore(
          {
            'userName': data['userName'] ?? 'Anonymous',
            'userPhotoUrl': data['userPhotoUrl'],
            'rank': rank,
            'videosCompleted': (data['completedVideoIds'] as List<dynamic>).length,
            'moneyEarned': data['earnedAmount'] ?? 0.0,
            'streakDays': data['streakDays'] ?? 0,
          },
          userId,
          currentUserId,
        );

        if (entry.isCurrentUser) {
          currentUserEntry = entry;
        }

        entries.add(entry);
        rank++;
      }

      return Leaderboard(
        challengeId: challengeId,
        entries: entries,
        currentUserEntry: currentUserEntry,
        lastUpdated: DateTime.now(),
      );
    });
  }

  Future<void> updateUserChallengeProgress(UserChallenge userChallenge) async {
    await _firestore.collection('user_challenges').doc(userChallenge.id).update({
      'completedVideoIds': userChallenge.completedVideoIds,
      'earnedAmount': userChallenge.earnedAmount,
      'streakDays': userChallenge.streakDays,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }
}
