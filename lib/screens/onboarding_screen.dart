// ─────────────────────────────────────────────
//  screens/onboarding_screen.dart
// ─────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../state/app_state.dart';
import '../widgets/app_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _ctrl = PageController();
  int _page = 0;

  static const _pages = [
    _OPage(
      emoji: '🎯',
      title: 'A New Challenge\nEvery Day',
      body:
          'Wake up to a fresh challenge every morning — creative, physical, social, or adventurous. Every single day is different.',
      color: AppColors.orange,
    ),
    _OPage(
      emoji: '🔥',
      title: 'Build Your\nStreak',
      body:
          'Complete challenges daily to grow your streak and earn XP. Level up your profile and prove your consistency.',
      color: AppColors.gold,
    ),
    _OPage(
      emoji: '🏆',
      title: 'Unlock\nAchievements',
      body:
          'Collect badges, climb levels, and track your growth across every category of challenge. Your journey is unique.',
      color: AppColors.teal,
    ),
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _pages.length - 1) {
      _ctrl.nextPage(
          duration: const Duration(milliseconds: 380),
          curve: Curves.easeInOutCubic);
    } else {
      context.read<AppState>().markOnboarded();
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_page];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // animated glow blob
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            top: _page == 0 ? -60 : (_page == 1 ? 80 : 200),
            right: -80,
            child: GlowBlob(color: page.color, size: 360),
          ),
          SafeArea(
            child: Column(
              children: [
                // skip
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () => context.read<AppState>().markOnboarded(),
                      child: Text('Skip',
                          style: AppTextStyles.body(14,
                              color: AppColors.textMuted)),
                    ),
                  ),
                ),

                // pages
                Expanded(
                  child: PageView.builder(
                    controller: _ctrl,
                    onPageChanged: (i) => setState(() => _page = i),
                    itemCount: _pages.length,
                    itemBuilder: (_, i) => _PageContent(page: _pages[i]),
                  ),
                ),

                // dots + button
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
                  child: Column(
                    children: [
                      // dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_pages.length, (i) {
                          final active = i == _page;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: active ? 26 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: active
                                  ? page.color
                                  : AppColors.divider,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 32),
                      // button
                      PressScale(
                        onTap: _next,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 62,
                          decoration:
                              AppDecorations.accentButton(page.color),
                          child: Center(
                            child: Text(
                              _page < _pages.length - 1
                                  ? 'Continue  →'
                                  : 'Start Challenging! 🚀',
                              style: AppTextStyles.heading(17)
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OPage {
  final String emoji;
  final String title;
  final String body;
  final Color color;
  const _OPage({
    required this.emoji,
    required this.title,
    required this.body,
    required this.color,
  });
}

class _PageContent extends StatelessWidget {
  final _OPage page;
  const _PageContent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // emoji bubble
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  page.color.withOpacity(0.22),
                  Colors.transparent,
                ],
              ),
            ),
            child: Center(
              child: Text(page.emoji,
                      style: const TextStyle(fontSize: 56))
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                      begin: const Offset(0.93, 0.93),
                      end: const Offset(1.07, 1.07),
                      duration: 2.seconds,
                      curve: Curves.easeInOut),
            ),
          ),
          const SizedBox(height: 44),
          Text(page.title, style: AppTextStyles.display(40))
              .animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.06),
          const SizedBox(height: 20),
          Text(page.body, style: AppTextStyles.body(17))
              .animate()
              .fadeIn(delay: 120.ms, duration: 500.ms),
        ],
      ),
    );
  }
}
