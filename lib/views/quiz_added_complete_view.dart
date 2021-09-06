import 'dart:async';

import 'package:flutter/material.dart';
import 'package:start_on_2021_competition/components/header_text.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';
import 'package:start_on_2021_competition/constants/assets_path.dart';
import 'package:start_on_2021_competition/views/main_feeds_view.dart';

class QuizAddedCompleteView extends StatefulWidget {
  static const String id = 'quiz_added_complete_view';

  const QuizAddedCompleteView({Key? key}) : super(key: key);

  @override
  _QuizAddedCompleteViewState createState() => _QuizAddedCompleteViewState();
}

class _QuizAddedCompleteViewState extends State<QuizAddedCompleteView> {
  Timer? _timer;
  int _start = 5;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.popUntil(context, (route) => false);
            Navigator.pushNamed(context, MainFeedsView.id);
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: image3,
            ),
            Column(
              children: [
                HeaderText(text: 'Let the Quiz Begin!'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Text(
                        'Congrats! You can find the quiz in your home page. You can also export the quiz into Kahoot for your next class quiz!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, MainFeedsView.id);
              },
              child: Text('Done ($_start)'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kTealColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
