import 'package:flutter/material.dart';
import 'package:unjudged_now/ui/widgets/glass_morphism_card.dart';
import 'package:provider/provider.dart';
import 'package:unjudged_now/ui/theme/app_themes.dart';

class ThemedCard extends StatelessWidget {
  final String emoji;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemedCard({
    Key? key,
    required this.emoji,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    final themeKey = Provider.of<ThemeProvider>(context).currentThemeKey;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: isSelected ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
        child: GlassMorphismCard(
          height: 120,
          width: double.infinity,
          borderRadius: BorderRadius.circular(24),
          borderWidth: isSelected ? 2 : 1,
          borderColor: isSelected ? theme.colorScheme.primary : Colors.white.withOpacity(0.2),
          blur: 15,
          color: isSelected ? theme.colorScheme.primary.withOpacity(0.2) : Colors.white.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSelected && themeKey == AppTheme.rainbow
                      ? Colors.white // Keep text white for rainbow selected
                      : theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
