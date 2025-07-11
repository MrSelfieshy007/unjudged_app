import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:unjudged_now/ui/screens/questionnaire_screen.dart';
import 'package:unjudged_now/ui/theme/app_themes.dart';
import 'package:unjudged_now/ui/widgets/themed_card.dart';
import 'package:unjudged_now/ui/widgets/themed_button.dart';
import 'package:unjudged_now/ui/widgets/video_background.dart';

class GenderSelectionScreen extends StatelessWidget {
  final VideoPlayerController controller;
  const GenderSelectionScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          VideoBackground(controller: controller),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    'How do you identify?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'This helps us create a personalized experience for you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  const SizedBox(height: 48),
                  ThemedCard(
                    emoji: '👩',
                    text: 'Girl',
                    isSelected: themeProvider.currentThemeKey == AppTheme.girls,
                    onTap: () => themeProvider.setTheme(AppTheme.girls),
                  ),
                  const SizedBox(height: 16),
                  ThemedCard(
                    emoji: '👨',
                    text: 'Boy',
                    isSelected: themeProvider.currentThemeKey == AppTheme.boys,
                    onTap: () => themeProvider.setTheme(AppTheme.boys),
                  ),
                  const SizedBox(height: 16),
                  ThemedCard(
                    emoji: '🌈',
                    text: 'Other',
                    isSelected: themeProvider.currentThemeKey == AppTheme.rainbow,
                    onTap: () => themeProvider.setTheme(AppTheme.rainbow),
                  ),
                  const Spacer(),
                  ThemedButton(
                    text: 'Continue',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => QuestionnaireScreen(controller: controller)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
