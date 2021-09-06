import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';
import 'package:start_on_2021_competition/model/quiz_item_card_model.dart';
import 'package:start_on_2021_competition/views/see_mca_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class QuizItemCard extends StatelessWidget {
  const QuizItemCard({
    Key? key,
    required this.quizItemCardModel,
    required this.quizObj,
    this.tappable = false,
  }) : super(key: key);
  final QuizItemCardModel quizItemCardModel;
  final bool tappable;
  final dynamic quizObj;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${quizItemCardModel.title}-${quizItemCardModel.timeCreated}',
      child: Card(
        elevation: 4,
        child: ListTile(
          onTap: () => tappable
              ? Navigator.pushNamed(
                  context,
                  SeeMcaDetail.id,
                  arguments: quizObj,
                )
              : null,
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(quizItemCardModel.title),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${quizItemCardModel.totalQuestions} Question(s)',
                  style: TextStyle(
                    color: kPurpleColor,
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: quizItemCardModel.categories
                      .map(
                        (e) => Container(
                          margin: EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: e.toLowerCase().contains('grade')
                                ? kOrangeColor
                                : kBlueColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Text(
                            e,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          isThreeLine: !tappable,
          trailing: (() {
            if (!tappable)
              return IconButton(
                onPressed: () => launch(quizObj["export_link"]),
                icon: Icon(Icons.download),
              );
          }()),
        ),
      ),
    );
  }
}
