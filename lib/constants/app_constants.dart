import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:start_on_2021_competition/components/save_mca_details.dart';
import 'package:start_on_2021_competition/views/edit_mca_new.dart';
import 'package:start_on_2021_competition/views/main_feeds_view.dart';
import 'package:start_on_2021_competition/views/ocr_generation_wait_view.dart';
import 'package:start_on_2021_competition/views/quiz_added_complete_view.dart';
import 'package:start_on_2021_competition/views/quiz_generation_wait_view.dart';
import 'package:start_on_2021_competition/views/review_ocr_result.dart';
import 'package:start_on_2021_competition/views/see_mca_detail.dart';

const String userId = "OoPNDKk7SFwKuGEZD1LR";
const Color kScaffoldBackgroundColor = Color(0XFFF6EEFB);
const Color kTealColor = Color(0XFF50C1BE);
const Color kRedColor = Color(0XFFEE5938);
const Color kPurpleColor = Color(0xff835E98);
const Color kBlueColor = Color(0XFF6ACED8);
const Color kOrangeColor = Color(0XFFF8A700);
const String ocr_apikey = "ee0719edcf88957";

// const String sampleQuestionResponse = """{
//     "questions": [
//         {
//             "answer": 0,
//             "options": [
//                 "Brett Lee",
//                 "Footballer",
//                 "International Cricket"
//             ],
//             "question": "What is Sachin Ramesh Tendulkar's career?"
//         },
//         {
//             "answer": 1,
//             "options": [
//                 "Bangladesh",
//                 "Indonesia",
//                 "China"
//             ],
//             "question": "Where is Sachin Ramesh Tendulkar from?"
//         },
//         {
//             "answer": 2,
//             "options": [
//                 "Bowlers",
//                 "Wickets",
//                 "Mccullum"
//             ],
//             "question": "What is the best cricketer?"
//         }
//     ],
//     "text": "Sachin Ramesh Tendulkar is a former international cricketer from India and a former captain of the Indian national team. He is widely regarded as one of the greatest batsmen in the history of cricket. He is the highest run scorer of all time in International cricket."
// }""";
//
// const String sampleQuizzesResponse = """{
//     "quizzes": [
//         {
//             "article": "Lorem ipsum, atau ringkasnya lipsum, adalah teks standar yang ditempatkan untuk mendemostrasikan elemen grafis atau presentasi visual seperti font,",
//             "qasets": [
//                 {
//                     "correct": 3,
//                     "options": [
//                         "asep",
//                         "mugi",
//                         "joko",
//                         "mark"
//                     ],
//                     "question": "siapa penyembah baphomet pertama"
//                 }
//             ],
//             "quiz_id": "eobVATut5d2bDll0qARG",
//             "title": "Baphomet",
//             "user_id": "OoPNDKk7SFwKuGEZD1LR",
//             "export_link": "https://storage.googleapis.com/starton-service.appspot.com/eobVATut5d2bDll0qARG.xlsx",
//             "categories": [
//               "Grade 3"
//             ]
//         },
//         {
//             "article": "Sachin Ramesh Tendulkar is a former international cricketer from India and a former captain of the Indian national team. He is widely regarded as one of the greatest batsmen in the history of cricket. He is the highest run scorer of all time in International cricket.",
//             "qasets": [
//                 {
//                     "correct": 3,
//                     "options": [
//                         "Brett Lee",
//                         "Footballer",
//                         "International Cricket",
//                         "cricketer"
//                     ],
//                     "question": "What is Sachin Ramesh Tendulkar's career?"
//                 }
//             ],
//             "quiz_id": "uz2YvYApNILRRWNOR4vv",
//             "title": "Sachin Ramesh",
//             "user_id": "OoPNDKk7SFwKuGEZD1LR",
//             "export_link": "https://storage.googleapis.com/starton-service.appspot.com/uz2YvYApNILRRWNOR4vv.xlsx",
//             "categories": [
//               "Grade 1"
//             ]
//         }
//     ]
// }""";

var routes = {
  MainFeedsView.id: (context) => MainFeedsView(),
  ReviewOcrResult.id: (context) => ReviewOcrResult(),
  SeeMcaDetail.id: (context) => SeeMcaDetail(),
  QuizGenerationWaitView.id: (context) => QuizGenerationWaitView(),
  QuizAddedCompleteView.id: (context) => QuizAddedCompleteView(),
  EditMcaNew.id: (context) => EditMcaNew(),
  SaveMcaDetails.id: (context) => SaveMcaDetails(),
  OcrGenerationWaitView.id: (context) => OcrGenerationWaitView(),
};

List<String> kCategoriesOptions = [
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
