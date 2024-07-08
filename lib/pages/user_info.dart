import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_provider.dart';
import '../header.dart';
import '../footer.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (!auth.loggedIn) {
      return const Scaffold(
        appBar: Header(),
        body: Center(
          child: Text('로그인이 필요합니다.'),
        ),
        bottomNavigationBar: Footer(),
      );
    }

    return Scaffold(
      appBar: const Header(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('이메일: ${auth.currentUser?.email ?? ''}'),
              Text('이름: ${auth.currentUser?.name ?? ''}'),
              Text('등대 가입 년도: ${auth.currentUser?.joinYear ?? ''}'),
              Text('기수: ${auth.currentUser?.generation ?? ''}기'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
