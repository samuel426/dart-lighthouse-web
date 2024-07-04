import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

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
