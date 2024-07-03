import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(),
      body: Center(
        child: Text('봉사 일정 캘린더 페이지 콘텐츠'),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
