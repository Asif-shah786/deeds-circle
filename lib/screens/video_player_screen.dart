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
  bool _showCompletionStatus = false;
  static const double _requiredWatchPercentage = 0.5; // 50% of video
  Duration _lastPosition = Duration.zero;
  DateTime? _lastProgressCheck;
  Video? _currentVideo;
  Duration _totalWatchTime = Duration.zero;
  bool _isPlaying = false;
  String? _currentSessionId;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _checkInitialCompletionStatus();
    _loadWatchProgress();
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
    _saveWatchProgress();
    _controller?.dispose();
    super.dispose();
  }

  String _getVideoId(String url) {
    return YoutubePlayer.convertUrlToId(url) ?? '';
  }

  String _generateSessionId() {
    return '${widget.challengeId}_${widget.videoId}_${DateTime.now().millisecondsSinceEpoch}';
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
    _currentSessionId = _generateSessionId();

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

    // Add listener for video progress and completion
    _controller!.addListener(() {
      final isPlaying = _controller!.value.isPlaying;
      if (isPlaying != _isPlaying) {
        _isPlaying = isPlaying;
        if (!isPlaying) {
          // Save current watch time when video is paused
          _saveWatchProgress();
        }
      }

      if (isPlaying) {
        final position = _controller!.value.position;
        _onVideoProgress(position);
      }

      // Check for fullscreen state
      final isFullScreen = _controller!.value.isFullScreen;
      if (isFullScreen != _isFullScreen) {
        setState(() {
          _isFullScreen = isFullScreen;
        });
      }
    });

    // Load previous progress and seek to last position
    await _loadWatchProgress();
    if (_lastPosition > Duration.zero) {
      _controller!.seekTo(_lastPosition);
    }

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  void _onVideoProgress(Duration position) {
    // Rate limiting - only check once per second
    final now = DateTime.now();
    if (_lastProgressCheck != null && now.difference(_lastProgressCheck!) < const Duration(seconds: 1)) {
      return;
    }
    _lastProgressCheck = now;

    // Verify video is actually playing (position is increasing)
    if (position <= _lastPosition) {
      return;
    }

    // Calculate watch time for this session
    final watchTime = position - _lastPosition;
    _totalWatchTime += watchTime;
    _lastPosition = position;

    // Get video data if not already available
    if (_currentVideo == null) {
      final videoAsync = ref.read(videoProvider((widget.challengeId, widget.videoId)));
      videoAsync.whenData((video) {
        if (video != null) {
          _currentVideo = video;
          _checkProgress();
        }
      });
    } else {
      _checkProgress();
    }
  }

  void _checkProgress() {
    if (!_isCompleted && _currentVideo != null) {
      // Ensure video duration is valid
      if (_currentVideo!.durationSeconds <= 0) {
        print('Warning: Invalid video duration: ${_currentVideo!.durationSeconds}');
        return;
      }

      final progress = _totalWatchTime.inSeconds / _currentVideo!.durationSeconds;

      // Log progress for debugging
      print(
          'Video progress: ${(progress * 100).toStringAsFixed(1)}% (Total watch time: ${_totalWatchTime.inSeconds}s)');

      if (progress >= _requiredWatchPercentage) {
        print('Reached completion threshold');
        _markVideoAsCompleted();
      }
    }
  }

  Future<void> _saveWatchProgress() async {
    if (_currentVideo == null || _currentSessionId == null) return;

    try {
      final user = ref.read(authStateProvider).value;
      if (user == null) return;

      // Save progress to Firestore with challenge and session specific data
      await FirebaseFirestore.instance
          .collection('user_video_progress')
          .doc('${user.uid}_${widget.challengeId}_${widget.videoId}')
          .set({
        'userId': user.uid,
        'videoId': widget.videoId,
        'challengeId': widget.challengeId,
        'sessionId': _currentSessionId,
        'totalWatchTime': _totalWatchTime.inSeconds,
        'lastPosition': _lastPosition.inSeconds,
        'lastUpdated': FieldValue.serverTimestamp(),
        'isCompleted': _isCompleted,
        'videoDuration': _currentVideo?.durationSeconds,
      }, SetOptions(merge: true));

      print(
          'Saved watch progress: ${_totalWatchTime.inSeconds}s at position ${_lastPosition.inSeconds}s for video ${widget.videoId} in challenge ${widget.challengeId}');
    } catch (e) {
      print('Error saving watch progress: $e');
    }
  }

  Future<void> _loadWatchProgress() async {
    try {
      final user = ref.read(authStateProvider).value;
      if (user == null) return;

      // Load progress for this specific challenge-video combination
      final doc = await FirebaseFirestore.instance
          .collection('user_video_progress')
          .doc('${user.uid}_${widget.challengeId}_${widget.videoId}')
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        _totalWatchTime = Duration(seconds: data['totalWatchTime'] ?? 0);
        _lastPosition = Duration(seconds: data['lastPosition'] ?? 0);

        // If video was already completed in this challenge, mark it as completed
        if (data['isCompleted'] == true) {
          if (mounted) {
            setState(() {
              _isCompleted = true;
            });
          }
        }

        print(
            'Loaded watch progress: ${_totalWatchTime.inSeconds}s at position ${_lastPosition.inSeconds}s for video ${widget.videoId} in challenge ${widget.challengeId}');

        // Check progress with loaded watch time
        if (_currentVideo != null) {
          _checkProgress();
        }
      } else {
        // If no progress exists for this challenge-video combination, start fresh
        _totalWatchTime = Duration.zero;
        _lastPosition = Duration.zero;
        print('No previous progress found for video ${widget.videoId} in challenge ${widget.challengeId}');
      }
    } catch (e) {
      print('Error loading watch progress: $e');
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

      // Double check if we've watched enough
      if (_totalWatchTime.inSeconds < (video.durationSeconds * _requiredWatchPercentage)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please watch at least 50% of the video'),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
        return;
      }

      // Check if video is already completed in this challenge
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

      // Verify one last time that the video hasn't been completed in this challenge
      final doc = await FirebaseFirestore.instance.collection('user_challenges').doc(userChallengeId).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final completedVideos = List<String>.from(data['completedVideoIds'] ?? []);
        if (completedVideos.contains(widget.videoId)) {
          if (mounted) {
            setState(() {
              _isCompleted = true;
            });
          }
          return;
        }
      }

      // Log completion attempt
      print('Marking video as completed: ${video.title} in challenge ${widget.challengeId}');

      await ref.read(userChallengeRepositoryProvider).markVideoAsCompleted(
            userChallengeId,
            widget.videoId,
            video.title,
          );

      // Save completion status to progress document
      await _saveWatchProgress();

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
      print('Error marking video as completed: $e');
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
                            progressColors: ProgressBarColors(
                              playedColor: AppTheme.primaryGreen,
                              handleColor: AppTheme.primaryGreen,
                              backgroundColor: Colors.grey[300],
                              bufferedColor: AppTheme.primaryGreen.withOpacity(0.3),
                            ),
                            onReady: () {
                              if (_lastPosition > Duration.zero) {
                                _controller!.seekTo(_lastPosition);
                              }
                              _checkInitialCompletionStatus();
                            },
                            onEnded: (data) {
                              _markVideoAsCompleted();
                            },
                          ),
                          builder: (context, player) {
                            return Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: player,
                                ),
                                if (!_isFullScreen) ...[
                                  // Video Title and Back Button
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 8, bottom: 12),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                      child: SafeArea(
                                        child: Column(
                                          children: [
                                            // Title and Back Button Row
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Row(
                                                children: [
                                                  IconButton(
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
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      video.title,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Completion Toast
                                  if (_showCompletionStatus)
                                    Positioned(
                                      top: 16,
                                      left: 16,
                                      right: 16,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryGreen.withOpacity(0.9),
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
                                              'Video completed!',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ],
                            );
                          },
                        )
                      : Container(
                          color: Colors.black,
                          child: const Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                color: AppTheme.primaryGreen,
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
          loading: () => Container(
            color: Colors.black,
            child: const Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: AppTheme.primaryGreen,
                  strokeWidth: 3,
                ),
              ),
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
