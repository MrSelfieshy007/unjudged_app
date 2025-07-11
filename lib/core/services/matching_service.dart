class MatchingService {
  // This is a placeholder formula.
  // In a real app, this would be more complex and likely run on a server.
  // We will replace this with Supabase Edge Functions later.
  double calculatePersonalityScore(Map<String, dynamic> answers) {
    double score = 0;

    // Social Energy Score (Introvert vs Extrovert)
    switch (answers['social_energy']) {
      case 'A quiet night in':
        score += 10;
        break;
      case 'A small get-together':
        score += 25;
        break;
      case 'A big party':
        score += 40;
        break;
      case 'A spontaneous adventure':
        score += 50;
        break;
    }

    // Decision Making Score (Thinking vs Feeling)
    double decisionValue = (answers['decision_making'] as double?) ?? 50.0;
    score += (100 - decisionValue) / 2; // More points for feeling

    // Humor Style (Adds flavor, not a core metric here)
    // Could be used for compatibility % later
    
    // Conflict Approach (Adds flavor)
    switch (answers['conflict_approach']) {
      case 'Address it directly':
        score += 20;
        break;
      case 'Avoid it if possible':
        score += 5;
        break;
      case 'Try to find a compromise':
        score += 15;
        break;
      case 'Observe before acting':
        score += 10;
        break;
    }

    // Conversation Style (Intuitive vs Sensing)
    double conversationValue = (answers['ideal_conversation'] as double?) ?? 50.0;
    score += conversationValue / 2; // More points for deep topics

    // Normalize to a 0-100 scale
    return (score / 145) * 100;
  }
}
