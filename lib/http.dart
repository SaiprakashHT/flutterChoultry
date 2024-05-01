// // ignore: unused_import
// //import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// // Future<void> signUp(String name, String email, String password) async {
// //   final url = 'http://localhost/phpmyadmin/index.php?route=/sql&pos=0&db=choultry&table=users';
// //   final response = await http.post(
// //     url,
// //     body: {
// //       'name': name,
// //       'email': email,
// //       'password': password,
// //     },
// //   );

// //   if (response.statusCode == 201) {
// //     // Signup successful, handle response
// //   } else {
// //     // Signup failed, handle error
// //   }
// // }
// Future<void> signUp(String name, String phone, String email, String password, String c_password) async {
//   const url = 'http://10.0.2.2:8000/api';
//   final response = await http.post(
//     Uri.parse(url),
//     body: {
//       'name': name,
//       'phone': phone,
//       'email': email,
//       'password': password,
//       'c_password':c_password,
//     },
//   );

//   if (response.statusCode == 201) {
//     // Signup successful
//     print('Signup successful');
//   } else {
//     // Signup failed
//     print('Signup failed: ${response.body}');
//   }
// }
