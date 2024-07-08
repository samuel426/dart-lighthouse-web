import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'auth_provider.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/introduction.dart';
import 'pages/calendar.dart';
import 'pages/notice_board.dart';
import 'pages/free_board.dart';
import 'pages/inquiry_board.dart';
import 'pages/user_info.dart'; // 사용자 정보 페이지 추가
import 'theme.dart';
import 'models/user.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
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
              path: '/user',
              builder: (context, state) => const UserInfoPage(),
            ),
          ],
          redirect: (BuildContext context, GoRouterState state) {
            final bool isLoggingIn =
                state.subloc == '/login' || state.subloc == '/signup';
            if (!auth.loggedIn && !isLoggingIn) {
              return '/login';
            }
            if (auth.loggedIn && isLoggingIn) {
              return '/';
            }
            return null;
          },
          refreshListenable: auth,
        );

        return MaterialApp.router(
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
          title: '등대',
          debugShowCheckedModeBanner: false,
          theme: myTheme,
        );
      },
    );
  }
}
