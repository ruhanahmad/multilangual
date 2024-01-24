import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multitranslation/const.dart';
import 'package:multitranslation/forgetPassword.dart';
import 'package:multitranslation/signUp.dart';
import 'package:multitranslation/signupPage.dart';
import 'package:multitranslation/splashpage.dart';




class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    if (!_validateFields()) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
          'https://translation.saeedantechpvt.com/api/auth/login?email=${emailController.text}&password=${passwordController.text}',
        ),
      );

      if (response.statusCode == 200) {
              final Map<String, dynamic> data = json.decode(response.body);
        final String token = data['data']['token'];
        final Map<String, dynamic> userData = data['data']['user'];
        print(userData);
        print(token);
        // Login successful, redirect to splash screen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
        Get.to(()=>SplashScreen(token: token, userData: userData));
      } else {
        Fluttertoast.showToast(msg: 'Login failed. Please check your credentials.');
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
        child: Container(
       //   height: MediaQuery.of(context).size.height -100,
          // width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(height: 212.h,width: 182.w,decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("asset/pik.png",),fit: BoxFit.contain)),),
              ),
              Align(
                
                alignment: Alignment.center,
                child: Text("Sign In",style: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.bold,color: Colors.black),)),
                SizedBox(height: 30.h,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  
                  border: Border.all(width: 1.w,color: Color(0xFF832CE5
),),
                ),
                width: 299.w,
                height: 44.h,
                child: TextField(
                   style: TextStyle(color: Colors.black),
                  controller: emailController,
                  
                  decoration: InputDecoration(
                    
                    prefixIcon: Icon(Icons.message,color: Color(0xFF832CE5
),),
border: InputBorder.none,
                    hintText: 'Email'),
                ),
              ),
              SizedBox(height: 20.h,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  
                  border: Border.all(width: 1.w,color: Color(0xFF832CE5
),),
                ),
                width: 299.w,
                height: 44.h,
                child: TextField(
                   style: TextStyle(color: Colors.black),
                  controller: passwordController,
                  obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.message,color: Color(0xFF832CE5
                ),),
                border: InputBorder.none,
                      hintText: 'Password'),
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  Get.to(()=>ForgotPasswordScreen());
                },
                child: Text("Forget Password",style: TextStyle(color: color),)),
    ElevatedButton(
      onPressed: () async{
        // Handle button press
     await   _login();
      },
      style: ElevatedButton.styleFrom(
        primary:  Color(0xFF832CE5
                ), // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        minimumSize: Size(299.w, 39.h), // Width and height
        
      ),
      child: Text('Sign in',style: TextStyle(color: Colors.white),),
    ),
       RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: "Sign up",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigate to the sign-up page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
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

