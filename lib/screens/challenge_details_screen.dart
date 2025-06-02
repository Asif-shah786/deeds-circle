import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/challenge.dart';
import '../models/user_challenge.dart';
import '../providers/challenges_provider.dart';
import '../theme/app_theme.dart';

class ChallengeDetailsScreen extends ConsumerStatefulWidget {
  final String challengeId;

  const ChallengeDetailsScreen({
    super.key,
    required this.challengeId,
  });

  @override
  ConsumerState<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends ConsumerState<ChallengeDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Load challenges when screen opens
    Future.microtask(() => ref.read(challengesProvider.notifier).loadChallenges());
  }

  @override
  Widget build(BuildContext context) {
    final challengesState = ref.watch(challengesProvider);

    if (challengesState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (challengesState.error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: ${challengesState.error}',
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(challengesProvider.notifier).loadChallenges();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final challenge = challengesState.challenges.firstWhere(
      (c) => c.id == widget.challengeId,
      orElse: () => throw Exception('Challenge not found'),
    );

    final userChallenge = challengesState.userChallenges[widget.challengeId];
    final isJoined = userChallenge != null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Hero App Bar
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final top = constraints.biggest.height;
                final expandedHeight = 300.0;
                final collapsedHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
                final expanded = top > collapsedHeight;

                return FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                    left: expanded ? 16 : 72,
                    bottom: 16,
                    right: 16,
                  ),
                  centerTitle: false,
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: expanded ? 1.0 : 0.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        challenge.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Image or Gradient
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppTheme.primaryGreen,
                              AppTheme.primaryGreen.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                      // Overlay Pattern
                      Opacity(
                        opacity: 0.1,
                        child: Image.network(
                          'https://www.transparenttextures.com/patterns/cubes.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Challenge Icon
                      const Center(
                        child: Icon(
                          Icons.emoji_events,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                      // Bottom Gradient Overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Challenge Content
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Stats Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            _buildStatItem(
                              icon: Icons.video_library,
                              value: challenge.totalVideos.toString(),
                              label: 'Videos',
                            ),
                            const SizedBox(width: 24),
                            _buildStatItem(
                              icon: Icons.monetization_on,
                              value: '₹${challenge.rewardAmount}',
                              label: 'Per Video',
                            ),
                            const SizedBox(width: 24),
                            _buildStatItem(
                              icon: Icons.timer,
                              value: '30 Days',
                              label: 'Duration',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Purpose Section
                    _buildSection(
                      title: 'Purpose',
                      content: challenge.purpose,
                      icon: Icons.lightbulb_outline,
                    ),
                    const SizedBox(height: 24),
                    // Description Section
                    _buildSection(
                      title: 'Description',
                      content: challenge.description,
                      icon: Icons.description_outlined,
                    ),
                    const SizedBox(height: 24),
                    // Topics Section
                    if (challenge.keywords.isNotEmpty)
                      _buildSection(
                        title: 'Topics',
                        content: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: challenge.keywords.map((keyword) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppTheme.primaryGreen.withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                keyword,
                                style: TextStyle(
                                  color: AppTheme.primaryGreen,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        icon: Icons.tag_outlined,
                      ),
                    if (challenge.keywords.isNotEmpty) const SizedBox(height: 24),
                    // Rewards Section
                    _buildSection(
                      title: 'Rewards',
                      content: Column(
                        children: [
                          _buildRewardCard(
                            title: 'Per Video Reward',
                            amount: challenge.rewardAmount,
                            icon: Icons.monetization_on_outlined,
                          ),
                          const SizedBox(height: 16),
                          _buildRewardCard(
                            title: 'Total Possible Earning',
                            amount: challenge.rewardAmount * challenge.totalVideos,
                            icon: Icons.account_balance_wallet_outlined,
                            isHighlighted: true,
                          ),
                        ],
                      ),
                      icon: Icons.monetization_on_outlined,
                    ),
                    const SizedBox(height: 24),
                    // Timeline Section
                    if (challenge.startDate != null || challenge.endDate != null)
                      _buildSection(
                        title: 'Timeline',
                        content: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                if (challenge.startDate != null)
                                  _buildTimelineItem(
                                    icon: Icons.play_circle_outline,
                                    title: 'Start Date',
                                    date: _formatDate(challenge.startDate!),
                                  ),
                                if (challenge.startDate != null && challenge.endDate != null)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Divider(),
                                  ),
                                if (challenge.endDate != null)
                                  _buildTimelineItem(
                                    icon: Icons.stop_outlined,
                                    title: 'End Date',
                                    date: _formatDate(challenge.endDate!),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        icon: Icons.calendar_today_outlined,
                      ),
                    if (challenge.startDate != null || challenge.endDate != null) const SizedBox(height: 24),
                    // Host Section
                    _buildSection(
                      title: 'Challenge Host',
                      content: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
                            child: const Icon(
                              Icons.person_outline,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                          title: const Text('Admin Name'),
                          subtitle: const Text('Challenge Creator'),
                        ),
                      ),
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 32),
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (isJoined) {
                                ref.read(challengesProvider.notifier).leaveChallenge(widget.challengeId);
                              } else {
                                ref.read(challengesProvider.notifier).joinChallenge(widget.challengeId);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isJoined ? Colors.grey.shade200 : AppTheme.primaryGreen,
                              foregroundColor: isJoined ? AppTheme.textDark : Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: isJoined ? 0 : 2,
                            ),
                            child: Text(
                              isJoined ? 'Leave Challenge' : 'Join Challenge',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        if (isJoined)
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.push('/challenges/${widget.challengeId}/videos');
                              },
                              icon: const Icon(Icons.play_circle_outline),
                              label: const Text('Start Learning'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryGreen,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required dynamic content,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppTheme.primaryGreen, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppTheme.heading3,
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (content is String)
          Text(
            content,
            style: AppTheme.bodyLarge,
          )
        else
          content as Widget,
      ],
    );
  }

  Widget _buildRewardCard({
    required String title,
    required double amount,
    required IconData icon,
    bool isHighlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlighted ? AppTheme.primaryGreen.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlighted ? AppTheme.primaryGreen : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isHighlighted ? AppTheme.primaryGreen : AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isHighlighted ? Colors.white : AppTheme.primaryGreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: isHighlighted ? AppTheme.primaryGreen : AppTheme.textLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isHighlighted ? AppTheme.primaryGreen : AppTheme.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String title,
    required String date,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryGreen,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
