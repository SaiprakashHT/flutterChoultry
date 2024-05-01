import 'dart:convert';

import 'package:choultry/services/globals.dart';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:http/http.dart';

class AuthServices{
  static Future<http.Response> register(
    String name, String phone, String email, String password, String c_password) async{
    Map data = {
      "name" :name,
      "phone" :phone,
      "email" :email,
      "password" :password,
      "c_password" :c_password,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}auth/register');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
      );
      

      print(response.body);
      // debugPrint('debug: $response');
      // debugPrint('$response.statusCode');
      // print(response.statusCode);
      return response;
  }

static Future<http.Response> login(String phone, String password) async{
    Map data = {
      "phone" :phone,
      "password" :password,
      "device_name": 'mobile'
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
      );


  // debugPrint('debug: $Response');
   print(response.body);
      return response;

  }

  static Future<http.Response> index(
    String id, String name, String address, String pin, 
    String phone_number, String email, String pname, String user_id) async{
    Map data = {
      "id" :id,
      "name" :name,
      "address": address,
      "pin": pin,
      "phone_number": phone_number,
      "email": email,
      "pname": pname,
      "user_id": user_id,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}auth/choutries');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
      );


  // debugPrint('debug: $Response');
   print(response.body);
      return response;

  }
}