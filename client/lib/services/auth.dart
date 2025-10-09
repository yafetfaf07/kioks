import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final storage = const FlutterSecureStorage();
    String apiBaseUrl="http://localhost:5000/api/users";
  // Login
  Future<Map<String, dynamic>?> login(String phoneNo, String password)  async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone_no': phoneNo, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storeTokens(data['accessToken'], data['refreshToken']);
      return data;
    } else {
      throw Exception('Login failed: ${response.statusCode}');
    }
  }

  // Register (similar to login)
  Future<Map<String, dynamic>?> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storeTokens(data['accessToken'], data['refreshToken']);
      return data;
    } else {
      throw Exception('Registration failed: ${response.statusCode}');
    }
  }

  // Store tokens securely
  Future<void> _storeTokens(String? accessToken, String? refreshToken) async {
    print("Access Token: $accessToken");
    print("Refresh Token: $refreshToken");
    if (accessToken != null) await storage.write(key: 'accessToken', value: accessToken);
    if (refreshToken != null) await storage.write(key: 'refreshToken', value: refreshToken);
  }

  // Get access token
  Future<String?> getAccessToken() async => await storage.read(key: 'accessToken');

  // Logout: Clear tokens
  Future<void> logout() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    // Optional: Call backend /auth/logout to clear cookies
    await http.post(Uri.parse('$apiBaseUrl/auth/logout'));
  }
}