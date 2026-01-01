import 'package:flutter/material.dart';
import '../../../model/user_auth.dart';
import '../service/authService.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;
  bool get isLoggedIn => _user != null && _token != null;

  Future<void> login(String email, String password) async {
    final result = await _authService.login(email, password);
    _user = result['user'];
    _token = result['token'];
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    final result = await _authService.register(name, email, password);
    _user = result['user'];
    _token = result['token'];
    notifyListeners();
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
