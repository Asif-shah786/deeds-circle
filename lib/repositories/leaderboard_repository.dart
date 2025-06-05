import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/leaderboard.dart';
import '../models/user_challenge.dart';
import '../models/app_user.dart';

class LeaderboardRepository {
  final FirebaseFirestore _firestore;

  LeaderboardRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<Leaderboard> getLeaderboardForChallenge(String challengeId, String currentUserId) {
    return _firestore
        .collection('user_challenges')
        .where('challengeId', isEqualTo: challengeId)
        .orderBy('completedVideoIds', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final entries = <LeaderboardEntry>[];
      LeaderboardEntry? currentUserEntry;
      var rank = 1;

      for (var doc in snapshot.docs) {
        final userChallenge = UserChallenge.fromFirestore(doc);

        // Fetch user data from users collection using AppUser model
        final userDoc = await _firestore.collection('users').doc(userChallenge.userId).get();
        final appUser = userDoc.exists ? AppUser.fromFirestore(userDoc) : null;

        final entry = LeaderboardEntry.fromFirestore(
          {
            'userName': appUser?.displayName ?? 'Anonymous',
            'userPhotoUrl': appUser?.photoUrl,
            'rank': rank,
            'videosCompleted': userChallenge.completedVideoIds.length,
            'moneyEarned': userChallenge.earnedAmount,
            'streakDays': userChallenge.streakDays,
          },
          userChallenge.userId,
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
