import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multitranslation/translationPage.dart';





class SplashScreen extends StatefulWidget {
    String? token;
   Map<String, dynamic>? userData;

 SplashScreen({this.token,this.userData});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF832CE5
),
      body: Center(
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
                    });
                  },
                ),
              ],
            ),
            Container(width: 400.w,height: 250.w,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("asset/image.png"))),),
            SizedBox(height: 30.h),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",style: TextStyle(color: Colors.white),),
            )),
                ElevatedButton(
            onPressed: () {
                if (selectedLanguage.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NextPage(selectedLanguage:selectedLanguage,token:widget.token,userData:widget.userData),
                    ),
                  );
                }
              },
      style: ElevatedButton.styleFrom(
        primary: Colors.white, // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        minimumSize: Size(299.w, 39.h), // Width and height
        
      ),
      child: Text('Next Page',style: TextStyle(color: Color(0xFF832CE5
                ), ),),
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
        backgroundColor: isSelected ? MaterialStateProperty.all(Colors.blue) : null,
      ),
      child: Text(language),
    );
  }
}


