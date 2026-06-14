// ─────────────────────────────────────────────
//  widgets/bottom_nav.dart
// ─────────────────────────────────────────────

import 'package:flutter/material.dart';
import '../theme.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItem(emoji: '🏠', label: 'Today'),
    _NavItem(emoji: '📜', label: 'History'),
    _NavItem(emoji: '📊', label: 'Stats'),
  ];

  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final selected = i == selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.orange.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                              fontSize: selected ? 24 : 20),
                          child: Text(item.emoji),
                        ),
                        const SizedBox(height: 2),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: AppTextStyles.label(
                            10,
                            color: selected
                                ? AppColors.orange
                                : AppColors.textMuted,
                          ).copyWith(
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                          child: Text(item.label),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String emoji;
  final String label;
  const _NavItem({required this.emoji, required this.label});
}
