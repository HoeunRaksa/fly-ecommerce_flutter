import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:fly/config/app_config.dart';
import '../../../model/user_auth.dart';

class AuthService {
  // ---------------- LOGIN ----------------
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/login"),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );

    debugPrint('Login status: ${response.statusCode}');
    debugPrint('Login body: ${response.body}');

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['success'] == true) {
      return User.fromApiResponse(data);
    } else {
      throw Exception(data['message'] ?? 'Login failed');
    }
  }

  // ---------------- REGISTER ----------------
  Future<User?> register(
      String name,
      String email,
      String password, {
        File? profileImage,
      }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${AppConfig.baseUrl}/register"),
    );

    // Add text fields
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;

    // Add profile image if provided
    if (profileImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_image',
          profileImage.path,
        ),
      );
    }

    request.headers['Accept'] = 'application/json';

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    debugPrint('Register status: ${response.statusCode}');
    debugPrint('Register body: ${response.body}');

    Map<String, dynamic>? data;
    try {
      data = jsonDecode(response.body);
    } catch (_) {
      debugPrint("Non-JSON response, assume OTP sent");
      return User(
        id: '',
        name: name,
        email: email,
        role: 'user',
        isVerified: false,
        token: null,
      );
    }

    if (response.statusCode == 200 && data?['success'] == true) {
      return User(
        id: '',
        name: name,
        email: email,
        role: 'user',
        isVerified: false,
        token: null,
      );
    } else {
      throw Exception(data?['message'] ?? 'Failed to register');
    }
  }

  // ---------------- VERIFY OTP ----------------
  Future<User> verifyOtp(String email, String otp) async {
    try {
      debugPrint('Verifying OTP for email: $email, OTP: $otp');

      final response = await http.post(
        Uri.parse("${AppConfig.baseUrl}/verify-otp"),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'otp': otp},
      );

      debugPrint('Verify OTP status: ${response.statusCode}');
      debugPrint('Verify OTP body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return User.fromApiResponse(data);
        } else {
          throw Exception(data['message'] ?? 'OTP verification failed');
        }
      } else {
        try {
          final data = jsonDecode(response.body);
          throw Exception(data['message'] ?? 'OTP verification failed');
        } catch (e) {
          if (response.statusCode == 400) {
            throw Exception('Invalid or expired OTP');
          } else if (response.statusCode == 404) {
            throw Exception('Email not found');
          } else {
            throw Exception('Server error: ${response.statusCode}');
          }
        }
      }
    } catch (e) {
      debugPrint('Error in verifyOtp: $e');
      rethrow;
    }
  }

  // ---------------- RESEND OTP ----------------
  Future<void> resendOtp(String email) async {
    try {
      debugPrint('Resending OTP to: $email');

      final response = await http.post(
        Uri.parse("${AppConfig.baseUrl}/resend-otp"),
        headers: {'Accept': 'application/json'},
        body: {'email': email},
      );

      debugPrint('Resend OTP status: ${response.statusCode}');
      debugPrint('Resend OTP body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception(data['message'] ?? 'Failed to resend OTP');
        }
        return;
      } else {
        try {
          final data = jsonDecode(response.body);
          throw Exception(data['message'] ?? 'Failed to resend OTP');
        } catch (e) {
          throw Exception('Failed to resend OTP');
        }
      }
    } catch (e) {
      debugPrint('Error in resendOtp: $e');
      rethrow;
    }
  }

  // ---------------- GET CURRENT USER ----------------
  Future<User> getUser(String token) async {
    try {
      debugPrint('Fetching current user');

      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}/user"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      debugPrint('Get user status: ${response.statusCode}');
      debugPrint('Get user body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          // The user data is in data['data']
          return User.fromJson(data['data']);
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch user');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthenticated');
      } else {
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      debugPrint('Error in getUser: $e');
      rethrow;
    }
  }

  // ---------------- UPDATE PROFILE ----------------
  Future<User> updateProfile({
    required String token,
    String? name,
    String? email,
    String? password,
    File? profileImage,
  }) async {
    try {
      debugPrint('Updating profile');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppConfig.baseUrl}/update-profile"),
      );

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      // Add fields only if they're provided
      if (name != null) request.fields['name'] = name;
      if (email != null) request.fields['email'] = email;
      if (password != null) request.fields['password'] = password;

      // Add profile image if provided
      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profile_image',
            profileImage.path,
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('Update profile status: ${response.statusCode}');
      debugPrint('Update profile body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return User.fromJson(data['data']);
        } else {
          throw Exception(data['message'] ?? 'Failed to update profile');
        }
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      debugPrint('Error in updateProfile: $e');
      rethrow;
    }
  }

  // ---------------- DELETE PROFILE IMAGE ----------------
  Future<void> deleteProfileImage(String token) async {
    try {
      debugPrint('Deleting profile image');

      final response = await http.delete(
        Uri.parse("${AppConfig.baseUrl}/profile-image"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      debugPrint('Delete profile image status: ${response.statusCode}');
      debugPrint('Delete profile image body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] != true) {
          throw Exception(data['message'] ?? 'Failed to delete profile image');
        }
        return;
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Failed to delete profile image');
      }
    } catch (e) {
      debugPrint('Error in deleteProfileImage: $e');
      rethrow;
    }
  }

  // ---------------- LOGOUT ----------------
  Future<void> logout(String token) async {
    try {
      debugPrint('Logging out');

      final response = await http.post(
        Uri.parse("${AppConfig.baseUrl}/logout"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      debugPrint('Logout status: ${response.statusCode}');
      debugPrint('Logout body: ${response.body}');

      if (response.statusCode != 200) {
        debugPrint('⚠️ Logout returned non-200 status');
      }
    } catch (e) {
      debugPrint('Logout request failed: $e');
      // Don't throw - local logout should still work
    }
  }
}