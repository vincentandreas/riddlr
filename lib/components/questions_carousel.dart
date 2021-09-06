import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:start_on_2021_competition/components/rounded_text_field.dart';
import 'package:start_on_2021_competition/components/sub_header_text.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';

class QuestionsCarousel extends StatefulWidget {
  const QuestionsCarousel(
      {Key? key,
      required this.listQuestionControllers,
      required this.listAnswerControllers,
      required this.listTrueAnswers,
      this.isEditable = true})
      : super(key: key);

  final List listQuestionControllers;
  final List listAnswerControllers;
  final List listTrueAnswers;
  final bool isEditable;

  @override
  _QuestionsCarouselState createState() =>
      _QuestionsCarouselState(this.isEditable);
}

class _QuestionsCarouselState extends State<QuestionsCarousel> {
  generateCard(int counter) {
    int totalQC = counter;
    int totalAC = counter;

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SubHeaderText(
              text: "Question ${counter + 1}",
            ),
            RoundedTextField(
              controller: widget.listQuestionControllers[totalQC],
              isEditable: this.isEditable,
            ),
            SubHeaderText(
              text: "Answer",
            ),
            for (var j = 0;
                j < widget.listAnswerControllers[counter].length;
                j++)
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: widget.listTrueAnswers[totalAC] != j
                      ? Border.all(color: Colors.grey, width: 1.5)
                      : Border.all(color: Colors.green, width: 1.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: TextField(
                  controller: widget.listAnswerControllers[totalAC][j],
                  decoration: InputDecoration(
                    filled: true,
                  ),
                  enabled: this.isEditable,
                  onTap: () {
                    if (this.isEditable) {
                      widget.listTrueAnswers[totalAC] = j;
                      setState(() {});
                    }
                  },
                ),
              ),
            if (this.isEditable)
              Center(
                child: FloatingActionButton(
                  onPressed: () {
                    widget.listQuestionControllers.removeAt(counter);
                    widget.listAnswerControllers.removeAt(counter);
                    widget.listTrueAnswers.removeAt(counter);
                    setState(() {});
                  },
                  heroTag: 'deleteCard$counter',
                  child: Icon(Icons.delete),
                  backgroundColor: kRedColor,
                  tooltip: 'Delete question ${counter + 1}',
                ),
              )
          ],
        ),
      ),
    );
  }

  bool isEditable;

  _QuestionsCarouselState(this.isEditable);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider.builder(
        itemCount: widget.listQuestionControllers.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            generateCard(itemIndex),
        options: CarouselOptions(
          enableInfiniteScroll: false,
          aspectRatio: 1,
          height: MediaQuery.of(context).size.height,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
        ),
      ),
    );
  }
}
