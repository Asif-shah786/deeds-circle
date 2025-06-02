import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/user_challenge_repository.dart';
import '../repositories/challenge_repository.dart';
import '../repositories/video_repository.dart';

final userChallengeRepositoryProvider = Provider<UserChallengeRepository>((ref) {
  return UserChallengeRepository();
});

final challengeRepositoryProvider = Provider<ChallengeRepository>((ref) {
  return ChallengeRepository();
});

final videoRepositoryProvider = Provider<VideoRepository>((ref) {
  return VideoRepository();
});
