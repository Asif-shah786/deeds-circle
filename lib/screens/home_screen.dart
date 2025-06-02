import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/challenge.dart';
import '../models/video.dart';
import '../models/user_challenge.dart';
import '../providers/challenges_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/repository_providers.dart';
import '../theme/app_theme.dart';
import '../widgets/duolingo_toast.dart';
import 'package:intl/intl.dart';
import '../utils/currency_formatter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesState = ref.watch(challengesProvider);
    final videoRepo = ref.watch(videoRepositoryProvider);

    // Remove loading check since data is already loaded in splash screen
    if (challengesState.error != null) {
      return Scaffold(
        body: Center(
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
      );
    }

    final joinedChallenges = challengesState.challenges
        .where((challenge) => challengesState.userChallenges.containsKey(challenge.id))
        .toList();

    if (joinedChallenges.isEmpty) {
      return _buildEmptyState(context);
    }

    final currentChallenge = joinedChallenges.first;
    final userChallenge = challengesState.userChallenges[currentChallenge.id]!;
    final progress = (userChallenge.completedVideoIds.length / currentChallenge.totalVideos) * 100;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.mosque,
                        size: 48,
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.share_outlined),
                            color: Colors.white,
                            onPressed: () {
                              // TODO: Share progress
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            color: Colors.white,
                            onPressed: () {
                              // TODO: Implement notifications
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentChallenge.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${currentChallenge.totalVideos} videos · ${CurrencyFormatter.format(currentChallenge.rewardAmount)}/video',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  if (currentChallenge.startDate != null || currentChallenge.endDate != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatChallengeDates(currentChallenge),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            context.push('/challenges/${currentChallenge.id}');
                          },
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'View Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            backgroundColor: Colors.white.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Progress Card
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Learning Progress',
                            style: AppTheme.heading3,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${progress.toStringAsFixed(0)}%',
                              style: TextStyle(
                                color: AppTheme.primaryGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _ChallengeStatItem(
                              icon: Icons.play_circle,
                              value: '${userChallenge.completedVideoIds.length}/${currentChallenge.totalVideos}',
                              label: 'Videos',
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                          Expanded(
                            child: _ChallengeStatItem(
                              icon: Icons.emoji_events,
                              value: CurrencyFormatter.format(userChallenge.earnedAmount),
                              label: 'Earned',
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                          Expanded(
                            child: _ChallengeStatItem(
                              icon: Icons.rocket_launch,
                              value: CurrencyFormatter.format(
                                  currentChallenge.totalPossibleEarning - userChallenge.earnedAmount),
                              label: 'Potential',
                              color: AppTheme.primaryYellow,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: progress / 100,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 16),
                      if (userChallenge.lastCompletedVideo != null) ...[
                        const Divider(),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.completedColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_circle,
                                color: AppTheme.completedColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Last Completed',
                                    style: AppTheme.bodySmall.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    userChallenge.lastCompletedVideo!.title,
                                    style: AppTheme.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _formatDate(userChallenge.lastCompletedVideo!.completedAt),
                                    style: AppTheme.bodySmall.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.share_outlined),
                              onPressed: () {
                                // TODO: Share this achievement
                              },
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Action Buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (userChallenge.completedVideoIds.length < currentChallenge.totalVideos)
                    ElevatedButton.icon(
                      onPressed: () {
                        context.push('/challenges/${currentChallenge.id}/videos');
                      },
                      icon: const Icon(Icons.play_circle_outline),
                      label: Text(
                        'Continue Video #${userChallenge.completedVideoIds.length + 1}',
                      ),
                      style: AppTheme.primaryButtonStyle.copyWith(
                        minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 56),
                        ),
                      ),
                    )
                  else
                    ElevatedButton.icon(
                      onPressed: () {
                        context.push('/journey');
                      },
                      icon: const Icon(Icons.insights),
                      label: const Text('View Your Journey'),
                      style: AppTheme.primaryButtonStyle.copyWith(
                        minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 56),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      context.push('/challenges-list');
                    },
                    icon: const Icon(Icons.explore),
                    label: const Text('Explore New Challenges'),
                    style: AppTheme.secondaryButtonStyle.copyWith(
                      minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 56),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Quick Stats
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Journey',
                            style: AppTheme.heading3,
                          ),
                          TextButton.icon(
                            onPressed: () {
                              context.push('/journey');
                            },
                            icon: const Icon(Icons.insights),
                            label: const Text('View All'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppTheme.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _StatItem(
                              icon: Icons.local_fire_department,
                              value: _calculateTotalStreakDays(challengesState.userChallenges.values).toString(),
                              label: 'Day Streak',
                              color: AppTheme.primaryYellow,
                            ),
                          ),
                          Expanded(
                            child: _StatItem(
                              icon: Icons.emoji_events,
                              value: challengesState.userChallenges.length.toString(),
                              label: 'Challenges',
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                          Expanded(
                            child: _StatItem(
                              icon: Icons.play_circle,
                              value: _calculateTotalCompletedVideos(challengesState.userChallenges.values).toString(),
                              label: 'Videos',
                              color: AppTheme.primaryGreen,
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
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Scaffold(
      body: Center(
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
                'No Active Challenges',
                style: AppTheme.heading2,
              ),
              const SizedBox(height: 12),
              const Text(
                'Join a challenge to start learning and earning rewards!',
                style: AppTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  context.push('/challenges-list', extra: 'fromHome');
                },
                style: AppTheme.primaryButtonStyle,
                child: const Text('Browse Challenges'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatChallengeDates(Challenge challenge) {
    final formatter = DateFormat('MMM d, yyyy');
    final shortFormatter = DateFormat('MMM d');

    if (challenge.startDate != null && challenge.endDate != null) {
      // If dates are in same year, only show year once
      if (challenge.startDate!.year == challenge.endDate!.year) {
        return '${shortFormatter.format(challenge.startDate!)} - ${formatter.format(challenge.endDate!)}';
      }
      return '${formatter.format(challenge.startDate!)} - ${formatter.format(challenge.endDate!)}';
    } else if (challenge.startDate != null) {
      return 'Starts ${formatter.format(challenge.startDate!)}';
    } else if (challenge.endDate != null) {
      return 'Ends ${formatter.format(challenge.endDate!)}';
    }
    return '';
  }

  // Helper methods for calculating overall stats
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

class _ChallengeStatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _ChallengeStatItem({
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

String _formatDate(DateTime date) {
  final formatter = DateFormat('MMM d, yyyy');
  return formatter.format(date);
}
