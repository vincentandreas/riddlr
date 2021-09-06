import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:start_on_2021_competition/components/quiz_item_card.dart';
import 'package:start_on_2021_competition/model/quiz_item_card_model.dart';

class RecentlyCreatedQuizTiles extends StatelessWidget {
  const RecentlyCreatedQuizTiles({Key? key, required this.quizzes})
      : super(key: key);

  final List<dynamic> quizzes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final QuizItemCardModel quizItemCardModel = QuizItemCardModel(
          title: quizzes[index]['title'],
          totalQuestions: quizzes[index]['qasets'].length,
          categories: quizzes[index]['categories'],
          timeCreated: DateTime.now(),
        );

        return QuizItemCard(
          quizItemCardModel: quizItemCardModel,
          tappable: true,
          quizObj: quizzes[index],
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
      itemCount: quizzes.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }
}
