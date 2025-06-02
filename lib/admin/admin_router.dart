import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/widgets/app_scaffold.dart';
import 'screens/dashboard_screen.dart';
import 'screens/challenges_screen.dart';
import 'screens/users_screen.dart';
import 'screens/payments_screen.dart';

final adminRouter = GoRouter(
  initialLocation: '/admin/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        // Get the title based on the current route
        String title = 'Dashboard';
        final path = state.uri.path;
        if (path.startsWith('/admin/challenges')) {
          title = 'Challenges';
        } else if (path.startsWith('/admin/users')) {
          title = 'Users';
        } else if (path.startsWith('/admin/payments')) {
          title = 'Payments';
        }

        return AppScaffold(
          title: title,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/admin/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/admin/challenges',
          builder: (context, state) => const ChallengesScreen(),
        ),
        GoRoute(
          path: '/admin/users',
          builder: (context, state) => const UsersScreen(),
        ),
        GoRoute(
          path: '/admin/payments',
          builder: (context, state) => const PaymentsScreen(),
        ),
      ],
    ),
  ],
);
