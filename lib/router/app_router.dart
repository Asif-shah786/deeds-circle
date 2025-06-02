import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/repository_providers.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/challenges_list_screen.dart';
import '../screens/challenge_details_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/main_screen.dart';
import '../screens/videos_list_screen.dart';
import '../screens/video_player_screen.dart';
import '../providers/auth_provider.dart';
import '../screens/journey_screen.dart';
import '../screens/leaderboard_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final userChallengeRepo = ref.watch(userChallengeRepositoryProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      // Only check auth state on initial load or specific routes
      if (state.matchedLocation == '/' || state.matchedLocation == '/login' || state.matchedLocation == '/register') {
        // Wait for auth state to be determined
        if (authState.isLoading) {
          return null; // Stay on current route while loading
        }

        final isAuthenticated = authState.value != null;
        final isAuthRoute = state.matchedLocation == '/login' || state.matchedLocation == '/register';
        final isSplashRoute = state.matchedLocation == '/';

        // If on splash screen, let it handle the redirect
        if (isSplashRoute) {
          return null;
        }

        // If not authenticated and not on auth route, redirect to login
        if (!isAuthenticated && !isAuthRoute) {
          return '/login';
        }

        // If authenticated and on auth route, redirect to home
        if (isAuthenticated && isAuthRoute) {
          return '/home';
        }
      }

      return null; // No redirect needed for other routes
    },
    routes: [
      // Splash Screen
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      // Challenges List Route (Separate from main navigation)
      GoRoute(
        path: '/challenges-list',
        builder: (context, state) {
          // Show back button if coming from home screen
          final fromHome = state.extra == 'fromHome';
          return ChallengesListScreen(showBackButton: fromHome);
        },
      ),
      // Main Routes with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) {
          return MainScreen(navigationShell: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/leaderboard',
            builder: (context, state) => const LeaderboardScreen(challengeId: 'current'),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/journey',
            builder: (context, state) => const JourneyScreen(),
          ),
        ],
      ),
      // Challenge Detail Routes
      GoRoute(
        path: '/challenges/:challengeId',
        builder: (context, state) => ChallengeDetailsScreen(
          challengeId: state.pathParameters['challengeId']!,
        ),
        routes: [
          GoRoute(
            path: 'videos',
            builder: (context, state) => VideosListScreen(
              challengeId: state.pathParameters['challengeId']!,
            ),
            routes: [
              GoRoute(
                path: ':videoId',
                builder: (context, state) => VideoPlayerScreen(
                  challengeId: state.pathParameters['challengeId']!,
                  videoId: state.pathParameters['videoId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'leaderboard',
            builder: (context, state) => LeaderboardScreen(
              challengeId: state.pathParameters['challengeId']!,
            ),
          ),
        ],
      ),
    ],
  );
});

int _calculateSelectedIndex(GoRouterState state) {
  final String location = state.uri.path;
  if (location.startsWith('/home')) {
    return 0;
  } else if (location.startsWith('/challenges')) {
    return 1;
  } else if (location.startsWith('/profile')) {
    return 2;
  }
  return 0;
}
