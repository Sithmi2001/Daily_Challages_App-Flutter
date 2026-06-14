// ─────────────────────────────────────────────
//  state/app_state.dart
// ─────────────────────────────────────────────

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/challenge.dart';
import '../data/challenges_data.dart';

class AppState extends ChangeNotifier {
  static const _kCompleted     = 'v2_completed';
  static const _kXp            = 'v2_xp';
  static const _kStreak        = 'v2_streak';
  static const _kLastDate      = 'v2_last_date';
  static const _kOnboarded     = 'v2_onboarded';

  // ── State fields ────────────────────────
  List<CompletedChallenge> _completed = [];
  int   _xp           = 0;
  int   _streak       = 0;
  bool  _onboarded    = false;
  bool  _loaded       = false;
  DateTime? _lastDate;

  // ── Getters ─────────────────────────────
  bool  get loaded     => _loaded;
  bool  get onboarded  => _onboarded;
  int   get totalXp    => _xp;
  int   get streak     => _streak;
  int   get level      => (_xp ~/ 200) + 1;
  int   get xpInLevel  => _xp % 200;
  int   get xpPerLevel => 200;
  int   get totalDone  => _completed.length;

  List<CompletedChallenge> get allCompleted =>
      List.unmodifiable(_completed.reversed.toList());

  Challenge get todayChallenge => getTodayChallenge();

  bool get isTodayDone {
    final t = DateTime.now();
    return _completed.any((c) =>
        c.completedAt.year  == t.year &&
        c.completedAt.month == t.month &&
        c.completedAt.day   == t.day);
  }

  Map<ChallengeCategory, int> get byCategory {
    final map = <ChallengeCategory, int>{};
    for (final c in _completed) {
      final ch = _challengeById(c.challengeId);
      if (ch == null) continue;
      map[ch.category] = (map[ch.category] ?? 0) + 1;
    }
    return map;
  }

  // ── Init ────────────────────────────────
  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    _xp        = p.getInt(_kXp) ?? 0;
    _streak    = p.getInt(_kStreak) ?? 0;
    _onboarded = p.getBool(_kOnboarded) ?? false;

    final ls = p.getString(_kLastDate);
    _lastDate  = ls != null ? DateTime.tryParse(ls) : null;

    final raw  = p.getStringList(_kCompleted) ?? [];
    _completed = raw
        .map((s) {
          try { return CompletedChallenge.fromJson(jsonDecode(s) as Map<String, dynamic>); }
          catch (_) { return null; }
        })
        .whereType<CompletedChallenge>()
        .toList();

    _loaded = true;
    notifyListeners();
  }

  // ── Actions ─────────────────────────────
  Future<void> markOnboarded() async {
    _onboarded = true;
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kOnboarded, true);
    notifyListeners();
  }

  Future<void> completeToday({String? note}) async {
    if (isTodayDone) return;
    final ch  = todayChallenge;
    final now = DateTime.now();

    _completed.add(CompletedChallenge(
      challengeId: ch.id,
      completedAt: now,
      note: note?.trim().isEmpty ?? true ? null : note!.trim(),
    ));
    _xp += ch.xpReward;

    // streak logic
    if (_lastDate != null) {
      final yesterday = now.subtract(const Duration(days: 1));
      final wasYest = _lastDate!.year  == yesterday.year &&
                      _lastDate!.month == yesterday.month &&
                      _lastDate!.day   == yesterday.day;
      _streak = wasYest ? _streak + 1 : 1;
    } else {
      _streak = 1;
    }
    _lastDate = now;

    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    final p = await SharedPreferences.getInstance();
    await p.setStringList(
      _kCompleted,
      _completed.map((c) => jsonEncode(c.toJson())).toList(),
    );
    await p.setInt(_kXp, _xp);
    await p.setInt(_kStreak, _streak);
    if (_lastDate != null) {
      await p.setString(_kLastDate, _lastDate!.toIso8601String());
    }
  }

  // ── Helpers ─────────────────────────────
  Challenge? _challengeById(String id) {
    try { return kAllChallenges.firstWhere((c) => c.id == id); }
    catch (_) { return null; }
  }

  Challenge? challengeById(String id) => _challengeById(id);
}
