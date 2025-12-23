import 'package:fly/config/app_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_auth.dart';

class AuthService {
  Future<User>register(String name, String email, String password) async{
        final response = await http.post(Uri.parse("${AppConfig.baseUrl}/register"),
          body: {
          'name': name,
            'email' : email,
            'password' : password
          }
        );
        if(response.statusCode == 201){
          return User.fromJson(jsonDecode(response.body)['user']);
        }else {
          throw Exception('Failed to register');
        }
  }
  Future<User>login(String email, password) async{
        final response = await http.post(Uri.parse("${AppConfig.baseUrl}/login"),
          body: {
             'email' : email,
              'password' : password
          }
        );
        if(response.statusCode == 200){
          return User.fromJson(jsonDecode(response.body)['user']);
        }else{
          throw Exception('Invalid username or password!');
        }
  }
}