import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multitranslation/loginPage.dart';
import 'package:multitranslation/translationPage.dart';

class VeryFirstScreen extends StatefulWidget {
//     String? token;
//    Map<String, dynamic>? userData;

//  SplashScreen({this.token,this.userData});
  @override
  _VeryFirstScreenState createState() => _VeryFirstScreenState();
}

class _VeryFirstScreenState extends State<VeryFirstScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }
  // String selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF832CE5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Multilingual Glossary App',
              style: TextStyle(fontSize: 20.sp),
            ),

            Container(
              width: 400.w,
              height: 250.w,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/image.png"))),
            ),
            SizedBox(height: 30.h),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                style: TextStyle(color: Colors.white),
              ),
            )),

            // ElevatedButton(
            //   onPressed: () {
            //     if (selectedLanguage.isNotEmpty) {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => NextPage(selectedLanguage:selectedLanguage,token:widget.token,userData:widget.userData),
            //         ),
            //       );
            //     }
            //   },
            //   child: Text('Next Page'),
            // ),
          ],
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback onPressed;

  LanguageButton({
    required this.language,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            isSelected ? MaterialStateProperty.all(Colors.blue) : null,
      ),
      child: Text(language),
    );
  }
}
