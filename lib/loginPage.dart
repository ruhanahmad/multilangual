import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multitranslation/const.dart';
import 'package:multitranslation/forgetPassword.dart';
import 'package:multitranslation/selectPayment.dart';
import 'package:multitranslation/signUp.dart';
import 'package:multitranslation/signupPage.dart';
import 'package:multitranslation/splashpage.dart';
import 'package:multitranslation/storage/storage.dart';

import 'storage/keys.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    if (!_validateFields()) {
      return;
    }

    try {
      EasyLoading.show();
      final response = await http.post(
        Uri.parse(
          'https://translation.saeedantechpvt.com/api/auth/login?email=${emailController.text}&password=${passwordController.text}',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String token = data['data']['token'];
        final Map<String, dynamic> userData = data['data']['user'];
        StorageServices.to.setString(key: userToken, value: token);
        // Login successful, redirect to splash screen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
        Get.to(() => SelectPaymentMethods(token: token, userData: userData));
        // Get.to(() => SplashScreen(token: token, userData: userData));
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: 'Login failed. Please check your credentials.');
      }
    } catch (e) {
      EasyLoading.dismiss();
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
                    "Sign In",
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
              SizedBox(
                height: 20.h,
              ),
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
                    hintText: 'Password'),
              ),
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      Get.to(() => ForgotPasswordScreen());
                    },
                    child: Text(
                      "Forget Password",
                      style: TextStyle(color: color),
                    )),
              ),
              SizedBox(height: 20.h),
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
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to the sign-up page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
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
