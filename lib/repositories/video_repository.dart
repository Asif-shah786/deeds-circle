import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/video.dart';

class VideoRepository {
  final FirebaseFirestore _firestore;

  VideoRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Video>> getVideosForChallenge(String challengeId) async {
    try {
      print('Fetching videos for challenge: $challengeId');
      final snapshot =
          await _firestore.collection('challenges').doc(challengeId).collection('videos').orderBy('order').get();

      print('Found ${snapshot.docs.length} videos');

      final videos = snapshot.docs.map((doc) {
        final data = doc.data();
        print('Video data: $data');
        return Video(
          id: doc.id,
          title: data['title'] as String,
          description: data['description'] as String?,
          videoUrl: data['videoUrl'] as String,
          order: data['order'] as int,
          durationSeconds: data['durationSeconds'] as int,
          challengeId: challengeId,
        );
      }).toList();

      print('Parsed ${videos.length} videos');
      return videos;
    } catch (e) {
      print('Error fetching videos: $e');
      throw Exception('Failed to get videos: $e');
    }
  }

  Future<Video?> getVideo(String challengeId, String videoId) async {
    try {
      final doc = await _firestore.collection('challenges').doc(challengeId).collection('videos').doc(videoId).get();

      if (!doc.exists) return null;

      final data = doc.data()!;
      return Video(
        id: doc.id,
        title: data['title'] as String,
        description: data['description'] as String?,
        videoUrl: data['videoUrl'] as String,
        order: data['order'] as int,
        durationSeconds: data['durationSeconds'] as int,
        challengeId: challengeId,
      );
    } catch (e) {
      throw Exception('Failed to get video: $e');
    }
  }
}
