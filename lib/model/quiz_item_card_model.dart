class QuizItemCardModel {
  final String title;
  final int totalQuestions;
  final List categories;
  final DateTime timeCreated;

  QuizItemCardModel({
    required this.title,
    required this.totalQuestions,
    required this.categories,
    required this.timeCreated,
  });
}
