// ─────────────────────────────────────────────
//  models/challenge.dart
// ─────────────────────────────────────────────

enum ChallengeCategory {
  creative,
  physical,
  social,
  mindfulness,
  learning,
  adventure,
}

enum ChallengeDifficulty { easy, medium, hard }

class Challenge {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final ChallengeCategory category;
  final ChallengeDifficulty difficulty;
  final int xpReward;
  final List<String> tips;

  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.category,
    required this.difficulty,
    required this.xpReward,
    required this.tips,
  });

  String get categoryName {
    switch (category) {
      case ChallengeCategory.creative:    return 'Creative';
      case ChallengeCategory.physical:    return 'Physical';
      case ChallengeCategory.social:      return 'Social';
      case ChallengeCategory.mindfulness: return 'Mindfulness';
      case ChallengeCategory.learning:    return 'Learning';
      case ChallengeCategory.adventure:   return 'Adventure';
    }
  }

  String get difficultyName {
    switch (difficulty) {
      case ChallengeDifficulty.easy:   return 'Easy';
      case ChallengeDifficulty.medium: return 'Medium';
      case ChallengeDifficulty.hard:   return 'Hard';
    }
  }

  int get difficultyLevel {
    switch (difficulty) {
      case ChallengeDifficulty.easy:   return 1;
      case ChallengeDifficulty.medium: return 2;
      case ChallengeDifficulty.hard:   return 3;
    }
  }
}

class CompletedChallenge {
  final String challengeId;
  final DateTime completedAt;
  final String? note;

  CompletedChallenge({
    required this.challengeId,
    required this.completedAt,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        'challengeId': challengeId,
        'completedAt': completedAt.toIso8601String(),
        'note': note,
      };

  factory CompletedChallenge.fromJson(Map<String, dynamic> json) =>
      CompletedChallenge(
        challengeId: json['challengeId'] as String,
        completedAt: DateTime.parse(json['completedAt'] as String),
        note: json['note'] as String?,
      );
}
