import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:unjudged_now/core/models/question_model.dart';
import 'package:unjudged_now/core/services/matching_service.dart';
import 'package:unjudged_now/ui/theme/app_themes.dart';
import 'package:unjudged_now/ui/widgets/themed_button.dart';
import 'package:unjudged_now/ui/widgets/video_background.dart';
import 'package:unjudged_now/ui/widgets/glass_morphism_card.dart';

class QuestionnaireScreen extends StatefulWidget {
  final VideoPlayerController controller;
  const QuestionnaireScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int _currentIndex = 0;
  final Map<String, dynamic> _answers = {};
  final MatchingService _matchingService = MatchingService();

  void _nextQuestion() {
    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      final score = _matchingService.calculatePersonalityScore(_answers);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Onboarding Complete!'),
          content: Text('Your anonymous personality score is: ${score.toStringAsFixed(2)}\n\nThis will be used to find your cosmic connection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Navigate to the main app screen
              },
              child: const Text('Find Matches'),
            ),
          ],
        ),
      );
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[_currentIndex];
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    return Scaffold(
      body: Stack(
        children: [
          VideoBackground(controller: widget.controller),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Progress Bar
                  Row(
                    children: List.generate(questions.length, (index) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          height: 4.0,
                          decoration: BoxDecoration(
                            color: index <= _currentIndex
                                ? theme.colorScheme.primary
                                : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                      );
                    }),
                  ),
                  const Spacer(),
                  // Glass Card with Question
                  GlassMorphismCard(
                    color: Colors.white.withOpacity(0.1),
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(24),
                    borderWidth: 1,
                    borderColor: theme.colorScheme.primary.withOpacity(0.3),
                    blur: 15,
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          question.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 32),
                        if (question.type == QuestionType.multipleChoice)
                          ...question.options!.map((option) {
                            final isSelected = _answers[question.id] == option;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _answers[question.id] = option;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? theme.colorScheme.primary.withOpacity(0.3)
                                      : Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                        : Colors.white.withOpacity(0.2),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    option,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        if (question.type == QuestionType.slider)
                          Column(
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: theme.colorScheme.primary,
                                  inactiveTrackColor: Colors.white.withOpacity(0.2),
                                  thumbColor: theme.colorScheme.primary,
                                  overlayColor:
                                      theme.colorScheme.primary.withOpacity(0.2),
                                ),
                                child: Slider(
                                  value:
                                      (_answers[question.id] as double?) ?? 50.0,
                                  min: 0,
                                  max: 100,
                                  onChanged: (value) {
                                    setState(() {
                                      _answers[question.id] = value;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      question.labels![0],
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                    Text(
                                      question.labels![1],
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Navigation Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                        opacity: _currentIndex > 0 ? 1.0 : 0.0,
                        child: ThemedButton(
                          text: 'Back',
                          onPressed: _previousQuestion,
                          isSecondary: true,
                        ),
                      ),
                      ThemedButton(
                        text: _currentIndex == questions.length - 1
                            ? 'Finish'
                            : 'Next',
                        onPressed: _nextQuestion,
                      ),
                    ],
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
