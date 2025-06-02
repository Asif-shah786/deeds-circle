import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_challenge.dart';
import '../repositories/user_challenge_repository.dart';
import 'auth_provider.dart';

final userChallengeRepositoryProvider = Provider<UserChallengeRepository>((ref) {
  return UserChallengeRepository();
});

final userChallengeProvider = StreamProvider<UserChallenge?>((ref) async* {
  final repository = ref.watch(userChallengeRepositoryProvider);
  final currentUser = ref.watch(authStateProvider).value;

  if (currentUser == null) {
    throw Exception('User must be logged in to view challenges');
  }

  while (true) {
    final challenges = await repository.getUserChallenges(currentUser.uid);
    final activeChallenge = challenges.firstWhere(
      (challenge) => challenge.status == 'active',
      orElse: () => throw Exception('No active challenge found'),
    );
    yield activeChallenge;
    await Future.delayed(const Duration(seconds: 5)); // Refresh every 5 seconds
  }
});
