import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/leaderboard.dart';
import '../repositories/leaderboard_repository.dart';
import 'auth_provider.dart';
import 'user_challenge_provider.dart';

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return LeaderboardRepository();
});

final leaderboardProvider = StreamProvider.family<Leaderboard, String>((ref, challengeId) {
  final repository = ref.watch(leaderboardRepositoryProvider);
  final currentUser = ref.watch(authStateProvider).value;

  if (currentUser == null) {
    throw Exception('User must be logged in to view leaderboard');
  }

  // If challengeId is 'current', get the current challenge ID from userChallengeProvider
  if (challengeId == 'current') {
    final userChallenge = ref.watch(userChallengeProvider).value;
    if (userChallenge == null) {
      throw Exception('No active challenge found');
    }
    challengeId = userChallenge.challengeId;
  }

  return repository.getLeaderboardForChallenge(challengeId, currentUser.uid);
});
