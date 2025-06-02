import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/challenge.dart';
import '../models/user_challenge.dart';
import '../providers/challenges_provider.dart';
import '../theme/app_theme.dart';
import '../utils/currency_formatter.dart';
import 'package:intl/intl.dart';

class JourneyScreen extends ConsumerWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesState = ref.watch(challengesProvider);

    if (challengesState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final userChallenges = challengesState.userChallenges.values.toList();
    final completedChallenges = userChallenges.where((uc) => uc.status == 'completed').toList();
    final activeChallenges = userChallenges.where((uc) => uc.status == 'active').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Journey'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          // Overall Stats Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Overall Progress',
                        style: AppTheme.heading3,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _StatItem(
                              icon: Icons.local_fire_department,
                              value: _calculateTotalStreakDays(userChallenges).toString(),
                              label: 'Day Streak',
                              color: AppTheme.primaryYellow,
                            ),
                          ),
                          Expanded(
                            child: _StatItem(
                              icon: Icons.emoji_events,
                              value: completedChallenges.length.toString(),
                              label: 'Completed',
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                          Expanded(
                            child: _StatItem(
                              icon: Icons.play_circle,
                              value: _calculateTotalCompletedVideos(userChallenges).toString(),
                              label: 'Videos',
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _StatItem(
                              icon: Icons.account_balance_wallet,
                              value: CurrencyFormatter.format(
                                userChallenges.fold(0.0, (sum, uc) => sum + uc.earnedAmount),
                              ),
                              label: 'Total Earned',
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                          Expanded(
                            child: _StatItem(
                              icon: Icons.rocket_launch,
                              value: activeChallenges.length.toString(),
                              label: 'Active',
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Active Challenges
          if (activeChallenges.isNotEmpty) ...[
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  'Active Challenges',
                  style: AppTheme.heading3,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final userChallenge = activeChallenges[index];
                  final challenge = challengesState.challenges.firstWhere(
                    (c) => c.id == userChallenge.challengeId,
                  );
                  return _ChallengeCard(
                    challenge: challenge,
                    userChallenge: userChallenge,
                    onTap: () => context.push('/challenges/${challenge.id}'),
                  );
                },
                childCount: activeChallenges.length,
              ),
            ),
          ],

          // Completed Challenges
          if (completedChallenges.isNotEmpty) ...[
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Completed Challenges',
                  style: AppTheme.heading3,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final userChallenge = completedChallenges[index];
                  final challenge = challengesState.challenges.firstWhere(
                    (c) => c.id == userChallenge.challengeId,
                  );
                  return _ChallengeCard(
                    challenge: challenge,
                    userChallenge: userChallenge,
                    onTap: () => context.push('/challenges/${challenge.id}'),
                    isCompleted: true,
                  );
                },
                childCount: completedChallenges.length,
              ),
            ),
          ],

          // Empty State
          if (userChallenges.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.emoji_events_outlined,
                          size: 64,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Start Your Journey',
                        style: AppTheme.heading2,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Join challenges to start learning and earning rewards!',
                        style: AppTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/challenges-list');
                        },
                        style: AppTheme.primaryButtonStyle,
                        child: const Text('Browse Challenges'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  int _calculateTotalStreakDays(Iterable<UserChallenge> userChallenges) {
    return userChallenges.fold(0, (sum, challenge) => sum + (challenge.streakDays ?? 0));
  }

  int _calculateTotalCompletedVideos(Iterable<UserChallenge> userChallenges) {
    return userChallenges.fold(0, (sum, challenge) => sum + challenge.completedVideoIds.length);
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTheme.heading3.copyWith(
            color: color,
          ),
        ),
        Text(
          label,
          style: AppTheme.bodySmall,
        ),
      ],
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final UserChallenge userChallenge;
  final VoidCallback onTap;
  final bool isCompleted;

  const _ChallengeCard({
    required this.challenge,
    required this.userChallenge,
    required this.onTap,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (userChallenge.completedVideoIds.length / challenge.totalVideos) * 100;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
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
                      color: isCompleted
                          ? AppTheme.completedColor.withOpacity(0.1)
                          : AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isCompleted ? Icons.emoji_events : Icons.play_circle,
                      color: isCompleted ? AppTheme.completedColor : AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge.title,
                          style: AppTheme.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${userChallenge.completedVideoIds.length}/${challenge.totalVideos} videos',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppTheme.completedColor.withOpacity(0.1)
                          : AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${progress.toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: isCompleted ? AppTheme.completedColor : AppTheme.primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  isCompleted ? AppTheme.completedColor : AppTheme.primaryGreen,
                ),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Earned: ${CurrencyFormatter.format(userChallenge.earnedAmount)}',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isCompleted)
                    Text(
                      'Completed ${_formatDate(userChallenge.lastCompletedVideo?.completedAt ?? userChallenge.lastUpdated)}',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textLight,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final formatter = DateFormat('MMM d, yyyy');
  return formatter.format(date);
}
