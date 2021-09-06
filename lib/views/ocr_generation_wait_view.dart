import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:start_on_2021_competition/components/header_text.dart';
import 'package:start_on_2021_competition/constants/api_path.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';
import 'package:start_on_2021_competition/constants/assets_path.dart';
import 'package:start_on_2021_competition/views/review_ocr_result.dart';

class OcrGenerationWaitView extends StatelessWidget {
  static final String id = 'ocr_generation_wait_view';

  const OcrGenerationWaitView({Key? key}) : super(key: key);

  Future<String> requestOcr(String imagePath) async {
    try {
      final request = new MultipartRequest(
        "POST",
        Uri.parse(ocr_url),
      );
      request.headers['apikey'] = ocr_apikey;
      request.headers['content-type'] = "multipart/form-data";

      request.fields['language'] = "eng";

      request.files.add(await MultipartFile.fromPath(
        'photo',
        imagePath,
        contentType: new MediaType('image', 'jpg'),
      ));

      var response = await request.send();

      var resDecode = await Response.fromStream(response);
      var test = json.decode(resDecode.body);

      return test['ParsedResults'][0]['ParsedText'];
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future sendText(String imagePath, BuildContext context) async {
    String resultText = await requestOcr(imagePath);

    Navigator.pushReplacementNamed(
      context,
      ReviewOcrResult.id,
      arguments: resultText,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String imagePath =
        ModalRoute.of(context)!.settings.arguments as String;
    sendText(imagePath, context);
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
              child: HeaderText(text: 'Reading image...'),
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
                      'We are reading your article.\nPlease wait',
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
