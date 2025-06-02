import 'package:flutter/material.dart';
import 'app_sidebar.dart';
import 'app_header.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget>? actions;

  const AppScaffold({
    super.key,
    required this.child,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          const AppSidebar(),
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Header
                AppHeader(
                  title: title,
                  actions: actions,
                ),
                // Main Content
                Expanded(
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
