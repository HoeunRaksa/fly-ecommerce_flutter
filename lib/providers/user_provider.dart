import 'dart:io';
import 'package:flutter/material.dart';

import '../../model/user_auth.dart';
import '../features/auth/provider/auth_provider.dart';
import '../features/service/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService userService;
  final AuthProvider authProvider;

  User? _user;
  bool _isLoading = false;
  bool _hasFetched = false;
  String? _error;

  UserProvider({
    required this.userService,
    required this.authProvider,
  });

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get hasFetched => _hasFetched;
  String? get error => _error;

  // ==============================
  // Fetch user (once)
  // ==============================
  Future<void> fetchUser() async {
    if (_hasFetched || _isLoading) return;

    final token = authProvider.token;
    if (token == null || token.isEmpty) return;

    _setLoading(true);

    try {
      _user = await userService.getUser(token);
      _hasFetched = true;
      _error = null;
    } catch (e) {
      _error = 'Failed to load user';
      debugPrint('fetchUser error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // ==============================
  // Update profile
  // ==============================
  Future<bool> updateProfile({String? name, String? email}) async {
    final token = authProvider.token;
    if (token == null || token.isEmpty) return false;

    _setLoading(true);

    try {
      _user = await userService.updateProfile(
        token,
        name: name,
        email: email,
      );
      _error = null;
      return true;
    } catch (e) {
      _error = 'Failed to update profile';
      debugPrint('updateProfile error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ==============================
  // Upload profile image
  // ==============================
  Future<bool> uploadProfileImage(File imageFile) async {
    final token = authProvider.token;
    if (token == null || token.isEmpty) return false;

    _setLoading(true);

    try {
      _user = await userService.uploadProfileImage(token, imageFile);
      _error = null;
      return true;
    } catch (e) {
      _error = 'Failed to upload image';
      debugPrint('uploadProfileImage error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ==============================
  // Reset on logout
  // ==============================
  void clear() {
    _user = null;
    _hasFetched = false;
    _error = null;
    notifyListeners();
  }

  // ==============================
  // Private helper
  // ==============================
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
