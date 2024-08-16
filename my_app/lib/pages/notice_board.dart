import 'package:flutter/material.dart';
import '../header.dart';
import '../footer.dart';

class NoticeBoardPage extends StatelessWidget {
  const NoticeBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(),
      body: Center(
        child: Text('공지사항 게시판 페이지 콘텐츠'),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
