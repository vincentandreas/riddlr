import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:start_on_2021_competition/components/article_text_area.dart';
import 'package:start_on_2021_competition/components/questions_carousel.dart';
import 'package:start_on_2021_competition/components/quiz_item_card.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';
import 'package:start_on_2021_competition/model/quiz_item_card_model.dart';

class SeeMcaDetail extends StatefulWidget {
  static const String id = 'see_mca_detail';

  const SeeMcaDetail({Key? key}) : super(key: key);

  @override
  _SeeMcaDetailState createState() => _SeeMcaDetailState();
}

class _SeeMcaDetailState extends State<SeeMcaDetail> {
  final Map<int, Widget> mcaDetailTabs = const <int, Widget>{
    0: Text('Questions'),
    1: Text('Article'),
  };
  int indexValue = 0;

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)!.settings.arguments;

    Map<int, Widget> mcaDetailViews = <int, Widget>{
      0: McaQuestionPage(originQaObject: args),
      1: McaArticlePage(
        article: args['article'],
      ),
    };
    QuizItemCardModel item = QuizItemCardModel(
      title: args['title'],
      categories: args['categories'],
      timeCreated: DateTime.now(),
      totalQuestions: args['qasets'].length,
    );
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizItemCard(
                quizItemCardModel: item,
                quizObj: args,
              ),
              CupertinoSegmentedControl<int>(
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 20,
                ),
                borderColor: Colors.transparent,
                pressedColor: kPurpleColor,
                selectedColor: kPurpleColor,
                unselectedColor: kScaffoldBackgroundColor,
                children: mcaDetailTabs,
                onValueChanged: (int val) => setState(
                  () => indexValue = val,
                ),
                groupValue: indexValue,
              ),
              Container(
                child: mcaDetailViews[indexValue],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class McaQuestionPage extends StatefulWidget {
  McaQuestionPage({Key? key, this.originQaObject}) : super(key: key);
  final originQaObject;

  @override
  _McaQuestionPageState createState() =>
      _McaQuestionPageState(this.originQaObject);
}

class _McaQuestionPageState extends State<McaQuestionPage> {
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

  _McaQuestionPageState(this.originQaObject) {
    for (var i = 0; i < this.originQaObject["qasets"].length; i++) {
      generateController(
          this.originQaObject["qasets"][i]["question"],
          this.originQaObject["qasets"][i]["options"],
          this.originQaObject["qasets"][i]["correct"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return QuestionsCarousel(
      listQuestionControllers: listQuestionControllers,
      listTrueAnswers: listTrueAnswers,
      listAnswerControllers: listAnswerControllers,
      isEditable: false,
    );
  }
}

class McaArticlePage extends StatefulWidget {
  McaArticlePage({Key? key, required this.article}) : super(key: key);
  final String article;

  @override
  _McaArticlePageState createState() => _McaArticlePageState(article);
}

class _McaArticlePageState extends State<McaArticlePage> {
  _McaArticlePageState(this.article);

  String article;
  TextEditingController artController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    artController.text = article;
    return ArticleTextArea(controller: artController, isEditable: false);
  }
}
