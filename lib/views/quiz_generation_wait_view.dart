import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_on_2021_competition/components/header_text.dart';
import 'package:start_on_2021_competition/constants/api_path.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';
import 'package:start_on_2021_competition/constants/assets_path.dart';

import 'edit_mca_new.dart';

class QuizGenerationWaitView extends StatelessWidget {
  static const String id = 'quiz_generation_wait_view';
  const QuizGenerationWaitView({Key? key}) : super(key: key);

  genQuestion(BuildContext context, dynamic args) async {
    Client client = Client();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String hostUrl = prefs.getString("hostUrl") ?? "";

    final response =
        await client.post(Uri.parse(hostUrl + generate_question_url),
            headers: {
              "content-type": "application/json",
              "accept": "application/json",
            },
            body: json.encode({'text': args}));
    if (response.statusCode == 200) {
      final responseDec = json.decode(response.body);
      Navigator.pushReplacementNamed(
        context,
        EditMcaNew.id,
        arguments: responseDec,
      );
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)!.settings.arguments;
    genQuestion(context, args);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40, bottom: 20),
              child: image2,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CircularProgressIndicator(
                strokeWidth: 7,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: HeaderText(text: 'Generating Quiz'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Text(
                      'Please wait as we try to generating quiz based on your article.\nThis might take a while...',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kRedColor),
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
