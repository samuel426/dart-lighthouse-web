import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/introduction.dart';
import 'pages/calendar.dart';
import 'pages/notice_board.dart';
import 'pages/free_board.dart';
import 'pages/inquiry_board.dart';
import 'pages/user_info.dart';

void main() {
  setUrlStrategy(PathUrlStrategy()); // URL 전략 설정
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/introduction',
        builder: (context, state) => const IntroductionPage(),
      ),
      GoRoute(
        path: '/calendar',
        builder: (context, state) => const CalendarPage(),
      ),
      GoRoute(
        path: '/notice',
        builder: (context, state) => const NoticeBoardPage(),
      ),
      GoRoute(
        path: '/free',
        builder: (context, state) => const FreeBoardPage(),
      ),
      GoRoute(
        path: '/inquiry',
        builder: (context, state) => const InquiryBoardPage(),
      ),
      GoRoute(
        path: '/user_info',
        builder: (context, state) => const UserInfoPage(),
      ),
    ],
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider()..checkLoginStatus(),
      child: MaterialApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        title: '등대',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white, // 배경을 흰색으로 설정
        ),
      ),
    );
  }
}
