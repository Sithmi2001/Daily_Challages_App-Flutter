// ─────────────────────────────────────────────
//  widgets/app_widgets.dart
//  All reusable widgets in one place.
// ─────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../theme.dart';
import '../models/challenge.dart';
import '../state/app_state.dart';

// ═══════════════════════════════════════════
//  1. DIFFICULTY DOTS
// ═══════════════════════════════════════════
class DifficultyDots extends StatelessWidget {
  final int level; // 1–3
  final Color color;
  const DifficultyDots({super.key, required this.level, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final active = i < level;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: active ? 9 : 7,
          height: active ? 9 : 7,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? color : AppColors.divider,
            boxShadow: active
                ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 6)]
                : null,
          ),
        );
      }),
    );
  }
}

// ═══════════════════════════════════════════
//  2. XP BAR
// ═══════════════════════════════════════════
class XpProgressBar extends StatelessWidget {
  const XpProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final pct = (s.xpInLevel / s.xpPerLevel).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: AppDecorations.card(),
      child: Row(
        children: [
          // Level badge
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: AppDecorations.accentGradient(AppColors.lavender),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '${s.level}',
                style: AppTextStyles.heading(16).copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Level ${s.level}',
                        style: AppTextStyles.body(12,
                            color: AppColors.textSecondary)
                            .copyWith(fontWeight: FontWeight.w600)),
                    Text('${s.xpInLevel} / ${s.xpPerLevel} XP',
                        style: AppTextStyles.mono(10)),
                  ],
                ),
                const SizedBox(height: 6),
                LinearPercentIndicator(
                  lineHeight: 5,
                  percent: pct,
                  backgroundColor: AppColors.divider,
                  progressColor: AppColors.lavender,
                  barRadius: const Radius.circular(3),
                  padding: EdgeInsets.zero,
                  animation: true,
                  animationDuration: 1000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
//  3. STREAK BADGE
// ═══════════════════════════════════════════
class StreakBadge extends StatelessWidget {
  const StreakBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final streak = context.watch<AppState>().streak;

    if (streak == 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: AppDecorations.card(),
        child: Text('🌱 Start',
            style: AppTextStyles.body(13, color: AppColors.textMuted)),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: AppDecorations.accentGradient(
            AppColors.orange.withOpacity(0.25)),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.orange.withOpacity(0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🔥', style: const TextStyle(fontSize: 20))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                  begin: const Offset(0.88, 0.88),
                  end: const Offset(1.12, 1.12),
                  duration: 1400.ms),
          const SizedBox(width: 6),
          Text('$streak',
              style: AppTextStyles.display(22)
                  .copyWith(color: AppColors.orange)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
//  4. CATEGORY CHIP
// ═══════════════════════════════════════════
class CategoryChip extends StatelessWidget {
  final ChallengeCategory category;
  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.forCategory(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: AppDecorations.pill(c),
      child: Text(
        ChallengeCategory.values
            .firstWhere((v) => v == category)
            .name
            .toUpperCase(),
        style: AppTextStyles.label(10, color: c),
      ),
    );
  }
}

// ═══════════════════════════════════════════
//  5. XP PILL
// ═══════════════════════════════════════════
class XpPill extends StatelessWidget {
  final int xp;
  const XpPill({super.key, required this.xp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: AppDecorations.pill(AppColors.gold),
      child: Text('⚡ +$xp XP',
          style: AppTextStyles.mono(11, color: AppColors.gold)
              .copyWith(fontWeight: FontWeight.w700)),
    );
  }
}

// ═══════════════════════════════════════════
//  6. PRESS SCALE WRAPPER
// ═══════════════════════════════════════════
class PressScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  const PressScale({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.97,
  });

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _down = true),
      onTapUp: (_) {
        setState(() => _down = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _down = false),
      child: AnimatedScale(
        scale: _down ? widget.scale : 1.0,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}

// ═══════════════════════════════════════════
//  7. STAT PILL  (for home screen)
// ═══════════════════════════════════════════
class StatPill extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final Color color;
  const StatPill({
    super.key,
    required this.emoji,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.18)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 5),
            Text(value,
                style: AppTextStyles.heading(20).copyWith(color: color)),
            Text(label, style: AppTextStyles.body(10)),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
//  8. SECTION HEADER
// ═══════════════════════════════════════════
class SectionHeader extends StatelessWidget {
  final String text;
  const SectionHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTextStyles.label(10, color: AppColors.textMuted),
    );
  }
}

// ═══════════════════════════════════════════
//  9. GRADIENT GLOW BG  (decorative blob)
// ═══════════════════════════════════════════
class GlowBlob extends StatelessWidget {
  final Color color;
  final double size;
  final AlignmentGeometry alignment;
  const GlowBlob({
    super.key,
    required this.color,
    this.size = 300,
    this.alignment = Alignment.topRight,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withOpacity(0.14), Colors.transparent],
          ),
        ),
      ),
    );
  }
}
