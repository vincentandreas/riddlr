import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_on_2021_competition/constants/app_constants.dart';
import 'package:start_on_2021_competition/utils/no_splash_scroll_behaviour.dart';
import 'package:start_on_2021_competition/views/main_feeds_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: NoSplashScrollBehaviour(),
      title: 'Riddlr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: kTealColor),
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: routes,
      initialRoute: MainFeedsView.id,
    );
  }
}
