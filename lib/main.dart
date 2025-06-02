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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
