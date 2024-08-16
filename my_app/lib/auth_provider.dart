import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  Map<String, dynamic> _userInfo = {};

  bool get isLoggedIn => _isLoggedIn;
  Map<String, dynamic> get userInfo => _userInfo;

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        _isLoggedIn = true;
        _userInfo = data['user']; // 서버로부터 받은 사용자 정보 저장
        notifyListeners();
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      print('Error during login: $e');
      throw e;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _isLoggedIn = false;
    _userInfo = {};
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    _isLoggedIn = token != null;

    if (_isLoggedIn) {
      // 토큰이 존재하면 서버에서 사용자 정보를 가져옵니다.
      try {
        final response = await http.get(
          Uri.parse('http://localhost:8080/api/user_info'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          _userInfo = jsonDecode(response.body);
        } else {
          _isLoggedIn = false;
        }
      } catch (e) {
        print('Error during fetching user info: $e');
        _isLoggedIn = false;
      }
    }
    notifyListeners();
  }
}
