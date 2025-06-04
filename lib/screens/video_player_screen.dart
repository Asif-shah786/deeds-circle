import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/video.dart';
import '../providers/repository_providers.dart';
import '../providers/challenges_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/duolingo_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/auth_provider.dart';

final videoProvider = FutureProvider.family<Video?, (String, String)>((ref, params) async {
  final (challengeId, videoId) = params;
  final videoRepo = ref.watch(videoRepositoryProvider);
  return await videoRepo.getVideo(challengeId, videoId);
});

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final String challengeId;
  final String videoId;

  const VideoPlayerScreen({
    super.key,
    required this.challengeId,
    required this.videoId,
  });

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  YoutubePlayerController? _controller;
  bool _isInitialized = false;
  bool _isCompleted = false;
  bool _hasReachedThreshold = false;
  bool _showCompletionStatus = false;
  static const int _requiredWatchSeconds = 10; // Must watch 10 seconds

  @override
  void initState() {
    super.initState();
    _checkInitialCompletionStatus();
  }

  Future<void> _checkInitialCompletionStatus() async {
    final challengesState = ref.read(challengesProvider);
    final userChallenge = challengesState.userChallenges[widget.challengeId];
    if (userChallenge != null && userChallenge.completedVideoIds.contains(widget.videoId)) {
      if (mounted) {
        setState(() {
          _isCompleted = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String _getVideoId(String url) {
    return YoutubePlayer.convertUrlToId(url) ?? '';
  }

  Future<void> _initializePlayer(String videoUrl) async {
    final videoId = _getVideoId(videoUrl);
    if (videoId.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid video URL'),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
      return;
    }

    _controller?.dispose();

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        showLiveFullscreenButton: true,
        useHybridComposition: true,
      ),
    );

    // Add listeners for video progress and completion
    _controller!.addListener(() {
      if (_controller!.value.isPlaying) {
        final position = _controller!.value.position;
        _onVideoProgress(position);
      }
    });

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  void _onVideoProgress(Duration position) {
    // Check if we've watched 10 seconds
    if (!_hasReachedThreshold && position.inSeconds >= _requiredWatchSeconds) {
      _hasReachedThreshold = true;
      _markVideoAsCompleted();
    }
  }

  Future<void> _markVideoAsCompleted() async {
    if (_isCompleted) return;

    try {
      final challengesState = ref.read(challengesProvider);
      final userChallenge = challengesState.userChallenges[widget.challengeId];

      if (userChallenge == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Challenge not found'),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
        return;
      }

      // Get the video first to ensure it exists
      final video = await ref.read(videoProvider((widget.challengeId, widget.videoId)).future);
      if (video == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Video not found'),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
        return;
      }

      // Only mark as completed if we've watched enough
      if (!_hasReachedThreshold) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please watch at least 10 seconds of the video'),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
        return;
      }

      // Check if video is already completed
      if (userChallenge.completedVideoIds.contains(widget.videoId)) {
        if (mounted) {
          setState(() {
            _isCompleted = true;
          });
        }
        return;
      }

      // Get the user challenge ID from Firestore if it's empty
      String userChallengeId = userChallenge.id;
      if (userChallengeId.isEmpty) {
        final user = ref.read(authStateProvider).value;
        if (user == null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User not authenticated'),
                backgroundColor: AppTheme.errorRed,
              ),
            );
          }
          return;
        }

        // Query Firestore to get the user challenge ID
        final querySnapshot = await FirebaseFirestore.instance
            .collection('user_challenges')
            .where('userId', isEqualTo: user.uid)
            .where('challengeId', isEqualTo: widget.challengeId)
            .limit(1)
            .get();

        if (querySnapshot.docs.isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User challenge not found in Firestore'),
                backgroundColor: AppTheme.errorRed,
              ),
            );
          }
          return;
        }

        userChallengeId = querySnapshot.docs.first.id;
      }

      await ref.read(userChallengeRepositoryProvider).markVideoAsCompleted(
            userChallengeId,
            widget.videoId,
            video.title,
          );

      // Refresh challenges state
      await ref.read(challengesProvider.notifier).loadChallenges();

      if (mounted) {
        setState(() {
          _isCompleted = true;
          _showCompletionStatus = true;
        });

        // Show Duolingo-style toast
        if (context.mounted) {
          DuolingoToastHelper.show(
            context: context,
            message: 'Video completed!',
            subMessage: 'Reward added to your balance',
            icon: Icons.check_circle,
            backgroundColor: AppTheme.primaryGreen,
          );
        }

        // Hide completion status after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _showCompletionStatus = false;
            });
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error marking video as completed: $e'),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoAsync = ref.watch(videoProvider((widget.challengeId, widget.videoId)));

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: videoAsync.when(
          data: (video) {
            if (video == null) {
              return const Center(
                child: Text(
                  'Video not found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            if (!_isInitialized) {
              _initializePlayer(video.videoUrl);
            }

            return Stack(
              children: [
                // Video Player
                Center(
                  child: _isInitialized && _controller != null
                      ? YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: _controller!,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: AppTheme.primaryGreen,
                            onReady: () {
                              // Check if video is already completed when player is ready
                              _checkInitialCompletionStatus();
                            },
                            onEnded: (data) {
                              // Mark as completed when video ends
                              _markVideoAsCompleted();
                            },
                          ),
                          builder: (context, player) {
                            return AspectRatio(
                              aspectRatio: 16 / 9,
                              child: player,
                            );
                          },
                        )
                      : const CircularProgressIndicator(
                          color: AppTheme.primaryGreen,
                        ),
                ),
                // Back Button
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                // Video Info
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      video.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Completion Status
                if (_showCompletionStatus)
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.completedColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Video Completed',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryGreen,
            ),
          ),
          error: (error, stack) => Center(
            child: Text(
              'Error: $error',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
