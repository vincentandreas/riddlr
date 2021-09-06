import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:http/http.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_on_2021_competition/components/cancel_text_icon_button.dart';
import 'package:start_on_2021_competition/components/header_text.dart';
import 'package:start_on_2021_competition/components/rounded_text_field.dart';
import 'package:start_on_2021_competition/components/sub_header_text.dart';
import 'package:start_on_2021_competition/constants/api_path.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';
import 'package:start_on_2021_competition/views/quiz_added_complete_view.dart';

class SaveMcaDetails extends StatefulWidget {
  static const String id = 'save_mca_details';

  @override
  _SaveMcaDetailsState createState() => _SaveMcaDetailsState();
}

class _SaveMcaDetailsState extends State<SaveMcaDetails> {
  var selectedCat = [];
  var titleCon = TextEditingController();

  generateItems() {
    var cate = [
      'Grade 1',
      'Grade 2',
      'Grade 3',
      'Grade 4',
      'Grade 5',
      'Grade 6',
      'Art',
      'Math',
      'Biology',
      'Chemistry',
      'Economics',
      'English',
      'Geography',
      'History',
      'Information Technology',
      'Physics',
      'Sociology',
    ];
    var items = cate
        .map(
          (cat) => MultiSelectItem<String>(cat, cat),
        )
        .toList();
    return items;
  }

  saveQuiz(var args) async {
    Client client = new Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String hostUrl = prefs.getString("hostUrl") ?? "";

    final response = await client.post(Uri.parse(hostUrl + quiz_url),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: json.encode(args));
    if (response.statusCode == 200) {
      final responseDec = json.decode(response.body);
    } else {
      print('server error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)!.settings.arguments;

    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 15.0, right: 15, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: CancelTextIconButton(),
                    ),
                    HeaderText(text: 'One Last Thing...'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                          'Let’s add the quiz descriptions before we save'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SubHeaderText(text: 'Title'),
                    ),
                    RoundedTextField(controller: titleCon),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SubHeaderText(text: 'Category'),
                    ),
                    Text('Select a category to save the quiz'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: MultiSelectBottomSheetField(
                        initialChildSize: 0.4,
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        selectedColor: kOrangeColor,
                        selectedItemsTextStyle: TextStyle(color: Colors.white),
                        cancelText: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                        confirmText: Text(
                          'Ok',
                          style: TextStyle(color: Colors.black),
                        ),
                        buttonText: Text("Select Categories"),
                        title: Text("Categories"),
                        items: generateItems(),
                        onConfirm: (values) {
                          selectedCat = values;
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          chipColor: kOrangeColor,
                          textStyle: TextStyle(color: Colors.white),
                          onTap: (value) {
                            setState(
                              () => selectedCat.remove(value),
                            );
                          },
                        ),
                        searchHint: 'Grade, class, etc',
                        backgroundColor: kScaffoldBackgroundColor,
                        buttonIcon: Icon(Icons.keyboard_arrow_down_sharp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          final _progressIndicator = ProgressHUD.of(context);
                          _progressIndicator!.showWithText('Wait a sec');
                          args['title'] = titleCon.text;
                          args['categories'] = selectedCat;
                          await saveQuiz(args);
                          _progressIndicator.dismiss();
                          Navigator.pushNamed(
                              context, QuizAddedCompleteView.id);
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
                            Text('Save Quiz'),
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
          ),
        ),
      ),
    );
  }
}
