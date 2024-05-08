import 'dart:convert';
// import 'dart:html';
import 'package:choultry/Screens/home_screen.dart';
import 'package:choultry/Screens/otp_screen.dart';
import 'package:choultry/rounded_button.dart';
import 'package:choultry/services/auth_services.dart';
import 'package:choultry/services/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _phone = '';
  String _password = '';
  // bool _rememberMe = true;

  void loginPressed() async{
    // print("object object");
    if(_phone.isNotEmpty && _password.isNotEmpty){
      http.Response response = await AuthServices.login(_phone, _password);
      Map responseMap = jsonDecode(response.body);
      debugPrint('responseMap $responseMap');
      // log('Data : $Url');
      const storage = FlutterSecureStorage();
      await storage.write(key: 'access_token', value: responseMap["token"]); 
      if(response.statusCode==200){
        Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen()));
      }
      else{
        // ignore: use_build_context_synchronously
        errorSnackBar(context, responseMap.values.first);
      }
    }else{
      errorSnackBar(context, 'enter all required fields');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
              ),
              onChanged: (value) {
                _phone = value;
              } ,
              
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
              onChanged: (value) {
                _password = value;
              } ,
              
            ),
            // Checkbox(value: _rememberMe, onChanged: (value) { 
            //   _rememberMe = true;
            //   const Text('remember me');
            // }),
            const SizedBox(
              height: 30,
            ),
            RoundedButton(btnText: 'LOGIN', onBtnPressed: ()=> loginPressed(),),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>  OTPScreen(),
                    ));
              },
              child: const Text(
                'Login with otp',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
}

