import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/challenge.dart';
import '../models/user_challenge.dart';
import '../repositories/challenge_repository.dart';
import '../repositories/user_challenge_repository.dart';
import 'auth_provider.dart';
import 'repository_providers.dart';

class ChallengesState {
  final List<Challenge> challenges;
  final Map<String, UserChallenge> userChallenges;
  final bool isLoading;
  final String? error;

  ChallengesState({
    this.challenges = const [],
    this.userChallenges = const {},
    this.isLoading = false,
    this.error,
  });

  ChallengesState copyWith({
    List<Challenge>? challenges,
    Map<String, UserChallenge>? userChallenges,
    bool? isLoading,
    String? error,
  }) {
    return ChallengesState(
      challenges: challenges ?? this.challenges,
      userChallenges: userChallenges ?? this.userChallenges,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ChallengesNotifier extends StateNotifier<ChallengesState> {
  final ChallengeRepository _challengeRepo;
  final UserChallengeRepository _userChallengeRepo;
  final Ref _ref;

  ChallengesNotifier(this._challengeRepo, this._userChallengeRepo, this._ref) : super(ChallengesState());

  Future<void> loadChallenges() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = _ref.read(authStateProvider).value;
      if (user == null) throw Exception('User not authenticated');

      final challenges = await _challengeRepo.getChallenges();
      final userChallenges = await _userChallengeRepo.getUserChallenges(user.uid);

      final userChallengesMap = {for (var uc in userChallenges) uc.challengeId: uc};

      state = state.copyWith(
        challenges: challenges,
        userChallenges: userChallengesMap,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> joinChallenge(String challengeId) async {
    try {
      final user = _ref.read(authStateProvider).value;
      if (user == null) throw Exception('User not authenticated');

      final challenge = state.challenges.firstWhere((c) => c.id == challengeId);
      final userChallenge = UserChallenge(
        id: '', // Empty ID - will be set by Firestore
        userId: user.uid,
        challengeId: challengeId,
        status: 'active',
        completedVideoIds: [],
        lastUpdated: DateTime.now(),
        paidAmount: 0.0,
        streakDays: 0,
        joinedAt: DateTime.now(),
        earnedAmount: 0.0,
      );

      final docRef = await _userChallengeRepo.create(userChallenge);

      // Update the state with the new document ID
      final updatedUserChallenge = userChallenge.copyWith(id: docRef.id);
      state = state.copyWith(
        userChallenges: {
          ...state.userChallenges,
          challengeId: updatedUserChallenge,
        },
      );
      await loadChallenges();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> leaveChallenge(String challengeId) async {
    try {
      final userChallenge = state.userChallenges[challengeId];
      if (userChallenge == null) return;

      await _userChallengeRepo.delete(userChallenge.id);

      final newUserChallenges = Map<String, UserChallenge>.from(state.userChallenges);
      newUserChallenges.remove(challengeId);

      state = state.copyWith(userChallenges: newUserChallenges);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final challengesProvider = StateNotifierProvider<ChallengesNotifier, ChallengesState>((ref) {
  final challengeRepo = ref.watch(challengeRepositoryProvider);
  final userChallengeRepo = ref.watch(userChallengeRepositoryProvider);
  return ChallengesNotifier(challengeRepo, userChallengeRepo, ref);
});
