// ─────────────────────────────────────────────
//  screens/challenge_detail_screen.dart
// ─────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'dart:math' as math;
import '../theme.dart';
import '../models/challenge.dart';
import '../state/app_state.dart';
import '../widgets/app_widgets.dart';

class ChallengeDetailScreen extends StatefulWidget {
  final Challenge challenge;
  const ChallengeDetailScreen({super.key, required this.challenge});

  @override
  State<ChallengeDetailScreen> createState() =>
      _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen>
    with SingleTickerProviderStateMixin {
  final _noteCtrl = TextEditingController();
  late final ConfettiController _confetti;
  late final AnimationController _pulse;

  bool _completing = false;
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(
        duration: const Duration(seconds: 4));
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _confetti.dispose();
    _pulse.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    if (_completing) return;
    setState(() => _completing = true);
    await context.read<AppState>().completeToday(note: _noteCtrl.text);
    _confetti.play();
    setState(() {
      _completing = false;
      _showSuccess = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ch      = widget.challenge;
    final color   = AppColors.forCategory(ch.category);
    final isDone  = context.watch<AppState>().isTodayDone;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Background glow
          Positioned(
            top: -120,
            right: -100,
            child: GlowBlob(color: color, size: 380),
          ),

          // Main scroll content
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── App bar ─────────────────────
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Row(
                      children: [
                        _BackButton(),
                        const Spacer(),
                        CategoryChip(category: ch.category),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Hero emoji ──────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _pulse,
                      builder: (_, child) => Transform.scale(
                        scale: 1.0 + _pulse.value * 0.035,
                        child: child,
                      ),
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              color.withOpacity(0.22),
                              color.withOpacity(0.04),
                            ],
                          ),
                          border: Border.all(
                              color: color.withOpacity(0.3), width: 1.5),
                        ),
                        child: Center(
                          child: Text(ch.emoji,
                              style: const TextStyle(fontSize: 60)),
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .scale(
                          begin: const Offset(0.4, 0.4),
                          duration: 650.ms,
                          curve: Curves.elasticOut),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 30)),

              // ── Title + difficulty ───────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ch.title, style: AppTextStyles.display(30))
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 500.ms)
                          .slideY(begin: 0.08),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          DifficultyDots(
                              level: ch.difficultyLevel, color: color),
                          const SizedBox(width: 8),
                          Text(ch.difficultyName,
                              style: AppTextStyles.body(13)),
                          const Spacer(),
                          XpPill(xp: ch.xpReward),
                        ],
                      ).animate().fadeIn(delay: 280.ms),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── Description ─────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: AppDecorations.card(
                        borderColor: color.withOpacity(0.15)),
                    child: Text(ch.description,
                        style: AppTextStyles.body(16,
                            color: AppColors.textPrimary)),
                  ).animate().fadeIn(delay: 340.ms),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── Tips ────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader('💡  Tips'),
                      const SizedBox(height: 14),
                      ...ch.tips.asMap().entries.map((e) => _TipRow(
                            tip: e.value,
                            color: color,
                            delay: 400 + e.key * 70,
                          )),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── Note field ──────────────────
              if (!isDone)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader('📝  Add a note  (optional)'),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _noteCtrl,
                          style: AppTextStyles.body(15,
                              color: AppColors.textPrimary),
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText:
                                'How did it go? What did you feel?',
                            hintStyle: AppTextStyles.body(14,
                                color: AppColors.textMuted),
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: AppColors.divider),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: AppColors.divider),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: color, width: 1.5),
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 500.ms),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── CTA ─────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: isDone
                      ? _DoneBar()
                      : _CompleteButton(
                          color: color,
                          loading: _completing,
                          onTap: _complete,
                        ).animate().fadeIn(delay: 550.ms).slideY(begin: 0.08),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),

          // ── Confetti ─────────────────────
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 35,
              maxBlastForce: 22,
              minBlastForce: 10,
              gravity: 0.25,
              colors: [
                color, AppColors.gold, AppColors.teal,
                AppColors.rose, AppColors.lavender, Colors.white,
              ],
            ),
          ),

          // ── Success overlay ──────────────
          if (_showSuccess)
            _SuccessOverlay(
              challenge: ch,
              color: color,
              onDismiss: () => Navigator.of(context).pop(),
            ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ──────────────────────────────

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PressScale(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 44,
        height: 44,
        decoration: AppDecorations.card(),
        child: const Icon(Icons.arrow_back_ios_new_rounded,
            color: AppColors.textSecondary, size: 17),
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  final String tip;
  final Color color;
  final int delay;
  const _TipRow(
      {required this.tip, required this.color, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 8, right: 12),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: color),
          ),
          Expanded(
            child: Text(tip, style: AppTextStyles.body(14)),
          ),
        ],
      ).animate().fadeIn(delay: delay.ms, duration: 400.ms),
    );
  }
}

class _CompleteButton extends StatefulWidget {
  final Color color;
  final bool loading;
  final VoidCallback onTap;
  const _CompleteButton(
      {required this.color, required this.loading, required this.onTap});

  @override
  State<_CompleteButton> createState() => _CompleteButtonState();
}

class _CompleteButtonState extends State<_CompleteButton> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _down = true),
      onTapUp: (_) {
        setState(() => _down = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _down = false),
      child: AnimatedScale(
        scale: _down ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: 64,
          decoration: AppDecorations.accentButton(widget.color),
          child: Center(
            child: widget.loading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_rounded,
                          color: Colors.white, size: 22),
                      const SizedBox(width: 10),
                      Text('Mark as Complete',
                          style: AppTextStyles.heading(17)
                              .copyWith(color: Colors.white)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _DoneBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: AppDecorations.pill(AppColors.teal, opacity: 0.1),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.celebration_rounded,
                color: AppColors.teal, size: 22),
            const SizedBox(width: 10),
            Text('Challenge Completed Today!',
                style: AppTextStyles.heading(16)
                    .copyWith(color: AppColors.teal)),
          ],
        ),
      ),
    );
  }
}

class _SuccessOverlay extends StatelessWidget {
  final Challenge challenge;
  final Color color;
  final VoidCallback onDismiss;

  const _SuccessOverlay({
    required this.challenge,
    required this.color,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      child: Container(
        color: Colors.black.withOpacity(0.75),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(challenge.emoji,
                      style: const TextStyle(fontSize: 90))
                  .animate()
                  .scale(
                      begin: const Offset(0.1, 0.1),
                      duration: 700.ms,
                      curve: Curves.elasticOut),
              const SizedBox(height: 28),
              Text('Challenge\nComplete!',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.display(44)
                          .copyWith(color: Colors.white))
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 500.ms),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 13),
                decoration: AppDecorations.pill(AppColors.gold),
                child: Text('+${challenge.xpReward} XP earned  ⚡',
                    style: AppTextStyles.heading(20)
                        .copyWith(color: AppColors.gold)),
              ).animate().fadeIn(delay: 500.ms).scale(delay: 500.ms),
              const SizedBox(height: 48),
              Text('Tap anywhere to continue',
                      style: AppTextStyles.body(14,
                          color: Colors.white38))
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .fadeIn(delay: 750.ms)
                  .fadeOut(delay: 1200.ms),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
