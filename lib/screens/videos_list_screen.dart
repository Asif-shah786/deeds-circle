import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/challenge.dart';
import '../models/user_challenge.dart';
import '../models/video.dart';
import '../providers/challenges_provider.dart';
import '../providers/repository_providers.dart';
import '../theme/app_theme.dart';
import '../utils/currency_formatter.dart';
import '../widgets/duolingo_toast_helper.dart';
import 'dart:async';

final videosProvider = FutureProvider.family<List<Video>, String>((ref, challengeId) async {
  print('VideosProvider: Fetching videos for challenge $challengeId');
  final videoRepo = ref.watch(videoRepositoryProvider);
  final videos = await videoRepo.getVideosForChallenge(challengeId);
  print('VideosProvider: Got ${videos.length} videos');
  for (final video in videos) {
    print('Video: ${video.title} - URL: ${video.videoUrl}');
  }
  return videos;
});

class VideosListScreen extends ConsumerStatefulWidget {
  final String challengeId;

  const VideosListScreen({
    super.key,
    required this.challengeId,
  });

  @override
  ConsumerState<VideosListScreen> createState() => _VideosListScreenState();
}

class _VideosListScreenState extends ConsumerState<VideosListScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  String? _lastCompletedVideoId;
  bool _showCelebration = false;
  bool _showChallengeCompletion = false;

  @override
  void initState() {
    super.initState();
    print('VideosListScreen: Initializing with challengeId ${widget.challengeId}');
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    // Load challenges when screen opens
    Future.microtask(() => ref.read(challengesProvider.notifier).loadChallenges());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showCompletionAnimation(String videoId) {
    setState(() {
      _lastCompletedVideoId = videoId;
      _showCelebration = true;
    });
    _animationController.forward().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showCelebration = false;
          });
        }
      });
    });
  }

  void _showChallengeCompletionCelebration() {
    setState(() {
      _showChallengeCompletion = true;
    });
    _animationController.forward();
  }

  @override
  void didUpdateWidget(VideosListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if challenge was just completed
    final challengesState = ref.read(challengesProvider);
    final userChallenge = challengesState.userChallenges[widget.challengeId];
    if (userChallenge != null && userChallenge.status == 'completed' && !_showChallengeCompletion) {
      _showChallengeCompletionCelebration();
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
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

    if (userChallenge == null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 64,
                  color: AppTheme.textLight,
                ),
                const SizedBox(height: 24),
                Text(
                  'Join Challenge to View Videos',
                  style: AppTheme.heading2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  challenge.description,
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textLight,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  'Reward: ₹${challenge.rewardAmount} per video',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    ref.read(challengesProvider.notifier).joinChallenge(widget.challengeId);
                  },
                  style: AppTheme.primaryButtonStyle,
                  child: const Text('Join Challenge'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(challenge.title),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Challenge Info Card
              Container(
                padding: const EdgeInsets.all(16),
                color: AppTheme.primaryGreen.withOpacity(0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Challenge Progress',
                      style: AppTheme.heading3,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userChallenge.completedVideoIds.length}/${challenge.totalVideos} Videos',
                                style: AppTheme.bodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${userChallenge.earnedAmount} earned',
                                style: AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.primaryGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${(userChallenge.completedVideoIds.length / challenge.totalVideos * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              color: AppTheme.primaryGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: userChallenge.completedVideoIds.length / challenge.totalVideos,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
              // Videos List
              Expanded(
                child: ref.watch(videosProvider(widget.challengeId)).when(
                      data: (videos) => ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          final Video video = videos[index];
                          final completedVideos = userChallenge.completedVideoIds.length;
                          final isCompleted = userChallenge.completedVideoIds.contains(video.id);
                          final isCurrentVideo = index == completedVideos;
                          final isUnlocked = index == 0 || completedVideos >= index;
                          final isLocked = !isUnlocked;
                          final isNewlyCompleted = video.id == _lastCompletedVideoId;

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: isCurrentVideo
                                  ? const BorderSide(
                                      color: AppTheme.primaryGreen,
                                      width: 2,
                                    )
                                  : BorderSide.none,
                            ),
                            child: InkWell(
                              onTap: isLocked
                                  ? null
                                  : () async {
                                      await context.push('/challenges/${widget.challengeId}/videos/${video.id}');
                                      // Check if video was completed
                                      final updatedState = ref.read(challengesProvider);
                                      final updatedUserChallenge = updatedState.userChallenges[widget.challengeId];
                                      if (updatedUserChallenge != null &&
                                          updatedUserChallenge.completedVideoIds.contains(video.id) &&
                                          !isCompleted) {
                                        _showCompletionAnimation(video.id);
                                      }
                                    },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    // Video Thumbnail
                                    Container(
                                      width: 120,
                                      height: 68,
                                      decoration: BoxDecoration(
                                        color: isLocked
                                            ? AppTheme.progressLocked.withOpacity(0.1)
                                            : AppTheme.primaryBlue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          if (!isLocked)
                                            Icon(
                                              isCurrentVideo ? Icons.play_circle : Icons.play_circle_outline,
                                              size: 32,
                                              color: isCurrentVideo ? AppTheme.primaryGreen : AppTheme.primaryBlue,
                                            ),
                                          if (isLocked)
                                            const Icon(
                                              Icons.lock,
                                              size: 24,
                                              color: AppTheme.progressLocked,
                                            ),
                                          if (isNewlyCompleted && _showCelebration)
                                            ScaleTransition(
                                              scale: _scaleAnimation,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppTheme.completedColor.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: const Icon(
                                                  Icons.check_circle,
                                                  color: AppTheme.completedColor,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Video Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            video.title,
                                            style: AppTheme.bodyMedium.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: isLocked ? AppTheme.textLight : AppTheme.textDark,
                                            ),
                                          ),
                                          if (video.description != null) ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              video.description!,
                                              style: AppTheme.bodySmall.copyWith(
                                                color: AppTheme.textLight,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.account_balance_wallet,
                                                size: 14,
                                                color: AppTheme.primaryGreen,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '₹${challenge.rewardAmount}',
                                                style: AppTheme.bodySmall.copyWith(
                                                  color: AppTheme.primaryGreen,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Icon(
                                                Icons.timer,
                                                size: 14,
                                                color: AppTheme.textLight,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                _formatDuration(video.durationSeconds),
                                                style: AppTheme.bodySmall.copyWith(
                                                  color: AppTheme.textLight,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (isCompleted) ...[
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.check_circle,
                                                  size: 16,
                                                  color: AppTheme.completedColor,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  'Completed',
                                                  style: AppTheme.bodySmall.copyWith(
                                                    color: AppTheme.completedColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ] else if (isCurrentVideo) ...[
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
                                                  'Continue Here',
                                                  style: AppTheme.bodySmall.copyWith(
                                                    color: AppTheme.primaryGreen,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    // Status Icon
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: isCompleted
                                            ? AppTheme.completedColor.withOpacity(0.1)
                                            : isCurrentVideo
                                                ? AppTheme.primaryGreen.withOpacity(0.1)
                                                : isLocked
                                                    ? AppTheme.progressLocked.withOpacity(0.1)
                                                    : AppTheme.primaryBlue.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isCompleted
                                            ? Icons.check_circle
                                            : isCurrentVideo
                                                ? Icons.play_circle
                                                : isLocked
                                                    ? Icons.lock
                                                    : Icons.play_circle_outline,
                                        color: isCompleted
                                            ? AppTheme.completedColor
                                            : isCurrentVideo
                                                ? AppTheme.primaryGreen
                                                : isLocked
                                                    ? AppTheme.progressLocked
                                                    : AppTheme.primaryBlue,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => Center(
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
                              error.toString(),
                              style: const TextStyle(color: AppTheme.errorRed),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            ],
          ),
          // Celebration Overlay
          if (_showCelebration)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.completedColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.celebration,
                              color: Colors.white,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Video Completed!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '₹${challenge.rewardAmount} added to your balance',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (_showChallengeCompletion)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.8),
                child: Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      margin: const EdgeInsets.all(24),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.emoji_events,
                              color: AppTheme.primaryGreen,
                              size: 64,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Challenge Completed!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'You\'ve earned ${CurrencyFormatter.format(userChallenge.earnedAmount)}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppTheme.textLight,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showChallengeCompletion = false;
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    side: const BorderSide(color: AppTheme.primaryGreen),
                                  ),
                                  child: const Text('Continue'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.go('/home');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGreen,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: const Text('Go to Home'),
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
            ),
        ],
      ),
    );
  }
}
