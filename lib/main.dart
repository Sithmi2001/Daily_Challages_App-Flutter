// ─────────────────────────────────────────────
//  main.dart
// ─────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force dark status bar icons
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.surface,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState()..load(),
      child: const DailyChallengeApp(),
    ),
  );
}

class DailyChallengeApp extends StatelessWidget {
  const DailyChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Challenge',
      theme: buildAppTheme(),
      debugShowCheckedModeBanner: false,
      home: const _Root(),
    );
  }
}

/// Waits for state to load, then shows onboarding or home.
class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    if (!state.loaded) {
      return const Scaffold(
        backgroundColor: AppColors.bg,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.orange,
            strokeWidth: 2.5,
          ),
        ),
      );
    }

    return state.onboarded
        ? const HomeScreen()
        : const OnboardingScreen();
  }
}
