import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../header.dart';
import '../footer.dart';
import '../auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _isLoading = false; // 중복 요청 방지

  Future<void> _login() async {
    setState(() {
      _isLoading = true; // 로그인 요청 시작
      _errorMessage = ''; // 기존 오류 메시지 초기화
    });

    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      await Provider.of<AuthProvider>(context, listen: false)
          .login(email, password);
      context.go('/'); // 로그인 성공 시 홈 페이지로 이동
    } catch (e) {
      setState(() {
        _errorMessage = e.toString(); // 오류 메시지 설정
      });
      print('Error during login: $e');
    } finally {
      setState(() {
        _isLoading = false; // 로그인 요청 종료
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 450,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 450,
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator() // 로딩 표시 추가
              else
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: const Text('로그인'),
                  ),
                ),
              const SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              TextButton(
                onPressed: () {
                  context.go('/signup');
                },
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
