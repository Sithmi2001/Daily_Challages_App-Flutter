// ─────────────────────────────────────────────
//  data/challenges_data.dart
// ─────────────────────────────────────────────

import '../models/challenge.dart';

const List<Challenge> kAllChallenges = [
  // ── CREATIVE ─────────────────────────────
  Challenge(
    id: 'c001',
    title: 'Draw Something Beautiful',
    description:
        'Spend 15 minutes drawing anything that inspires you — a memory, a dream, or something you can see right now. Skill level does not matter.',
    emoji: '🎨',
    category: ChallengeCategory.creative,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 50,
    tips: [
      'No artistic skill needed — doodles count!',
      'Try drawing with your non-dominant hand.',
      'Use patterns, shapes, or abstract lines.',
    ],
  ),
  Challenge(
    id: 'c002',
    title: 'Write a 6-Word Story',
    description:
        'Write a complete story in exactly 6 words. Make it funny, sad, or mysterious. The constraint forces creativity.',
    emoji: '✍️',
    category: ChallengeCategory.creative,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 40,
    tips: [
      'Classic example: "For sale: baby shoes, never worn."',
      'Focus on evoking a single emotion.',
      'Write 5 versions, pick your favorite.',
    ],
  ),
  Challenge(
    id: 'c003',
    title: 'Photo of the Day',
    description:
        'Take one photo that represents your current mood or the emotion you want to feel today. No filters — just raw intention.',
    emoji: '📸',
    category: ChallengeCategory.creative,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 45,
    tips: [
      'Play with light and shadow.',
      'Get close to tiny everyday objects.',
      'Try an unusual angle or perspective.',
    ],
  ),
  Challenge(
    id: 'c004',
    title: 'Cook Something New',
    description:
        'Try cooking a dish you have never made before — even a simple new twist on a classic counts. Explore your kitchen creatively.',
    emoji: '🍳',
    category: ChallengeCategory.creative,
    difficulty: ChallengeDifficulty.medium,
    xpReward: 80,
    tips: [
      'Search a 3-ingredient recipe online.',
      'Experiment boldly with spices.',
      'Share it with someone at the end!',
    ],
  ),
  Challenge(
    id: 'c005',
    title: 'Build a Playlist',
    description:
        'Curate a playlist of 10 songs that tell the story of your life so far — one song per chapter.',
    emoji: '🎵',
    category: ChallengeCategory.creative,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 35,
    tips: [
      'Include a childhood favorite.',
      'Add one guilty pleasure track.',
      'Think of milestone moments as chapters.',
    ],
  ),
  Challenge(
    id: 'c006',
    title: 'Rearrange a Room',
    description:
        'Pick one room or corner of your home and rearrange it. Move furniture, swap decorations — create a fresh perspective.',
    emoji: '🛋️',
    category: ChallengeCategory.creative,
    difficulty: ChallengeDifficulty.medium,
    xpReward: 70,
    tips: [
      'Start small — even a shelf counts.',
      'Photograph before and after.',
      'Try placing items in unexpected spots.',
    ],
  ),

  // ── PHYSICAL ─────────────────────────────
  Challenge(
    id: 'p001',
    title: 'Walk 10,000 Steps',
    description:
        'Hit 10,000 steps today. Take the long route, explore a new street, or just keep moving whenever you can.',
    emoji: '🚶',
    category: ChallengeCategory.physical,
    difficulty: ChallengeDifficulty.medium,
    xpReward: 75,
    tips: [
      'Take stairs instead of the elevator.',
      'Walk during phone calls.',
      'Explore one street you have never been on.',
    ],
  ),
  Challenge(
    id: 'p002',
    title: '7-Minute Workout',
    description:
        'Complete a 7-minute high-intensity circuit: jumping jacks, push-ups, squats, crunches, and a plank hold.',
    emoji: '💪',
    category: ChallengeCategory.physical,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 60,
    tips: [
      '30 seconds on, 10 seconds rest per exercise.',
      'Focus on form over speed.',
      'Repeat the circuit if feeling strong!',
    ],
  ),
  Challenge(
    id: 'p003',
    title: 'Full-Body Stretch',
    description:
        'Give your body love with a 10-minute full-body stretch session. Hit neck, shoulders, back, hips, and legs.',
    emoji: '🧘',
    category: ChallengeCategory.physical,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 40,
    tips: [
      'Hold each stretch for 20–30 seconds.',
      'Breathe slowly and deeply.',
      'Pay extra attention to your tightest spots.',
    ],
  ),
  Challenge(
    id: 'p004',
    title: 'Dance It Out',
    description:
        'Put on your favorite song and dance freely for the entire duration — no choreography, just movement and joy.',
    emoji: '💃',
    category: ChallengeCategory.physical,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 55,
    tips: [
      'Close the curtains if you are shy!',
      'Pick an upbeat, high-energy track.',
      'Repeat with a second song if you love it.',
    ],
  ),
  Challenge(
    id: 'p005',
    title: 'Cold Shower Finish',
    description:
        'End your shower with 30 seconds of cold water. Build mental toughness one cold blast at a time.',
    emoji: '🚿',
    category: ChallengeCategory.physical,
    difficulty: ChallengeDifficulty.hard,
    xpReward: 100,
    tips: [
      'Start warm, transition to cold gradually.',
      'Breathe deeply when the cold hits.',
      'Count down from 30 out loud.',
    ],
  ),
  Challenge(
    id: 'p006',
    title: '50 Push-Ups Today',
    description:
        'Complete 50 push-ups at any point during the day — in sets, spread out, or all at once if you can.',
    emoji: '🏋️',
    category: ChallengeCategory.physical,
    difficulty: ChallengeDifficulty.hard,
    xpReward: 95,
    tips: [
      'Break into sets of 10 throughout the day.',
      'Knee push-ups are perfectly valid.',
      'Rest 60 seconds between sets.',
    ],
  ),

  // ── SOCIAL ───────────────────────────────
  Challenge(
    id: 's001',
    title: 'Compliment 3 People',
    description:
        'Give genuine, specific compliments to three different people today. Watch their faces change — and feel yours change too.',
    emoji: '💬',
    category: ChallengeCategory.social,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 50,
    tips: [
      'Be specific, not generic.',
      'Include at least one stranger if brave.',
      'Notice something real and true about them.',
    ],
  ),
  Challenge(
    id: 's002',
    title: 'Call Someone You Miss',
    description:
        'Reach out to someone you have not spoken to in a while. A 5-minute call can mean the world to both of you.',
    emoji: '📞',
    category: ChallengeCategory.social,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 65,
    tips: [
      'Do not overthink it — just dial.',
      'A text saying "thinking of you" is a start.',
      'Share a shared memory to break the ice.',
    ],
  ),
  Challenge(
    id: 's003',
    title: 'Random Act of Kindness',
    description:
        'Do something kind for a stranger today — buy someone coffee, hold a door, leave a kind note, or pay it forward.',
    emoji: '🤝',
    category: ChallengeCategory.social,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 70,
    tips: [
      'Small gestures have enormous impact.',
      'Do it without expecting anything back.',
      'Surprise someone who is not expecting it.',
    ],
  ),
  Challenge(
    id: 's004',
    title: 'Screen-Free Meal',
    description:
        'Have a full meal with someone — no phones, no screens. Be 100% present and actually listen.',
    emoji: '🍽️',
    category: ChallengeCategory.social,
    difficulty: ChallengeDifficulty.medium,
    xpReward: 80,
    tips: [
      'Put phones in a different room.',
      'Ask one meaningful question.',
      'Listen more than you speak.',
    ],
  ),

  // ── MINDFULNESS ──────────────────────────
  Challenge(
    id: 'm001',
    title: '10-Minute Meditation',
    description:
        'Sit quietly for 10 minutes, focusing on your breath. When your mind wanders — and it will — gently return to the breath.',
    emoji: '🌀',
    category: ChallengeCategory.mindfulness,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 55,
    tips: [
      'Find a quiet, comfortable spot.',
      'Eyes closed or soft downward gaze.',
      'Count breaths 1–10, then restart.',
    ],
  ),
  Challenge(
    id: 'm002',
    title: 'Gratitude Journal',
    description:
        'Write down 5 things you are genuinely grateful for today. Include at least one tiny, easily-overlooked thing.',
    emoji: '📔',
    category: ChallengeCategory.mindfulness,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 40,
    tips: [
      'Be specific, not just "my family".',
      'Include a small daily joy like warm coffee.',
      'Re-read last week\'s entries too.',
    ],
  ),
  Challenge(
    id: 'm003',
    title: '1-Hour Digital Detox',
    description:
        'Spend 1 full hour without your phone, tablet, or computer. Sit with boredom — it is actually good for your brain.',
    emoji: '📵',
    category: ChallengeCategory.mindfulness,
    difficulty: ChallengeDifficulty.medium,
    xpReward: 85,
    tips: [
      'Tell people you will be offline.',
      'Read a physical book or go outside.',
      'Notice what thoughts arise without distraction.',
    ],
  ),
  Challenge(
    id: 'm004',
    title: '5-4-3-2-1 Grounding',
    description:
        'Practice the sensory grounding technique: 5 things you see, 4 you can touch, 3 you hear, 2 you smell, 1 you taste.',
    emoji: '🌿',
    category: ChallengeCategory.mindfulness,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 35,
    tips: [
      'Do it slowly — 30 seconds per sense.',
      'Excellent for stress and anxiety relief.',
      'Try it in a completely new environment.',
    ],
  ),
  Challenge(
    id: 'm005',
    title: 'Watch the Sky for 5 Min',
    description:
        'Go outside and spend 5 uninterrupted minutes watching the sky — clouds, stars, birds, wind. Just observe.',
    emoji: '☁️',
    category: ChallengeCategory.mindfulness,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 30,
    tips: [
      'Lie on the grass if possible.',
      'Notice how quickly things are moving.',
      'Let thoughts float by like the clouds.',
    ],
  ),

  // ── LEARNING ─────────────────────────────
  Challenge(
    id: 'l001',
    title: 'Learn 5 New Words',
    description:
        'Learn 5 new words in a language you have always wanted to speak. Say them out loud and use each in a sentence.',
    emoji: '🌍',
    category: ChallengeCategory.learning,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 45,
    tips: [
      'Use Duolingo or Google Translate to start.',
      'Practice pronunciation out loud.',
      'Write a mini sentence using each word.',
    ],
  ),
  Challenge(
    id: 'l002',
    title: 'Watch a Documentary',
    description:
        'Watch a documentary on a topic completely outside your usual interests. Surprise your brain with something new.',
    emoji: '🎬',
    category: ChallengeCategory.learning,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 50,
    tips: [
      'No phone while watching — full focus.',
      'Write down one thing that surprised you.',
      'Tell someone what you learned.',
    ],
  ),
  Challenge(
    id: 'l003',
    title: 'Read 20 Pages',
    description:
        'Read 20 pages of any book — fiction, non-fiction, poetry, anything. Words on a page, not a screen.',
    emoji: '📚',
    category: ChallengeCategory.learning,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 55,
    tips: [
      'Pick up an old, unfinished book.',
      'Mark one quote you love.',
      'Read somewhere you have never read before.',
    ],
  ),
  Challenge(
    id: 'l004',
    title: 'Master a Magic Trick',
    description:
        'Look up and master a simple magic trick you can perform for someone by the end of the day. Amaze yourself first.',
    emoji: '🪄',
    category: ChallengeCategory.learning,
    difficulty: ChallengeDifficulty.medium,
    xpReward: 75,
    tips: [
      'Card tricks are the easiest to start with.',
      'Practice in front of a mirror.',
      'Perform it for at least one real person!',
    ],
  ),

  // ── ADVENTURE ────────────────────────────
  Challenge(
    id: 'a001',
    title: 'Visit Somewhere New',
    description:
        'Go somewhere in your city you have never been — a park, a café, a street, a viewpoint. Explore your own city like a tourist.',
    emoji: '🗺️',
    category: ChallengeCategory.adventure,
    difficulty: ChallengeDifficulty.medium,
    xpReward: 90,
    tips: [
      'Walk instead of driving.',
      'Take a photo to remember it.',
      'Talk to at least one person there.',
    ],
  ),
  Challenge(
    id: 'a002',
    title: 'Try a New Food',
    description:
        'Eat something you have never tried before — at a restaurant, market, or cooked yourself. Step outside your food comfort zone.',
    emoji: '🍜',
    category: ChallengeCategory.adventure,
    difficulty: ChallengeDifficulty.easy,
    xpReward: 60,
    tips: [
      'Visit an ethnic grocery store or market.',
      'Ask staff for their recommendations.',
      'Rate it honestly after — no fake enthusiasm.',
    ],
  ),
  Challenge(
    id: 'a003',
    title: 'Watch a Sunrise or Sunset',
    description:
        'Wake up for sunrise OR go out for sunset. Be fully present and watch the sky change. Leave your phone in your pocket.',
    emoji: '🌅',
    category: ChallengeCategory.adventure,
    difficulty: ChallengeDifficulty.medium,
    xpReward: 85,
    tips: [
      'Check the exact time online the night before.',
      'Bring a warm drink to sip.',
      'Resist the urge to photograph — just watch.',
    ],
  ),
  Challenge(
    id: 'a004',
    title: 'Start a Conversation',
    description:
        'Start a genuine conversation with a complete stranger today — in a shop, café, park, or on public transit.',
    emoji: '🗣️',
    category: ChallengeCategory.adventure,
    difficulty: ChallengeDifficulty.hard,
    xpReward: 100,
    tips: [
      'Comment on something in your shared environment.',
      'Ask an open-ended question.',
      'Listen more than you speak.',
    ],
  ),
];

/// Returns today's challenge — deterministic per calendar day.
Challenge getTodayChallenge() {
  final now = DateTime.now();
  // Build a numeric seed from the date
  final seed = now.year * 10000 + now.month * 100 + now.day;
  final index = seed % kAllChallenges.length;
  return kAllChallenges[index];
}

/// Returns other challenges excluding the given id (up to [limit]).
List<Challenge> getMoreChallenges(String excludeId, {int limit = 8}) =>
    kAllChallenges.where((c) => c.id != excludeId).take(limit).toList();
