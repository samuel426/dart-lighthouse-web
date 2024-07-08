import 'package:flutter/material.dart';
import '../header.dart';
import '../footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(),
      body: Center(
        child: Text('메인 페이지 콘텐츠'),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}

// 다른 페이지 파일들도 이 구조를 따라 작성합니다 (login.dart, introduction.dart, 등등)
