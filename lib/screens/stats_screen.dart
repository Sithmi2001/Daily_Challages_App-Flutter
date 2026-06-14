// ─────────────────────────────────────────────
//  screens/stats_screen.dart
// ─────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../theme.dart';
import '../models/challenge.dart';
import '../state/app_state.dart';
import '../widgets/app_widgets.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ── header ─────────────────────────
        SliverToBoxAdapter(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader('Progress'),
                  const SizedBox(height: 4),
                  Text('Your Stats', style: AppTextStyles.display(32)),
                ],
              ).animate().fadeIn(duration: 500.ms),
            ),
          ),
        ),

        // ── level card ──────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: _LevelCard(state: state)
                .animate()
                .fadeIn(delay: 150.ms),
          ),
        ),

        // ── big stats ───────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                StatPill(
                    emoji: '🏅',
                    value: '${state.totalDone}',
                    label: 'Done',
                    color: AppColors.teal),
                const SizedBox(width: 12),
                StatPill(
                    emoji: '🔥',
                    value: '${state.streak}',
                    label: 'Streak',
                    color: AppColors.orange),
                const SizedBox(width: 12),
                StatPill(
                    emoji: '⚡',
                    value: '${state.totalXp}',
                    label: 'Total XP',
                    color: AppColors.gold),
              ],
            ).animate().fadeIn(delay: 250.ms),
          ),
        ),

        // ── category breakdown ──────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: _CategoryBreakdown(state: state)
                .animate()
                .fadeIn(delay: 350.ms),
          ),
        ),

        // ── achievements ────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
            child: _Achievements(state: state)
                .animate()
                .fadeIn(delay: 450.ms),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

// ── Level Card ───────────────────────────────

class _LevelCard extends StatelessWidget {
  final AppState state;
  const _LevelCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final pct =
        (state.xpInLevel / state.xpPerLevel).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.lavender.withOpacity(0.18),
            AppColors.orange.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: AppColors.lavender.withOpacity(0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'LEVEL ${state.level}',
                style: AppTextStyles.label(13,
                    color: AppColors.lavender),
              ),
              const Spacer(),
              Text(
                '${state.xpInLevel} / ${state.xpPerLevel} XP',
                style: AppTextStyles.mono(12),
              ),
            ],
          ),
          const SizedBox(height: 18),
          LinearPercentIndicator(
            lineHeight: 8,
            percent: pct,
            backgroundColor: AppColors.divider,
            progressColor: AppColors.lavender,
            barRadius: const Radius.circular(4),
            padding: EdgeInsets.zero,
            animation: true,
            animationDuration: 1200,
          ),
          const SizedBox(height: 12),
          Text(
            '${state.xpPerLevel - state.xpInLevel} XP to Level ${state.level + 1}',
            style: AppTextStyles.body(13),
          ),
        ],
      ),
    );
  }
}

// ── Category Breakdown ───────────────────────

class _CategoryBreakdown extends StatelessWidget {
  final AppState state;
  const _CategoryBreakdown({required this.state});

  @override
  Widget build(BuildContext context) {
    final map   = state.byCategory;
    final total = state.totalDone;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('Category Breakdown'),
        const SizedBox(height: 18),
        ...ChallengeCategory.values.map((cat) {
          final count = map[cat] ?? 0;
          final pct   = total == 0 ? 0.0 : count / total;
          final color = AppColors.forCategory(cat);
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _catEmoji(cat),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      cat.name[0].toUpperCase() +
                          cat.name.substring(1),
                      style: AppTextStyles.body(13,
                          color: AppColors.textSecondary),
                    ),
                    const Spacer(),
                    Text('$count',
                        style: AppTextStyles.mono(12,
                            color: color)),
                  ],
                ),
                const SizedBox(height: 7),
                LinearPercentIndicator(
                  lineHeight: 6,
                  percent: pct.clamp(0.0, 1.0),
                  backgroundColor: AppColors.divider,
                  progressColor: color,
                  barRadius: const Radius.circular(3),
                  padding: EdgeInsets.zero,
                  animation: true,
                  animationDuration: 1000,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  String _catEmoji(ChallengeCategory cat) {
    switch (cat) {
      case ChallengeCategory.creative:    return '🎨';
      case ChallengeCategory.physical:    return '💪';
      case ChallengeCategory.social:      return '💬';
      case ChallengeCategory.mindfulness: return '🌀';
      case ChallengeCategory.learning:    return '📚';
      case ChallengeCategory.adventure:   return '🗺️';
    }
  }
}

// ── Achievements ─────────────────────────────

class _Achievements extends StatelessWidget {
  final AppState state;
  const _Achievements({required this.state});

  @override
  Widget build(BuildContext context) {
    final badges = [
      _Badge('🌱', 'First Step',    'Complete 1 challenge',  state.totalDone >= 1),
      _Badge('🔥', 'On Fire',       '3-day streak',          state.streak >= 3),
      _Badge('⚡', 'Energized',     'Earn 200 XP',           state.totalXp >= 200),
      _Badge('🏆', 'Champion',      '10 challenges done',    state.totalDone >= 10),
      _Badge('💎', 'Diamond',       '7-day streak',          state.streak >= 7),
      _Badge('🚀', 'Unstoppable',   'Reach Level 5',         state.level >= 5),
      _Badge('🌟', 'XP Master',     'Earn 1000 XP',          state.totalXp >= 1000),
      _Badge('👑', 'Legendary',     '30 challenges done',    state.totalDone >= 30),
      _Badge('🎯', 'Focused',       '5-day streak',          state.streak >= 5),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('Achievements'),
        const SizedBox(height: 18),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.82,
          children: badges
              .map((b) => _BadgeTile(badge: b))
              .toList(),
        ),
      ],
    );
  }
}

class _Badge {
  final String emoji;
  final String title;
  final String desc;
  final bool unlocked;
  const _Badge(this.emoji, this.title, this.desc, this.unlocked);
}

class _BadgeTile extends StatelessWidget {
  final _Badge badge;
  const _BadgeTile({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    final unlocked = badge.unlocked;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: unlocked
            ? AppColors.gold.withOpacity(0.07)
            : AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: unlocked
              ? AppColors.gold.withOpacity(0.3)
              : AppColors.divider,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // emoji with grayscale filter when locked
          ColorFiltered(
            colorFilter: unlocked
                ? const ColorFilter.mode(
                    Colors.transparent, BlendMode.color)
                : const ColorFilter.matrix(<double>[
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0, 0, 0, 0.4, 0,
                  ]),
            child: Text(badge.emoji,
                style: const TextStyle(fontSize: 34)),
          ),
          const SizedBox(height: 8),
          Text(
            badge.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.body(12,
                    color: unlocked
                        ? AppColors.textPrimary
                        : AppColors.textMuted)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Text(
            badge.desc,
            textAlign: TextAlign.center,
            style: AppTextStyles.body(10,
                color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
