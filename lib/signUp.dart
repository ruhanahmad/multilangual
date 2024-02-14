import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multitranslation/loginPage.dart';
import 'package:multitranslation/splashpage.dart';

class SignUpResponse {
  final bool success;
  final String message;

  SignUpResponse({required this.success, required this.message});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  Future<void> _login() async {
    // if (!_validateFields()) {
    //   return;
    // }

    try {
      final response = await http.post(
        Uri.parse(
          'https://translation.saeedantechpvt.com/api/auth/register',
        ),
        //  headers: {
        //   'Authorization':"Bearer " + token, // Replace with your actual auth token
        // },
        body: {
          'email': emailController.text,
          'password': passwordController.text,
          'firstname': firstNameController.text,
          'lastname': lastNameController.text
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        SignUpResponse signUpResponse = SignUpResponse.fromJson(data);
        // final String message = data['success'];
        //  final String messages = data['success'];

        if (signUpResponse.success) {
          // Navigate to another screen on success
          Get.to(() => LoginScreen());
        } else {
          // Show a toast or alert with the error message on failure
          Fluttertoast.showToast(
              msg: 'Login failed. Please check your credentials.');
        }

        // final Map<String, dynamic> userData = data['data']['user'];
        // Login successful, redirect to splash screen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
        // print(message);
        Get.to(() => LoginScreen());
      } else {
        Fluttertoast.showToast(
            msg: 'Login failed. Please check your credentials.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error during login. Please try again.');
    }
  }

  bool _validateFields() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill in all required fields');
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: Colors.black,
      // appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        // padding: EdgeInsets.all(16.w),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 212.h,
                  width: 182.w,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/pik.png",
                          ),
                          fit: BoxFit.contain)),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              SizedBox(
                height: 30.h,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: firstNameController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF832CE5),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide:
                            BorderSide(color: Color(0xFF832CE5), width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Color(0xFF832CE5))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Color(0xFF832CE5))),
                    hintText: 'First Name'),
              ),
              SizedBox(height: 16.h),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: lastNameController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF832CE5),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide:
                            BorderSide(color: Color(0xFF832CE5), width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Color(0xFF832CE5))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Color(0xFF832CE5))),
                    hintText: 'Last Name'),
              ),
              SizedBox(height: 16.h),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: emailController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xFF832CE5),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide:
                            BorderSide(color: Color(0xFF832CE5), width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Color(0xFF832CE5))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Color(0xFF832CE5))),
                    hintText: 'Email'),
              ),
              SizedBox(height: 16.h),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF832CE5),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide:
                            BorderSide(color: Color(0xFF832CE5), width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Color(0xFF832CE5))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Color(0xFF832CE5))),
                    hintText: 'Email'),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () async {
                  // Handle button press
                  await _login();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF832CE5), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Border radius
                  ),
                  minimumSize: Size(299.w, 39.h), // Width and height
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: "Already have an account ? ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Login Screen",
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to the sign-up page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                    ),
                  ],
                ),
              ),
              //  Align(
              //           alignment: Alignment.bottomLeft,
              //           child: Container(height: 212.h,width: 182.w,decoration: BoxDecoration(
              //             image: DecorationImage(image: AssetImage("asset/eli.png",),fit: BoxFit.contain)),),
              //         ),
            ],
          ),
        ),
      ),
    );
  }
}
