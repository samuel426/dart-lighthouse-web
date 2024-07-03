import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(),
      body: Center(
        child: Text('회원가입/로그인 페이지 콘텐츠'),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
