import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
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

  Future<void> login(String email, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('email', email);
    _loggedIn = true;
    final box = Hive.box<User>('users');
    _currentUser = box.values.cast<User?>().firstWhere(
          (user) => user?.email == email,
          orElse: () => null,
        );
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('email');
    _loggedIn = false;
    _currentUser = null;
    notifyListeners();
  }

  Future<void> registerUser(User user) async {
    final box = Hive.box<User>('users');
    await box.put(user.email, user);
  }
}
