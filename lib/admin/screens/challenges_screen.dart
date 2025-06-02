import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../test_data_generator.dart';

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  Future<void> _createChallengeFromJson(BuildContext context) async {
    try {
      // Load the JSON file
      final String jsonString = await rootBundle.loadString('lib/admin/short_challenge.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Get the challenge data
      final challengeData = jsonData['challenge'] as Map<String, dynamic>;
      final videosData = jsonData['videos'] as List<dynamic>;

      // Create a new document reference to get a Firebase ID
      final challengeRef = FirebaseFirestore.instance.collection('challenges').doc();

      // Update challenge data with Firebase ID and remove the initial ID
      final updatedChallengeData = {
        ...challengeData,
        'id': challengeRef.id, // Use Firebase-generated ID
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

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Challenge created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating challenge: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _createChallengeFromJson(context),
            tooltip: 'Create Challenge from JSON',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('challenges').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final challenges = snapshot.data?.docs ?? [];

          if (challenges.isEmpty) {
            return const Center(
              child: Text('No challenges found. Create some test challenges!'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: challenges.length,
            itemBuilder: (context, index) {
              final challenge = challenges[index].data() as Map<String, dynamic>;
              final id = challenges[index].id;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              challenge['title'] ?? 'No Title',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Chip(
                            label: Text(challenge['isPublic'] == true ? 'Public' : 'Private'),
                            backgroundColor: challenge['isPublic'] == true
                                ? Colors.green.withOpacity(0.2)
                                : Colors.orange.withOpacity(0.2),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        challenge['description'] ?? 'No Description',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _InfoChip(
                            icon: Icons.video_library,
                            label: '${challenge['totalVideos'] ?? 0} Videos',
                          ),
                          _InfoChip(
                            icon: Icons.attach_money,
                            label: '\$${challenge['rewardAmount']?.toStringAsFixed(2) ?? '0.00'} per video',
                          ),
                          _InfoChip(
                            icon: Icons.account_balance_wallet,
                            label: '\$${challenge['totalPossibleEarning']?.toStringAsFixed(2) ?? '0.00'} total',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          for (final keyword in (challenge['keywords'] as List<dynamic>? ?? []))
                            Chip(
                              label: Text(keyword.toString()),
                              backgroundColor: Colors.blue.withOpacity(0.1),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}
