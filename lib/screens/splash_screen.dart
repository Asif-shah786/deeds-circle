import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _fadeController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Bounce animation for the logo
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 60,
      ),
    ]).animate(_bounceController);

    // Fade animation for the text
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Start animations
    _bounceController.forward();
    _fadeController.forward();

    _checkAuthState();
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _checkAuthState() async {
    // Wait for animations to complete
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final authState = ref.read(authStateProvider);
    if (authState.hasValue) {
      final user = authState.value;
      if (user != null) {
        // Wait for AppUser data to be loaded
        final appUserAsync = ref.read(currentUserProvider);
        if (appUserAsync.hasValue && appUserAsync.value != null) {
          await _fadeController.reverse();
          if (!mounted) return;
          context.go('/home');
        } else {
          // Wait for AppUser data
          appUserAsync.when(
            data: (appUser) async {
              if (appUser != null) {
                await _fadeController.reverse();
                if (!mounted) return;
                context.go('/home');
              } else {
                await _fadeController.reverse();
                if (!mounted) return;
                context.go('/login');
              }
            },
            loading: () async {
              // Wait and retry
              await Future.delayed(const Duration(milliseconds: 300));
              if (mounted) _checkAuthState();
            },
            error: (e, s) async {
              await _fadeController.reverse();
              if (!mounted) return;
              context.go('/login');
            },
          );
        }
      } else {
        await _fadeController.reverse();
        if (!mounted) return;
        context.go('/login');
      }
    } else {
      await _fadeController.reverse();
      if (!mounted) return;
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bouncing logo
            ScaleTransition(
              scale: _bounceAnimation,
              child: const Icon(
                Icons.mosque,
                size: 100,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // Fading text
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Deeds Circle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Loading indicator
            FadeTransition(
              opacity: _fadeAnimation,
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
