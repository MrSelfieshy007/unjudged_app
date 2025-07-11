import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unjudged_now/ui/theme/app_themes.dart';

class ThemedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;

  const ThemedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    final themeKey = Provider.of<ThemeProvider>(context).currentThemeKey;

    final primaryGradient = LinearGradient(
      colors: themeKey == AppTheme.rainbow
          ? [const Color(0xFFFF5733), const Color(0xFFC70039)]
          : [theme.colorScheme.primary, theme.colorScheme.secondary],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return isSecondary
        ? OutlinedButton(
            onPressed: onPressed,
            child: Text(text),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              minimumSize: const Size(120, 54),
              side: BorderSide(color: Colors.white.withOpacity(0.3)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              gradient: primaryGradient,
              borderRadius: BorderRadius.circular(27),
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                minimumSize: const Size(120, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
              ),
            ),
          );
  }
}
