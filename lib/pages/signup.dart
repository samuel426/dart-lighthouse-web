import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../header.dart';
import '../footer.dart';
import '../auth_provider.dart';
import '../models/user.dart';

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
  String _errorMessage = '';
  String _memberType = 'YB'; // 기본값을 YB로 설정

  Future<void> _signup() async {
    final String email = _emailController.text;
    final String name = _nameController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    final int joinYear = int.parse(_joinYearController.text);

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = '비밀번호가 일치하지 않습니다.';
      });
      return;
    }

    final int generation = joinYear - 1979 + 1;

    final user = User(
      email: email,
      name: name,
      password: password,
      joinYear: joinYear,
      memberType: _memberType, // YB/OB 정보 추가
    );

    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .registerUser(user);
      context.go('/login'); // Go to login page
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      print('Error during signup: $e');
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
                children: [
                  Radio<String>(
                    value: 'YB',
                    groupValue: _memberType,
                    onChanged: (value) {
                      setState(() {
                        _memberType = value!;
                      });
                    },
                  ),
                  const Text('YB'),
                  Radio<String>(
                    value: 'OB',
                    groupValue: _memberType,
                    onChanged: (value) {
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
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
