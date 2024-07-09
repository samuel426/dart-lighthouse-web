import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../header.dart';
import '../footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 배경 이미지 섹션
            Stack(
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'assets/home.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.asset(
                      'assets/icon1_cropped.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 최근 게시글 현황 섹션
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '최근 게시글 현황',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildRecentPostButton(
                    context,
                    '7월 16일 농활',
                    '7월 봉사 일정',
                    '등대 달력',
                    'YB',
                  ),
                  const SizedBox(height: 10),
                  _buildRecentPostButton(
                    context,
                    'OB 연회비 공지사항',
                    '등대 OB 공지사항',
                    '공지 게시판',
                    'OB',
                  ),
                  const SizedBox(height: 10),
                  _buildRecentPostButton(
                    context,
                    '플로깅 봉사인원 모집',
                    '8월 플로깅 인원 모집',
                    '자유 게시판',
                    'YB',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 등대 섹션
            Stack(
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    'assets/home1.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        '등대',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        '인스타 링크',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _launchURL(
                              'https://www.instagram.com/lighthouse_official_/');
                        },
                        child: const Text('방문하기'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildRecentPostButton(BuildContext context, String title,
      String subtitle, String location, String authorCircle) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(16.0),
        elevation: 1,
      ),
      onPressed: () {
        // 게시글 링크 처리
      },
      child: Row(
        children: [
          CircleAvatar(
            child: Text(authorCircle),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                location,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
