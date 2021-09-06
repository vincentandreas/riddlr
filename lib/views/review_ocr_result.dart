import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:start_on_2021_competition/components/article_text_area.dart';
import 'package:start_on_2021_competition/components/cancel_text_icon_button.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';
import 'package:start_on_2021_competition/views/quiz_generation_wait_view.dart';

class ReviewOcrResult extends StatefulWidget {
  static const String id = 'review_ocr_result';

  @override
  _ReviewOcrResultState createState() => _ReviewOcrResultState();
}

class _ReviewOcrResultState extends State<ReviewOcrResult> {
  TextEditingController artController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments as String;
    artController.text = args;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CancelTextIconButton(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Article',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Here is the scanned article. Please check before we proceed generating the quiz for you',
              ),
              SizedBox(
                height: 20,
              ),
              ArticleTextArea(controller: artController),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      QuizGenerationWaitView.id,
                      arguments: artController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kTealColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Looks Good!'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
