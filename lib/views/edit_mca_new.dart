import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:start_on_2021_competition/components/cancel_text_icon_button.dart';
import 'package:start_on_2021_competition/components/header_text.dart';
import 'package:start_on_2021_competition/components/questions_carousel.dart';
import 'package:start_on_2021_competition/components/save_mca_details.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';

class EditMcaNew extends StatefulWidget {
  static const String id = 'edit_mca_new';

  @override
  _EditMcaNewState createState() => _EditMcaNewState();
}

class _EditMcaNewState extends State<EditMcaNew> {
  var listQuestionControllers = [];
  var listAnswerControllers = [];
  var listTrueAnswers = [];
  var originQaObject;

  generateController(String quest, var answers, int trueAnsIndex) {
    var questController = TextEditingController();
    int totalQC = listQuestionControllers.length;
    listQuestionControllers.add(questController);
    listTrueAnswers.add(trueAnsIndex);
    listQuestionControllers[totalQC].text = quest;
    var tempSingleAC = [];
    for (var i = 0; i < answers.length; i++) {
      var temp = TextEditingController();
      temp.text = answers[i];
      tempSingleAC.add(temp);
    }
    listAnswerControllers.add(tempSingleAC);
  }

  generateEmptyCont() {
    var questController = TextEditingController();
    listQuestionControllers.add(questController);
    listTrueAnswers.add(0);

    var tempSingleAC = [];
    for (var i = 0; i < 4; i++) {
      var temp = TextEditingController();
      tempSingleAC.add(temp);
    }
    listAnswerControllers.add(tempSingleAC);
    setState(() {});
  }

  extractData() {
    var listQaTosend = [];
    for (var i = 0; i < listQuestionControllers.length; i++) {
      var single = Map();
      single['question'] = listQuestionControllers[i].text;
      single['correct'] = listTrueAnswers[i];
      var options = [];
      for (var k = 0; k < listAnswerControllers[i].length; k++) {
        options.add(listAnswerControllers[i][k].text);
      }
      single['options'] = options;
      listQaTosend.add(single);
    }

    var objToSend = Map();
    objToSend["qasets"] = listQaTosend;
    objToSend["article"] = originQaObject['text'];
    objToSend["user_id"] = userId;
    return objToSend;
  }

  String quest = "binatang";
  var answers = ["a", "b"];

  var listWidgets = [];

  void passQAObject(var args) {
    this.originQaObject = args;
    if (this.listQuestionControllers.length == 0) {
      for (var i = 0; i < this.originQaObject["questions"].length; i++) {
        generateController(
            this.originQaObject["questions"][i]["question"],
            this.originQaObject["questions"][i]["options"],
            this.originQaObject["questions"][i]["answer"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    passQAObject(args);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CancelTextIconButton(),
              ),
              HeaderText(text: "Here's Your Quiz!"),
              Text(
                  'Yay! Your quiz has been generated. You may tweak the question and options if you feel necessary'),
              QuestionsCarousel(
                listQuestionControllers: listQuestionControllers,
                listTrueAnswers: listTrueAnswers,
                listAnswerControllers: listAnswerControllers,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.add),
                onPressed: () => generateEmptyCont(),
                style: ElevatedButton.styleFrom(
                  primary: kPurpleColor,
                  fixedSize: Size.fromWidth(double.maxFinite),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                label: Text('Add new question'),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    var obj = extractData();
                    Navigator.pushNamed(
                      context,
                      SaveMcaDetails.id,
                      arguments: obj,
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
