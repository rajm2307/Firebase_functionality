// import 'dart:convert';
// import 'dart:developer';

// import 'package:demo_project/core/api-routes/api-routes.dart';
// import 'package:demo_project/homepage/controller/controller.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 

// class AuthException implements Exception {
//   final String message;
//   AuthException(this.message);

//   @override
//   String toString() => message;
// }

// class AuthService {
//   static Future<String> login({
//     required String username,
//     required String password,
//   }) async {
//     final response = await http.post(
//       Uri.parse(ApiRoutes.login),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({'username': username, 'password': password}),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final jsonData = json.decode(response.body);
//       return jsonData['token'] as String;
//     } else if (response.statusCode == 401) {
//       throw AuthException('Invalid username or password');
//     } else {
//       throw Exception('Login failed. Status code: ${response.statusCode}');
//     }
//   }
// }

// // class TokenStorage {
// //   // static const _storage = FlutterSecureStorage();
// //   static const _key = 'auth_token';

// //   static Future<void> save(String token) =>
// //       _storage.write(key: _key, value: token);

// //   static Future<String?> read() => _storage.read(key: _key);

// //   static Future<void> clear() => _storage.delete(key: _key);
// // }