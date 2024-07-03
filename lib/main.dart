import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'introduction.dart';
import 'calendar.dart';
import 'notice_board.dart';
import 'free_board.dart';
import 'inquiry_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '등대',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => LoginPage(),
        '/introduction': (context) => IntroductionPage(),
        '/calendar': (context) => CalendarPage(),
        '/notice': (context) => NoticeBoardPage(),
        '/free': (context) => FreeBoardPage(),
        '/inquiry': (context) => InquiryBoardPage(),
      },
    );
  }
}
