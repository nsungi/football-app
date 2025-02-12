import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  AuthService(this.baseUrl);

  Future<bool> signUp(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    return response.statusCode == 201;
  }

  Future<bool> logIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Example: Save the authentication token securely
      await secureStorage.write(key: 'authToken', value: 'yourAuthToken');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    // Example: Check if there's a valid authentication token
    final authToken = await secureStorage.read(key: 'authToken');
    return authToken != null && authToken.isNotEmpty;
  }

  Future<void> logOut() async {
    // Example: Clear the stored authentication token on logout
    await secureStorage.delete(key: 'authToken');
  }
}
