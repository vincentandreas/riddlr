import 'dart:async';
import 'dart:convert';

import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_on_2021_competition/components/recently_created_quiz_tiles.dart';
import 'package:start_on_2021_competition/constants/api_path.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';
import 'package:start_on_2021_competition/constants/assets_path.dart';
import 'package:start_on_2021_competition/views/ocr_generation_wait_view.dart';

class MainFeedsView extends StatefulWidget {
  const MainFeedsView({Key? key}) : super(key: key);
  static const String id = 'main_feed_view';

  @override
  _MainFeedsViewState createState() => _MainFeedsViewState();
}

class _MainFeedsViewState extends State<MainFeedsView> {
  var listQASets = [];
  var originQASets = [];
  List<String> kCategoriesTags = [];
  String searchText = '';
  Timer? _debounce;
  late Future<dynamic> _getQAData;
  late String hostUrl;

  @override
  void initState() {
    super.initState();
    _getQAData = getData();
    getData();
  }

  search() {
    List resultCategoriesFiltered = kCategoriesTags.isNotEmpty
        ? originQASets
            .where((element) => kCategoriesTags.every(
                  (e) => element['categories'].contains(e),
                ))
            .toList()
        : originQASets;
    listQASets = resultCategoriesFiltered
        .where(
          (element) => element['title'].toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    setState(() {});
  }

  onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchText = value;
      search();
    });
  }

  getHostUrl() async {
    CollectionReference hostref =
        FirebaseFirestore.instance.collection('hostUrls');

    var querySnapshot = await hostref.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    dynamic data = allData[0];

    hostUrl = data['hostUrls'];
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("hostUrl", hostUrl);
  }

  Row generateSearchBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Color.fromRGBO(142, 142, 147, .15),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Theme(
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: "Search my quiz...",
                  ),
                ),
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> getData() async {
    await getHostUrl();
    Client client = new Client();
    var res =
        await client.get(Uri.parse(hostUrl + quiz_url + '?user_id=' + userId));
    var dec = json.decode(res.body);
    listQASets = dec['quizzes'];
    originQASets = listQASets;
    setState(() {});
    return originQASets;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kScaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            'Hi, Naomi!',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            right: 15.0,
            bottom: 15.0,
            left: 15.0,
          ),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: FutureBuilder(
              future: _getQAData,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  if (originQASets.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: image1,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: Text(
                                'You have no quizzes yet.\nStart scanning your article and we\'ll do the magic!',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      generateSearchBar(context),
                      ChipsChoice<String>.multiple(
                        choiceStyle: C2ChoiceStyle(
                          borderRadius: BorderRadius.circular(10),
                          borderColor: Colors.transparent,
                          showCheckmark: false,
                        ),
                        choiceActiveStyle: C2ChoiceStyle(
                          color: kOrangeColor,
                        ),
                        value: kCategoriesTags,
                        onChanged: (val) async {
                          setState(
                            () {
                              kCategoriesTags = val;
                              search();
                            },
                          );
                        },
                        choiceItems: C2Choice.listFrom<String, String>(
                          source: kCategoriesOptions,
                          value: (i, v) => v,
                          label: (i, v) => v,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Recently Created'),
                      ),
                      RecentlyCreatedQuizTiles(
                        quizzes: listQASets,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text('Oh no D: something went wrong. Please try again'),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 10,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Please wait a sec, ready in a jiffy :D'),
                    ],
                  );
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            ImagePicker imagePicker = ImagePicker();
            XFile? picture = await imagePicker.pickImage(
              source: ImageSource.gallery,
            );
            String imagePath = picture?.path ?? '';

            if (imagePath != '')
              Navigator.pushNamed(
                context,
                OcrGenerationWaitView.id,
                arguments: imagePath,
              );
          },
          tooltip: 'add new quiz',
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
