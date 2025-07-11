enum QuestionType { multipleChoice, slider }

class Question {
  final String id;
  final String text;
  final QuestionType type;
  final List<String>? options;
  final List<String>? labels; // For slider

  const Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.labels,
  });
}

const List<Question> questions = [
  Question(
    id: 'social_energy',
    text: 'A perfect evening is...',
    type: QuestionType.multipleChoice,
    options: ['A quiet night in', 'A small get-together', 'A big party', 'A spontaneous adventure'],
  ),
  Question(
    id: 'decision_making',
    text: 'When making a decision, you rely more on:',
    type: QuestionType.slider,
    labels: ['Logic & Facts', 'Gut Feeling'],
  ),
  Question(
    id: 'humor_style',
    text: 'Your sense of humor is best described as:',
    type: QuestionType.multipleChoice,
    options: ['Sarcastic & Witty', 'Goofy & Slapstick', 'Dark & Dry', 'I laugh at everything'],
  ),
  Question(
    id: 'conflict_approach',
    text: 'When a conflict arises, you tend to:',
    type: QuestionType.multipleChoice,
    options: ['Address it directly', 'Avoid it if possible', 'Try to find a compromise', 'Observe before acting'],
  ),
  Question(
    id: 'ideal_conversation',
    text: 'An ideal conversation is about:',
    type: QuestionType.slider,
    labels: ['Deep, philosophical topics', 'Lighthearted, everyday fun'],
  ),
];
