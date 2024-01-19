import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multitranslation/loginPage.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> sendOtp() async {
    final response = await http.post(
      Uri.parse('https://translation.saeedantechpvt.com/api/auth/password/forgot?email=${emailController.text}'),
    );
 if (response.statusCode == 200) {
      
              final Map<String, dynamic> data = json.decode(response.body);
          int id = data['data']['id'];
           bool success = data['success'];
        // final String message = data['success'];
        //  final String messages = data['success'];
        


       // final Map<String, dynamic> userData = data['data']['user'];
        // Login successful, redirect to splash screen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
        // print(message);
        if(success == true) {
       Get.to(()=>VerifyOtpScreen(userId: id));
        }else {
 Fluttertoast.showToast(msg: 'Login failed. Please check your credentials.');
        }
      } else {
        Fluttertoast.showToast(msg: 'Login failed. Please check your credentials.');
      }
    // Parse the response and handle accordingly
    // ...

    // For demonstration purposes, assuming the API returns an 'id' in the response
    // int userId = 3; // Replace with the actual user id from the response

    // // Navigate to the next screen
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => VerifyOtpScreen(userId: userId),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Color(0xFF832CE5)),
                ),
                width: 299.w,
                height: 44.h,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.message, color: Color(0xFF832CE5)),
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await sendOtp();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF832CE5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(299, 39),
                ),
                child: Text('Send OTP', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifyOtpScreen extends StatefulWidget {
  final int userId;

  VerifyOtpScreen({required this.userId});

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
    TextEditingController otpController = TextEditingController();
  Future<void> verifyOtp() async {
    final response = await http.post(
      Uri.parse('https://translation.saeedantechpvt.com/api/auth/otp/verify?user_id=${widget.userId}&otp=${otpController.text}'),
    );

    // Parse the response and handle accordingly
    // ...
     if (response.statusCode == 200){

              final Map<String, dynamic> data = json.decode(response.body);
          String token = data['data']['token'];
           bool success = data['success'];

            if(success == true) {
       Get.to(()=> ResetPasswordScreen(token: token));
        }else {
 Fluttertoast.showToast(msg: 'Login failed. Please check your credentials.');
        }

     }
     else{
      Fluttertoast.showToast(msg: 'Api Error');
     }

    // For demonstration purposes, assuming the API returns a 'token' in the response
    // String token = 'your_token'; // Replace with the actual token from the response

    // // Navigate to the next screen
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ResetPasswordScreen(token: token),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Color(0xFF832CE5)),
                ),
                width: 299.w,
                height: 44.h,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: otpController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF832CE5)),
                    border: InputBorder.none,
                    hintText: 'Verify OTP',
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await verifyOtp();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF832CE5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(299, 39),
                ),
                child: Text('Verify OTP', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  ResetPasswordScreen({required this.token});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
    TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Future<void> resetPassword() async {
    final response = await http.post(
      Uri.parse('https://translation.saeedantechpvt.com/api/auth/password/reset?token=${widget.token}&password=${newPasswordController.text}&password_confirmation=${confirmPasswordController.text}'),
      // body: {
      //   'token': widget.token,
      //   'password': newPasswordController.text,
      //   'password_confirmation': confirmPasswordController.text,
      // },
    );
   if (response.statusCode == 200){

              final Map<String, dynamic> data = json.decode(response.body);
          //String token = data['data']['token'];
           bool success = data['success'];

            if(success == true) {
       Get.to(()=> LoginScreen());
        }else {
 Fluttertoast.showToast(msg: 'Login failed. Please check your credentials.');
        }

     }
     else{
      Fluttertoast.showToast(msg: 'Api Error');
     }
    // Parse the response and handle accordingly
    // ...

    // For demonstration purposes, check if success is true
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Color(0xFF832CE5)),
              ),
              width: 299.w,
              height: 44.h,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF832CE5)),
                  border: InputBorder.none,
                  hintText: 'New Password',
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Color(0xFF832CE5)),
              ),
              width: 299.w,
              height: 44.h,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF832CE5)),
                  border: InputBorder.none,
                  hintText: 'Confirm Password',
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await resetPassword();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF832CE5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(299, 39),
              ),
              child: Text('Confirm', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}



