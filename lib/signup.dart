import 'dart:convert';

import 'package:choultry/Screens/home_screen.dart';
import 'package:choultry/Screens/login_screen.dart';
import 'package:choultry/rounded_button.dart';
import 'package:choultry/services/auth_services.dart';
import 'package:choultry/services/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _password = '';
  String _name = '';
  String _phone = '';
  String _c_password ='';

  void createAccountPressed() async {
    
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);
    if (emailValid) {
      http.Response response =await AuthServices.register(_name, _phone, _email, _password, _c_password);
      Map responseMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen()));
                debugPrint('Data: $BuildContext');
      } else {
        // ignore: use_build_context_synchronously
        errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'email not valid');
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
          'Registration',
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
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
              onChanged: (value) {
                _name = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Phone',
              ),
              onChanged: (value) {
                _phone = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
              const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
              ),
              onChanged: (value) {
                _c_password = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedButton(
              btnText: 'Create Account',
              onBtnPressed: () => createAccountPressed(),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen(),
                    ));
              },
              child: const Text(
                'already have an account',
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









// import 'dart:convert';

// import 'package:choultry/Screens/home_screen.dart';
// import 'package:choultry/services/auth_services.dart';
// import 'package:choultry/services/globals.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/widgets.dart';

// TextEditingController nameController = TextEditingController();
// TextEditingController phoneController = TextEditingController();
// TextEditingController emailController = TextEditingController();
// TextEditingController passwordController = TextEditingController();


// class SignUpForm extends StatefulWidget {
//   const SignUpForm({super.key});

//   @override
//   State<SignUpForm> createState() => _SignUpFormState();
// }


// class _SignUpFormState extends State<SignUpForm> {
//   String _email = '';
//   String _password = '';
//   String _name = '';
//   String _phone = '';

// loginPressed(){

// }

// createAccountPressed() async{
//   bool emailValid = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$').hasMatch(_email);
//   if(emailValid){
//     http.Response response =await AuthServices.register(_name, _phone, _email, _password);
//     Map responseMap = jsonDecode(response.body);
//     if(response.statusCode==200){
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));

//     }else{
//       errorSnackBar(context, responseMap.values.first[0]);
//     }

//   }else{
//     errorSnackBar(context, 'email not valid');
//   }
// }

//   final _formkey = GlobalKey<FormState>();
//   bool isLogin = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Colors.purple,
      
//       //   title: Text('Sign up'),
//       // ),
//       body: Form(
//         key: _formkey,
//         child: Container(
          
//           margin: EdgeInsets.all(10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
            
//             SizedBox(height: 1),
              
//             Container(
//                 //  mainAxisAlignment: MainAxisAlignment.start
//                 child: Text('Sign up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            
//               !isLogin? TextFormField(
//                 // key: ValueKey('username'),
//                 decoration: InputDecoration(hintText: "Full Name" ),
//                 onChanged: (value){
//                   _name =  value;
//                 },
//                 //controller: nameController,
//   // decoration: InputDecoration(labelText: 'Name'),
//               ) : Container(),
//               !isLogin? TextFormField(
//                 key: ValueKey('phone number'),
//                 decoration: InputDecoration(hintText: "Phone Number"),
//                 // controller: phoneController,
//                 onChanged: (value){
//                   _phone =  value;
//                 },


//               ): Container(),
//               TextFormField(
//                 key: ValueKey('email'),
//                 decoration: InputDecoration(hintText: "Enter Email"),
//                 //controller: emailController,
//                 onChanged: (value){
//                   _email =  value;
//                 },

//               ),
//               TextFormField(
//                 obscureText: true,
//                 key: ValueKey('password'),
//                 decoration: InputDecoration(hintText: "Enter Password"),
//                 //controller: passwordController,
//                 onChanged: (value){
//                   _password =  value;
//                 },

//               ),
//               SizedBox(
//                 height: 10,
//               ),
              
//             // Row(
//             //   children: [
//             //     Checkbox(value: false, onChanged: (value) {}),
//             //     Text('By signing up, you’re agree to our '),
//             //     TextButton(
//             //       onPressed: () {
//             //         // Open Terms & Conditions page
//             //       },
//             //       child: Text('Terms & Conditions'),
//             //     ),
//             //   ],
//             // ),
//             // Row(
//             //   children: [
//             //     Checkbox(value: false, onChanged: (value) {}),
//             //     Text('Agree to get SMS'),
//             //   ],
//             // ),
//             SizedBox(height: 10.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                  ElevatedButton(onPressed: (){
//                   child: isLogin? loginPressed() :
//                   createAccountPressed();
//                   //Text('Succesfully registered');
//                   signUp(nameController.text, emailController.text, passwordController.text);
//                  }, child: isLogin? Text('Login') : Text('Create Account')), 
//               ],
//           ),
//         // Container(
//         //         // mainAxisAlignment: MainAxisAlignment.center,
//         //         width: 327,
//         //         height: 50,
//         //         child: ElevatedButton(onPressed: (){}, child:isLogin?Text('Login') : Text('Create Account'))),
            
//             SizedBox(height: 10.0),
            
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 isLogin? Text("Don't have an Account") :
//                 Text('Joined us before?'),
//                 TextButton(onPressed: (){
//                 setState(() {
//                   isLogin = !isLogin;
//                 });
//               }
              
//               , child: isLogin? Text("Register") : Text('Login')),
//               ],
//             ),
//               ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<void> signUp(String name, String email, String password) async {
//   const url = 'http://localhost/phpmyadmin/users';
//   final response = await http.post(
//     Uri.parse(url),
//     body: {
//       'name': name,
//       'email': email,
//       'password': password,
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