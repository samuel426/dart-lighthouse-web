import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          title: GestureDetector(
            onTap: () {
              context.go('/');
            },
            child: const Text(
              '등대',
              style: TextStyle(color: Colors.black),
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
            if (auth.loggedIn) ...[
              TextButton(
                onPressed: () {
                  context.go('/user');
                },
                child:
                    const Text('사용자 정보', style: TextStyle(color: Colors.black)),
              ),
              TextButton(
                onPressed: () {
                  auth.logout();
                  context.go('/login');
                },
                child:
                    const Text('로그아웃', style: TextStyle(color: Colors.black)),
              ),
            ] else ...[
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('로그인/회원가입',
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ],
        ),
        const Divider(height: 1, color: Colors.black),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
