import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../config/app_config.dart';
import '../../model/user_auth.dart';

class UserService {
  UserService();

  Future<User> getUser(String token) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch user: ${response.body}');
    }
  }

  Future<User> updateProfile(String token, {String? name, String? email}) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/user'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['user']);
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }

  Future<User> uploadProfileImage(String token, File imageFile) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppConfig.baseUrl}/user/profile'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['user']);
    } else {
      throw Exception('Failed to upload profile image: ${response.body}');
    }
  }
}
