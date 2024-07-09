import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/user.dart';

class AuthProvider with ChangeNotifier {
  bool _loggedIn = false;
  User? _currentUser;

  bool get loggedIn => _loggedIn;
  User? get currentUser => _currentUser;

  AuthProvider() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    if (email != null) {
      _loggedIn = true;
      final box = Hive.box<User>('users');
      _currentUser = box.values.cast<User?>().firstWhere(
            (user) => user?.email == email,
            orElse: () => null,
          );
    } else {
      _loggedIn = false;
      _currentUser = null;
    }
    notifyListeners();
  }

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
        final responseBody = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        _loggedIn = true;
        _currentUser = User(
            email: email,
            name: '',
            password: password,
            joinYear: 0,
            memberType: '');
        notifyListeners();
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception('Login failed: ${errorResponse['error']}');
      }
    } catch (e) {
      print('Error during login: $e');
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    _loggedIn = false;
    _currentUser = null;
    notifyListeners();
  }

  Future<void> registerUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': user.email,
          'name': user.name,
          'password': user.password,
          'joinYear': user.joinYear.toString(),
          'memberType': user.memberType,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final box = Hive.box<User>('users');
        await box.put(user.email, user);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception('Signup failed: ${errorResponse['error']}');
      }
    } catch (e) {
      print('Error during signup: $e');
      throw Exception('Signup failed: $e');
    }
  }
}
