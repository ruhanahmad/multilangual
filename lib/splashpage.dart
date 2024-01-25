import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multitranslation/translationPage.dart';

import 'controller/languageController.dart';

class SplashScreen extends StatefulWidget {
  String? token;
  Map<String, dynamic>? userData;

  SplashScreen({this.token, this.userData});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String selectedLanguage = '';
  LanguageController _languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: const Color(0xFF832CE5),
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Multilingual Glossary App',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LanguageButton(
                        language: 'english',
                        isSelected: selectedLanguage == 'english',
                        onPressed: () {
                          setState(() {
                            selectedLanguage = 'english';
                            // _languageController.changeLocale('en');
                          });
                        },
                      ),
                      SizedBox(width: 16.w),
                      LanguageButton(
                        language: 'soomaali',
                        isSelected: selectedLanguage == 'soomaali',
                        onPressed: () {
                          setState(() {
                            selectedLanguage = 'soomaali';
                            //   _languageController.changeLocale('so');
                          });
                        },
                      ),
                      SizedBox(width: 16.w),
                      LanguageButton(
                        language: 'Arabic',
                        isSelected: selectedLanguage == 'Arabic',
                        onPressed: () {
                          setState(() {
                            selectedLanguage = 'Arabic';
                            //   _languageController.changeLocale('ar');
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                    width: 250.w,
                    height: 200.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("asset/applogop.png"),fit: BoxFit.cover)),
                  ),
                  SizedBox(height: 5.h),
                    Text(
                      "HORUMARKAAL APP (Ver. 01 - year 2024)",
                      style: TextStyle(color: Colors.white),
                    ),
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Horumarkaal is a multilingual glossary app designed by language experts to help Somali speaking students and individuals to overcome language barriers and learn English language. The glossary app enable user instant access to more than 150,000 technical terms covering key major educational field such as chemistry, biology, physics, math, geography, engineering, law, Artificial Intelligence AI, health, IT & computer, courts & Justice, environment, philanthropy and NGO’s, media, communication, banking, logistic, astronomy, agriculture, vocational training, project management, environmental protection, tourism, labour, commerce, industry and other related professions.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedLanguage.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NextPage(
                                selectedLanguage: selectedLanguage,
                                token: widget.token,
                                userData: widget.userData),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Border radius
                      ),
                      minimumSize: Size(299.w, 39.h), // Width and height
                    ),
                    child: const Text(
                      'Next Page',
                      style: TextStyle(
                        color: Color(0xFF832CE5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
          ),
        );
      },
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
