import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'router/app_router.dart';
import 'admin/main_admin.dart';
import 'admin/test_data_generator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await _createChallengeFromJson();

  runApp(
    const ProviderScope(
      child: kIsWeb ? MainAdmin() : MobileApp(),
    ),
  );
}

class MobileApp extends ConsumerWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Deeds Circle',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

Future<void> _createChallengeFromJson() async {
  try {
    // Load the JSON file
    final String jsonString = await rootBundle.loadString('lib/admin/short_challenge.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    // Get the challenge data
    final challengeData = jsonData['challenge'] as Map<String, dynamic>;
    final videosData = jsonData['videos'] as List<dynamic>;

    // Create a new document reference to get a Firebase ID
    final challengeRef = FirebaseFirestore.instance.collection('challenges').doc();

    // Convert string timestamps to Firestore Timestamp objects
    final updatedChallengeData = {
      ...challengeData,
      'id': challengeRef.id,
      'createdAt': Timestamp.fromDate(DateTime.parse(challengeData['createdAt'] as String)),
      'updatedAt': Timestamp.fromDate(DateTime.parse(challengeData['updatedAt'] as String)),
      'startDate': Timestamp.fromDate(DateTime.parse(challengeData['startDate'] as String)),
      'endDate': Timestamp.fromDate(DateTime.parse(challengeData['endDate'] as String)),
    };
    updatedChallengeData.remove('id'); // Remove the initial ID if it exists

    // Create the challenge in Firestore
    await challengeRef.set(updatedChallengeData);

    // Create the videos as a subcollection under the challenge
    for (final video in videosData) {
      // Create a new document reference for each video in the videos subcollection
      final videoRef = challengeRef.collection('videos').doc();

      // Update video data with Firebase ID
      final updatedVideoData = {
        ...(video as Map<String, dynamic>),
        'id': videoRef.id, // Use Firebase-generated ID
      };
      updatedVideoData.remove('id'); // Remove the initial ID if it exists

      await videoRef.set(updatedVideoData);
    }
    print('Challenge created: ${challengeRef.id}');
  } catch (e) {
    print('Error creating challenge: $e');
  }
}
