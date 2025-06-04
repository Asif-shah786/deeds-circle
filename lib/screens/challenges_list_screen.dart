import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/challenge.dart';
import '../models/user_challenge.dart';
import '../models/app_user.dart';
import '../providers/challenges_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/duolingo_toast.dart';
import '../repositories/auth_repository.dart';

// Provider to fetch admin details
final adminDetailsProvider = FutureProvider.family<AppUser?, String>((ref, adminId) async {
  final authRepo = AuthRepository();
  final doc = await authRepo.firestore.collection('users').doc(adminId).get();
  if (!doc.exists) return null;
  return AppUser.fromFirestore(doc);
});

class ChallengesListScreen extends ConsumerStatefulWidget {
  final bool showBackButton;
  const ChallengesListScreen({super.key, this.showBackButton = false});

  @override
  ConsumerState<ChallengesListScreen> createState() => _ChallengesListScreenState();
}

class _ChallengesListScreenState extends ConsumerState<ChallengesListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(challengesProvider.notifier).loadChallenges());
  }

  @override
  Widget build(BuildContext context) {
    final challengesState = ref.watch(challengesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryGreen,
        elevation: 0,
        leading: widget.showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).maybePop(),
              )
            : null,
        title: const Text(
          'Join Challenges',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              decoration: const BoxDecoration(
                color: AppTheme.primaryGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.mosque,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Start learning and earning rewards by joining challenges',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Challenges List
          if (challengesState.isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (challengesState.error != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppTheme.errorRed,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      challengesState.error!,
                      style: const TextStyle(color: AppTheme.errorRed),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(challengesProvider.notifier).loadChallenges();
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            )
          else if (challengesState.challenges.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text(
                  'No challenges available',
                  style: TextStyle(
                    color: AppTheme.textLight,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final challenge = challengesState.challenges[index];
                    final userChallenge = challengesState.userChallenges[challenge.id];
                    return _ChallengeCard(
                      challenge: challenge,
                      userChallenge: userChallenge,
                      onJoin: () async {
                        await ref.read(challengesProvider.notifier).joinChallenge(challenge.id);
                        if (mounted) {
                          DuolingoToastHelper.show(
                            context: context,
                            message: 'Successfully joined ${challenge.title}!',
                            icon: Icons.check_circle,
                            backgroundColor: AppTheme.primaryGreen,
                          );
                          // Navigate to home screen after joining
                          context.go('/home');
                        }
                      },
                      onLeave: () {
                        ref.read(challengesProvider.notifier).leaveChallenge(challenge.id);
                        DuolingoToastHelper.show(
                          context: context,
                          message: 'Left ${challenge.title}',
                          icon: Icons.info_outline,
                          backgroundColor: Colors.blue,
                        );
                      },
                      onViewDetails: () {
                        context.push('/challenges/${challenge.id}');
                      },
                    );
                  },
                  childCount: challengesState.challenges.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ChallengeCard extends ConsumerWidget {
  final Challenge challenge;
  final UserChallenge? userChallenge;
  final VoidCallback onJoin;
  final VoidCallback onLeave;
  final VoidCallback onViewDetails;

  const _ChallengeCard({
    required this.challenge,
    required this.userChallenge,
    required this.onJoin,
    required this.onLeave,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isJoined = userChallenge != null;
    final adminDetails = ref.watch(adminDetailsProvider(challenge.primaryAdminId));

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${challenge.totalVideos} videos • Rs ${challenge.rewardAmount.toStringAsFixed(0)} reward',
                        style: const TextStyle(
                          color: AppTheme.textLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      adminDetails.when(
                        data: (admin) => Text(
                          'Created by ${admin?.displayName ?? 'Unknown'}',
                          style: const TextStyle(
                            color: AppTheme.textLight,
                            fontSize: 12,
                          ),
                        ),
                        loading: () => const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        error: (_, __) => const Text(
                          'Created by Unknown',
                          style: TextStyle(
                            color: AppTheme.textLight,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isJoined)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Joined',
                      style: TextStyle(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              challenge.description,
              style: const TextStyle(
                color: AppTheme.textLight,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isJoined ? onLeave : onJoin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isJoined ? Colors.grey.shade200 : AppTheme.primaryGreen,
                      foregroundColor: isJoined ? AppTheme.textDark : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      isJoined ? 'Leave Challenge' : 'Join Challenge',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: onViewDetails,
                  icon: const Icon(Icons.arrow_forward),
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
