import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'home.dart';
import 'login.dart';
import 'introduction.dart';
import 'calendar.dart';
import 'notice_board.dart';
import 'free_board.dart';
import 'inquiry_board.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '등대',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => HomePage();
            break;
          case '/login':
            builder = (BuildContext context) => LoginPage();
            break;
          case '/introduction':
            builder = (BuildContext context) => IntroductionPage();
            break;
          case '/calendar':
            builder = (BuildContext context) => CalendarPage();
            break;
          case '/notice':
            builder = (BuildContext context) => NoticeBoardPage();
            break;
          case '/free':
            builder = (BuildContext context) => FreeBoardPage();
            break;
          case '/inquiry':
            builder = (BuildContext context) => InquiryBoardPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      },
    );
  }
}
