// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import  'package:http/http.dart' as http;
// import 'package:multitranslation/loginPage.dart';

// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();

//   bool agreeToTerms = false;

//   Future<void> _register() async {
//     if (!_validateFields()) {
//       return;
//     }

//     try {
//       if (passwordController.text != confirmPasswordController.text) {
//         Fluttertoast.showToast(msg: 'Passwords do not match');
//         return;
//       }

//       final response = await http.post(
//         Uri.parse('https://translation.saeedantechpvt.com/api/auth/register'),
//         body: {
//           'firstname': firstNameController.text,
//           'lastname': lastNameController.text,
//           'email': emailController.text,
//           'password': passwordController.text,
//         },
//       );

//       if (response.statusCode == 200) {
//         // Registration successful, redirect to login screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//       } else {
//         Fluttertoast.showToast(msg: 'Registration failed. Please try again.');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error during registration. Please try again.');
//     }
//   }

//   bool _validateFields() {
//     if (emailController.text.isEmpty || passwordController.text.isEmpty) {
//       Fluttertoast.showToast(msg: 'Please fill in all required fields');
//       return false;
//     }

//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign Up')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: firstNameController,
//               decoration: InputDecoration(labelText: 'First Name'),
//             ),
//             TextField(
//               controller: lastNameController,
//               decoration: InputDecoration(labelText: 'Last Name'),
//             ),
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             TextField(
//               controller: confirmPasswordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Confirm Password'),
//             ),
//             Row(
//               children: [
//                 Checkbox(
//                   value: agreeToTerms,
//                   onChanged: (value) {
//                     setState(() {
//                       agreeToTerms = value!;
//                     });
//                   },
//                 ),
//                 Text('I agree to the terms and conditions'),
//               ],
//             ),
//             SizedBox(height: 16.h),
//             ElevatedButton(
//               onPressed: () => _register(),
//               child: Text('Create Account'),
//             ),
//              RichText(
//           text: TextSpan(
//             text: "Don't have an account? ",
//             style: TextStyle(color: Colors.black),
//             children: [
//               TextSpan(
//                 text: "Sign up",
//                 style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                 recognizer: TapGestureRecognizer()
//                   ..onTap = () {
//                     // Navigate to the sign-up page
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                     );
//                   },
//               ),
//             ],
//           ),
//         ),
//           ],
//         ),
//       ),
//     );
//   }
// }