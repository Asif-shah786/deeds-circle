import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_challenge.dart';
import '../repositories/user_challenge_repository.dart';
import 'auth_provider.dart';

final userChallengeRepositoryProvider = Provider<UserChallengeRepository>((ref) {
  return UserChallengeRepository();
});

final userChallengeProvider = StreamProvider<UserChallenge?>((ref) {
  final repository = ref.watch(userChallengeRepositoryProvider);
  final currentUser = ref.watch(authStateProvider).value;

  if (currentUser == null) {
    throw Exception('User must be logged in to view challenges');
  }

  // Use a real-time stream instead of polling
  return repository.getUserChallengesStream(currentUser.uid).map((challenges) {
    try {
      return challenges.firstWhere(
        (challenge) => challenge.status == 'active',
        orElse: () => throw Exception('No active challenge found'),
      );
    } catch (e) {
      return null;
    }
  });
});
