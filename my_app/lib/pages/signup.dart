import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:go_router/go_router.dart';
import '../header.dart';
import '../footer.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _joinYearController = TextEditingController();
  String _memberType = 'YB';
  String _errorMessage = '';

  Future<void> _signup() async {
    final String email = _emailController.text;
    final String name = _nameController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    final String joinYear = _joinYearController.text;

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = '비밀번호가 일치하지 않습니다.';
      });
      return;
    }

    final int currentYear = DateTime.now().year;
    final int generation = currentYear - int.parse(joinYear) + 1;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'name': name,
          'password': password,
          'joinYear': joinYear,
          'generation': generation,
          'memberType': _memberType,
        }),
      );

      if (response.statusCode == 200) {
        context.go('/login');
      } else {
        setState(() {
          _errorMessage = '회원가입 실패: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error during signup: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Padding(
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
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '이름',
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
            const SizedBox(height: 10),
            SizedBox(
              width: 450,
              child: TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호 확인',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 450,
              child: TextField(
                controller: _joinYearController,
                decoration: const InputDecoration(
                  labelText: '등대 가입 년도',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('회원 유형:'),
                Radio<String>(
                  value: 'YB',
                  groupValue: _memberType,
                  onChanged: (String? value) {
                    setState(() {
                      _memberType = value!;
                    });
                  },
                ),
                const Text('YB'),
                Radio<String>(
                  value: 'OB',
                  groupValue: _memberType,
                  onChanged: (String? value) {
                    setState(() {
                      _memberType = value!;
                    });
                  },
                ),
                const Text('OB'),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: _signup,
                child: const Text('회원가입'),
              ),
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
