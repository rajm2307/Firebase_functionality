// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:demo_project/core/api-routes/api-routes.dart';

// class SignupService {
//   static Future<void> signup({
//     required String name,
//     required String phone,
//     required String email,
//     required String password,
//   }) async {
//     final parts = name.trim().split(RegExp(r'\s+'));
//     final firstName = parts.first;
//     final lastName = parts.length > 1 ? parts.skip(1).join(' ') : '';

//     final response = await http.post(
//       Uri.parse(ApiRoutes.signup),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'email': email,
//         'username': email.split('@').first,
//         'password': password,
//         'name': {'firstname': firstName, 'lastname': lastName},
//         'phone': phone,
//       }),
//     );

//     if (response.statusCode != 200 && response.statusCode != 201) {
//       throw Exception('Signup failed. Status code: ${response.statusCode}');
//     }
//   }
// }