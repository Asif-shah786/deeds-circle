import 'package:cloud_firestore/cloud_firestore.dart';

class TestDataGenerator {
  static final _firestore = FirebaseFirestore.instance;

  // Create test users with different scenarios
  static Future<void> createTestUsers() async {
    final users = [
      {
        'id': 'user_001',
        'displayName': 'Test User 1',
        'email': 'test1@gmail.com',
        'photoUrl': 'https://example.com/photo1.jpg',
        'bio': 'Test user 1 bio',
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
        'totalCompletedVideos': 0,
        'totalEarnings': 0.0,
        'totalPaid': 0.0,
        'points': 0,
        'isAdmin': false,
        'preferredLanguage': 'en',
        'bankAccountDetails': null,
      },
      {
        'id': 'user_002',
        'displayName': 'Test User 2',
        'email': 'test2@gmail.com',
        'photoUrl': null,
        'bio': 'Test user 2 bio',
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
        'totalCompletedVideos': 5,
        'totalEarnings': 100.0,
        'totalPaid': 50.0,
        'points': 500,
        'isAdmin': false,
        'preferredLanguage': 'ur',
        'bankAccountDetails': {
          'accountHolderName': 'Test User 2',
          'accountNumber': '1234567890',
          'ifscCode': 'TEST0001234',
          'bankName': 'Test Bank',
        },
      },
      {
        'id': 'admin_001',
        'displayName': 'Admin User',
        'email': 'admin@gmail.com',
        'photoUrl': 'https://example.com/admin.jpg',
        'bio': 'Admin user bio',
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
        'totalCompletedVideos': 0,
        'totalEarnings': 0.0,
        'totalPaid': 0.0,
        'points': 0,
        'isAdmin': true,
        'preferredLanguage': 'en',
        'bankAccountDetails': null,
      },
    ];

    for (final user in users) {
      await _firestore.collection('users').doc(user['id'] as String).set(user);
      print('Created test user: ${user['email']}');
    }
  }

  // Create test challenges with different scenarios
  static Future<List<Map<String, dynamic>>> createTestChallenges() async {
    final challenges = [
      {
        'id': 'challenge_001',
        'title': 'Quran Tafseer in Urdu – Dr. Israr Ahmed',
        'description': 'Complete Quran Tafseer series by Dr. Israr Ahmed',
        'admins': ['admin_001'],
        'primaryAdminId': 'admin_001',
        'isPublic': true,
        'thumbnailUrl':
            'https://i.ytimg.com/vi/16aMSt13jfA/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLCGsiQH5CbQfhLRqkhpwllovFmbfg',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'keywords': ['quran', 'tafseer', 'urdu', 'dr israr'],
        'rewardAmount': 100.0,
        'totalVideos': 5,
        'totalPossibleEarning': 500.0,
        'purpose': 'Learn Quran Tafseer in Urdu',
        'startDate': FieldValue.serverTimestamp(),
        'endDate': null,
      },
      {
        'id': 'challenge_002',
        'title': 'Quran Tafseer Series 2',
        'description': 'Another Quran Tafseer series for testing',
        'admins': ['admin_001'],
        'primaryAdminId': 'admin_001',
        'isPublic': true,
        'thumbnailUrl': null,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'keywords': ['quran', 'tafseer', 'urdu'],
        'rewardAmount': 150.0,
        'totalVideos': 3,
        'totalPossibleEarning': 450.0,
        'purpose': 'Learn Quran Tafseer in Urdu - Advanced',
        'startDate': FieldValue.serverTimestamp(),
        'endDate': FieldValue.serverTimestamp(),
      },
      {
        'id': 'challenge_003',
        'title': 'Private Challenge',
        'description': 'A private challenge for testing',
        'admins': ['admin_001'],
        'primaryAdminId': 'admin_001',
        'isPublic': false,
        'thumbnailUrl': null,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'keywords': ['private', 'test'],
        'rewardAmount': 200.0,
        'totalVideos': 2,
        'totalPossibleEarning': 400.0,
        'purpose': 'Testing private challenges',
        'startDate': FieldValue.serverTimestamp(),
        'endDate': null,
      },
    ];

    for (final challenge in challenges) {
      await _firestore.collection('challenges').doc(challenge['id'] as String).set(challenge);
      print('Created test challenge: ${challenge['title']}');
    }

    return challenges;
  }

  // Create test videos for a challenge
  static Future<void> createTestVideos(String challengeId) async {
    final videos = [
      {
        'id': challengeId,
        'title': '001 of 108 - Quran Tafseer in Urdu - Introduction',
        'description': 'Introduction to Quran Tafseer series',
        'videoUrl': 'https://www.youtube.com/watch?v=j7-pVr2G-6w',
        'order': 1,
        'durationSeconds': 3680, // 1:01:20
      },
      {
        'id': challengeId,
        'title': '002 of 108 - Quran Tafseer in Urdu',
        'description': 'Second video in the series',
        'videoUrl': 'https://www.youtube.com/watch?v=ALb_HvSPiJM',
        'order': 2,
        'durationSeconds': 3494, // 58:14
      },
      {
        'id': challengeId,
        'title': '003 of 108 - Quran Tafseer in Urdu',
        'description': 'Third video in the series',
        'videoUrl': 'https://www.youtube.com/watch?v=Xb93YzKDw-g',
        'order': 3,
        'durationSeconds': 3558, // 59:18
      },
    ];

    // Add videos to the challenge's videos subcollection
    for (final video in videos) {
      await _firestore.collection('challenges').doc(challengeId).collection('videos').add(video);
      print('Created test video: ${video['title']}');
    }
  }

  // Create test user challenges with different scenarios
  static Future<void> createTestUserChallenges() async {
    final userChallenges = [
      // New user challenge
      {
        'id': 'user_001_challenge_001',
        'userId': 'user_001',
        'challengeId': 'challenge_001',
        'joinedAt': FieldValue.serverTimestamp(),
        'status': 'active',
        'completedVideoIds': [],
        'lastUpdated': FieldValue.serverTimestamp(),
        'earnedAmount': 0.0,
        'paidAmount': 0.0,
        'lastCompletedVideo': null,
        'streakDays': 0,
      },
      // User with some progress
      {
        'id': 'user_002_challenge_001',
        'userId': 'user_002',
        'challengeId': 'challenge_001',
        'joinedAt': FieldValue.serverTimestamp(),
        'status': 'active',
        'completedVideoIds': ['challenge_001_video_001', 'challenge_001_video_002'],
        'lastUpdated': FieldValue.serverTimestamp(),
        'earnedAmount': 200.0,
        'paidAmount': 100.0,
        'lastCompletedVideo': {
          'videoId': 'challenge_001_video_002',
          'completedAt': FieldValue.serverTimestamp(),
          'title': '002 of 108 - Quran Tafseer in Urdu',
        },
        'streakDays': 2,
      },
      // Completed challenge
      {
        'id': 'user_002_challenge_002',
        'userId': 'user_002',
        'challengeId': 'challenge_002',
        'joinedAt': FieldValue.serverTimestamp(),
        'status': 'completed',
        'completedVideoIds': ['challenge_002_video_001', 'challenge_002_video_002', 'challenge_002_video_003'],
        'lastUpdated': FieldValue.serverTimestamp(),
        'earnedAmount': 450.0,
        'paidAmount': 450.0,
        'lastCompletedVideo': {
          'videoId': 'challenge_002_video_003',
          'completedAt': FieldValue.serverTimestamp(),
          'title': '003 of 108 - Quran Tafseer in Urdu',
        },
        'streakDays': 3,
      },
    ];

    for (final userChallenge in userChallenges) {
      await _firestore.collection('user_challenges').doc(userChallenge['id'] as String).set(userChallenge);
      print('Created test user challenge: ${userChallenge['id']}');
    }
  }

  // Main test function to run all generators
  static Future<void> generateAllTestData() async {
    try {
      // Create test users
      await createTestUsers();

      // Create test challenges
      final challenges = await createTestChallenges();

      // Create test videos for each challenge
      for (final challenge in challenges) {
        await createTestVideos(challenge['id'] as String);
      }

      // Create test user challenges
      await createTestUserChallenges();

      print('All test data generated successfully!');
    } catch (e) {
      print('Error generating test data: $e');
    }
  }
}
