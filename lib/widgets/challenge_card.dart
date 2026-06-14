// ─────────────────────────────────────────────
//  widgets/challenge_card.dart
// ─────────────────────────────────────────────

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/challenge.dart';
import 'app_widgets.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final bool isCompleted;
  final VoidCallback onTap;

  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ch    = challenge;
    final color = AppColors.forCategory(ch.category);

    return PressScale(
      onTap: onTap,
      scale: 0.985,
      child: Container(
        decoration: AppDecorations.glowCard(
            isCompleted ? AppColors.teal : color),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top accent bar ─────────────────
            Container(
              height: 3,
              decoration: BoxDecoration(
                gradient: AppDecorations.accentGradient(
                    isCompleted ? AppColors.teal : color),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // row: category chip + done badge
                  Row(
                    children: [
                      CategoryChip(category: ch.category),
                      const Spacer(),
                      if (isCompleted) _DoneBadge(),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // emoji + title + difficulty
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // emoji box
                      Container(
                        width: 74,
                        height: 74,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                              color: color.withOpacity(0.2), width: 1),
                        ),
                        child: Center(
                          child: Text(ch.emoji,
                              style: const TextStyle(fontSize: 38)),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ch.title,
                              style: AppTextStyles.display(22),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                DifficultyDots(
                                    level: ch.difficultyLevel,
                                    color: color),
                                const SizedBox(width: 8),
                                Text(ch.difficultyName,
                                    style: AppTextStyles.body(12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // description
                  Text(
                    ch.description,
                    style: AppTextStyles.body(14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 22),

                  // bottom row: xp + arrow
                  Row(
                    children: [
                      XpPill(xp: ch.xpReward),
                      const Spacer(),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: AppDecorations.iconBadge(color),
                        child: Icon(Icons.arrow_forward_ios_rounded,
                            color: color, size: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoneBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: AppDecorations.pill(AppColors.teal),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_rounded,
              color: AppColors.teal, size: 13),
          const SizedBox(width: 5),
          Text('Done',
              style: AppTextStyles.body(12, color: AppColors.teal)
                  .copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
