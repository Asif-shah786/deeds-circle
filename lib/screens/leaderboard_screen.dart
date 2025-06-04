import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/leaderboard.dart';
import '../providers/leaderboard_provider.dart';
import '../theme/app_theme.dart';
import 'package:countup/countup.dart';

class LeaderboardScreen extends ConsumerWidget {
  final String challengeId;

  const LeaderboardScreen({
    super.key,
    required this.challengeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(leaderboardProvider(challengeId));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryGreen,
        title: const Text(
          'Leaderboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: leaderboardAsync.when(
        data: (leaderboard) => _buildLeaderboard(context, leaderboard),
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: AppTheme.errorRed,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Error: ${error.toString()}',
                style: AppTheme.bodyMedium.copyWith(color: AppTheme.errorRed),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboard(BuildContext context, Leaderboard leaderboard) {
    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Implement refresh
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (leaderboard.currentUserEntry != null)
            SliverToBoxAdapter(
              child: _buildCurrentUserCard(leaderboard.currentUserEntry!),
            ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final entry = leaderboard.entries[index];
                  return _buildLeaderboardEntry(
                    context,
                    entry,
                    index,
                  );
                },
                childCount: leaderboard.entries.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentUserCard(LeaderboardEntry entry) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryGreen.withOpacity(0.1),
            AppTheme.primaryGreen.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.primaryGreen,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    backgroundImage: entry.userPhotoUrl != null ? NetworkImage(entry.userPhotoUrl!) : null,
                    child: entry.userPhotoUrl == null ? Text(entry.userName[0].toUpperCase()) : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.userName,
                        style: AppTheme.heading3.copyWith(
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                      Text(
                        'Rank #${entry.rank}',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.primaryGreen.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(
                  'Videos',
                  entry.videosCompleted.toString(),
                  Icons.play_circle,
                ),
                _buildStat(
                  'Earned',
                  '\$${entry.moneyEarned.toStringAsFixed(2)}',
                  Icons.attach_money,
                ),
                _buildStat(
                  'Streak',
                  '${entry.streakDays} days',
                  Icons.local_fire_department,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryGreen, size: 28),
        const SizedBox(height: 8),
        Countup(
          begin: 0,
          end: double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0,
          duration: const Duration(seconds: 2),
          separator: ',',
          suffix: value.contains('\$') ? '' : '',
          style: AppTheme.heading2.copyWith(
            color: AppTheme.primaryGreen,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textLight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardEntry(
    BuildContext context,
    LeaderboardEntry entry,
    int index,
  ) {
    final isTopThree = index < 3;
    final medalColors = [
      AppTheme.warningYellow,
      AppTheme.textLight,
      AppTheme.primaryRed,
    ];

    return Container(
      margin: EdgeInsets.only(
        bottom: 8,
        left: isTopThree ? 0 : 16,
        right: isTopThree ? 0 : 16,
      ),
      child: Card(
        elevation: isTopThree ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
          side: isTopThree
              ? BorderSide(
                  color: medalColors[index].withOpacity(0.5),
                  width: 2,
                )
              : BorderSide.none,
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Rank and Avatar
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isTopThree)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: medalColors[index].withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.emoji_events,
                        color: medalColors[index],
                        size: 24,
                      ),
                    ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    backgroundImage: entry.userPhotoUrl != null ? NetworkImage(entry.userPhotoUrl!) : null,
                    child: entry.userPhotoUrl == null ? Text(entry.userName[0].toUpperCase()) : null,
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Name and Stats
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.userName,
                      style: AppTheme.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isTopThree ? medalColors[index] : AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.play_circle,
                          size: 16,
                          color: AppTheme.primaryGreen,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${entry.videosCompleted} videos',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '\Rs ${entry.moneyEarned.toStringAsFixed(0)}',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Rank Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isTopThree ? medalColors[index].withOpacity(0.2) : AppTheme.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                ),
                child: Text(
                  '#${entry.rank}',
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isTopThree ? medalColors[index] : AppTheme.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
