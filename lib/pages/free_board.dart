import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

class FreeBoardPage extends StatelessWidget {
  const FreeBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(),
      body: Center(
        child: Text('자유 게시판 페이지 콘텐츠'),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
