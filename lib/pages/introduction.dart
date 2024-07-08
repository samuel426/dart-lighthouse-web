import 'package:flutter/material.dart';
import '../header.dart';
import '../footer.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(),
      body: Center(
        child: Text('등대 소개 페이지 콘텐츠'),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
