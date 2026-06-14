// ─────────────────────────────────────────────
//  screens/home_screen.dart
// ─────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../theme.dart';
import '../state/app_state.dart';
import '../models/challenge.dart';
import '../data/challenges_data.dart';
import '../widgets/app_widgets.dart';
import '../widgets/challenge_card.dart';
import '../widgets/bottom_nav.dart';
import 'challenge_detail_screen.dart';
import 'history_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: IndexedStack(
        index: _tab,
        children: const [
          _TodayTab(),
          HistoryScreen(),
          StatsScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
      ),
    );
  }
}

// ── Today tab ─────────────────────────────────

class _TodayTab extends StatelessWidget {
  const _TodayTab();

  @override
  Widget build(BuildContext context) {
    final state   = context.watch<AppState>();
    final today   = state.todayChallenge;
    final isDone  = state.isTodayDone;
    final dateStr = DateFormat('EEEE, MMMM d').format(DateTime.now());

    return Stack(
      children: [
        GlowBlob(
            color: AppColors.forCategory(today.category),
            size: 320,
            alignment: Alignment.topRight),

        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── header ────────────────────────
            SliverToBoxAdapter(
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(24, 16, 24, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dateStr.toUpperCase(),
                                  style: AppTextStyles.label(10),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Today's\nChallenge",
                                  style: AppTextStyles.display(34),
                                ),
                              ],
                            ),
                          ),
                          const StreakBadge(),
                        ],
                      ).animate().fadeIn(duration: 550.ms).slideY(begin: -0.08),
                      const SizedBox(height: 16),
                      const XpProgressBar()
                          .animate()
                          .fadeIn(delay: 180.ms, duration: 550.ms),
                    ],
                  ),
                ),
              ),
            ),

            // ── challenge card ────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 14),
                child: ChallengeCard(
                  challenge: today,
                  isCompleted: isDone,
                  onTap: () => _openDetail(context, today),
                )
                    .animate()
                    .fadeIn(delay: 280.ms, duration: 600.ms)
                    .slideY(begin: 0.06),
              ),
            ),

            // ── quick stats ───────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    StatPill(
                      emoji: '⚡',
                      value: '${state.totalXp}',
                      label: 'Total XP',
                      color: AppColors.gold,
                    ),
                    const SizedBox(width: 10),
                    StatPill(
                      emoji: '✅',
                      value: '${state.totalDone}',
                      label: 'Done',
                      color: AppColors.teal,
                    ),
                    const SizedBox(width: 10),
                    StatPill(
                      emoji: '🏆',
                      value: '${state.level}',
                      label: 'Level',
                      color: AppColors.lavender,
                    ),
                  ],
                ).animate().fadeIn(delay: 420.ms),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 28)),

            // ── more challenges header ────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const SectionHeader('More Challenges'),
              ).animate().fadeIn(delay: 500.ms),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),

            // ── mini cards row ────────────────
            SliverToBoxAdapter(
              child: _MoreRow(excludeId: today.id),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ],
    );
  }

  void _openDetail(BuildContext context, Challenge ch) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => ChallengeDetailScreen(challenge: ch)),
    );
  }
}

// ── More challenges horizontal row ─────────────

class _MoreRow extends StatelessWidget {
  final String excludeId;
  const _MoreRow({required this.excludeId});

  @override
  Widget build(BuildContext context) {
    final list = getMoreChallenges(excludeId, limit: 8);
    return SizedBox(
      height: 168,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (ctx, i) {
          return _MiniCard(challenge: list[i])
              .animate()
              .fadeIn(delay: (520 + i * 70).ms, duration: 450.ms)
              .slideX(begin: 0.1);
        },
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  final Challenge challenge;
  const _MiniCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.forCategory(challenge.category);
    return PressScale(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                ChallengeDetailScreen(challenge: challenge)),
      ),
      child: Container(
        width: 136,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Center(
                child: Text(challenge.emoji,
                    style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              challenge.title,
              style: AppTextStyles.body(12,
                      color: AppColors.textPrimary)
                  .copyWith(fontWeight: FontWeight.w600, height: 1.3),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '+${challenge.xpReward} XP',
                style: AppTextStyles.mono(10, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
