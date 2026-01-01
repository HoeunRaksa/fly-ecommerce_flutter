import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fly/config/app_config.dart';
import '../../../model/user_auth.dart';

class AuthService {

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/login"),
      body: {'email': email, 'password': password},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final user = User.fromJson(data['user']);
      final token = data['token'] ?? '';
      if (token.isEmpty) throw Exception('Token not returned by server');
      return {'user': user, 'token': token};
    } else if (response.statusCode == 401) {
      throw Exception('Invalid email or password!');
    } else {
      throw Exception(data['message'] ?? 'Failed to login');
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/register"),
      body: {'name': name, 'email': email, 'password': password},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      final user = User.fromJson(data['user']);
      final token = data['token'] ?? '';
      return {'user': user, 'token': token};
    } else if (response.statusCode == 422) {
      throw Exception(data['message'] ?? 'Validation failed');
    } else {
      throw Exception(data['message'] ?? 'Failed to register');
    }
  }

// OTP methods remain unchanged
}
