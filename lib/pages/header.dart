import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white, // 배경색을 하얀색으로 설정
          title: GestureDetector(
            onTap: () {
              context.go('/');
            },
            child: const Text(
              '등대',
              style: TextStyle(color: Colors.black), // 텍스트 색상 변경
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.go('/introduction');
              },
              child: const Text('등대 소개', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                context.go('/calendar');
              },
              child: const Text('등대 달력', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                context.go('/notice');
              },
              child:
                  const Text('공지 게시판', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                context.go('/free');
              },
              child:
                  const Text('자유 게시판', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                context.go('/inquiry');
              },
              child: const Text('문의사항', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child:
                  const Text('로그인/회원가입', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
        const Divider(height: 1, color: Colors.black), // 구분선 추가
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
