// ─────────────────────────────────────────────
//  screens/history_screen.dart
// ─────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../theme.dart';
import '../state/app_state.dart';
import '../models/challenge.dart';
import '../widgets/app_widgets.dart';
import 'challenge_detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state     = context.watch<AppState>();
    final completed = state.allCompleted; // newest first

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
                  const SectionHeader('History'),
                  const SizedBox(height: 4),
                  Text('Your Journey',
                      style: AppTextStyles.display(32)),
                ],
              ).animate().fadeIn(duration: 500.ms),
            ),
          ),
        ),

        // ── empty state ─────────────────────
        if (completed.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🌱', style: const TextStyle(fontSize: 72))
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scale(
                          begin: const Offset(0.93, 0.93),
                          end: const Offset(1.07, 1.07),
                          duration: 2.seconds),
                  const SizedBox(height: 22),
                  Text('No challenges yet',
                      style: AppTextStyles.display(22)
                          .copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Text('Complete today\'s challenge to begin!',
                      style: AppTextStyles.body(14)),
                ],
              ),
            ),
          )
        else
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) {
                  final c  = completed[i];
                  final ch = context
                      .read<AppState>()
                      .challengeById(c.challengeId);
                  if (ch == null) return const SizedBox.shrink();
                  return _HistoryTile(
                    completed: c,
                    challenge: ch,
                    index: i,
                  );
                },
                childCount: completed.length,
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final CompletedChallenge completed;
  final Challenge challenge;
  final int index;

  const _HistoryTile({
    required this.completed,
    required this.challenge,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color   = AppColors.forCategory(challenge.category);
    final dateStr = DateFormat('MMM d, yyyy · h:mm a')
        .format(completed.completedAt);

    return PressScale(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                ChallengeDetailScreen(challenge: challenge)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration:
            AppDecorations.card(borderColor: color.withOpacity(0.18)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // emoji bubble
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(challenge.emoji,
                    style: const TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge.title,
                    style: AppTextStyles.body(15,
                            color: AppColors.textPrimary)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(dateStr, style: AppTextStyles.mono(11)),
                  if (completed.note != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        completed.note!,
                        style: AppTextStyles.body(13)
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            XpPill(xp: challenge.xpReward),
          ],
        ),
      ).animate().fadeIn(delay: (index * 55).ms, duration: 400.ms).slideY(begin: 0.05),
    );
  }
}
