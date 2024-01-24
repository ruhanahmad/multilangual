// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:multitranslation/controller/userController.dart';
// import 'package:multitranslation/loginPage.dart';



// class Quizes extends StatefulWidget {

//    String? token;
  
//   Quizes({ this.token});

//   @override
//   _QuizesState createState() => _QuizesState();
// }

// class _QuizesState extends State<Quizes> {
//   TextEditingController searchController = TextEditingController();
//    final userController = Get.put(UserController());
//   List<String> dataList = [];
//  Map<String, dynamic> translations = {};
//   FlutterTts flutterTts = FlutterTts(); 
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//      flutterTts.setLanguage("en-US");

//   }

//    Future<void> speak(String text,String selectedLanguage) async {
//    await flutterTts.setLanguage(selectedLanguage); // Replace with the language code you want to use (e.g., "so-SO" for Somali, "ar-SA" for Arabic)
//     await flutterTts.setVolume(1.0);
//     await flutterTts.setPitch(1.0);
//     await flutterTts.speak(text);
//   }

//     Future<void> logOut() async {
    

//     try {
//       final response = await http.get(
//         Uri.parse(
//           'https://translation.saeedantechpvt.com/api/auth/logout',
//         ),
//           headers: {
//           'Authorization':"Bearer "+"${widget.token}", // Replace with your actual auth token
//         },
//       );

//       if (response.statusCode == 200) {
//               final Map<String, dynamic> data = json.decode(response.body);
//         final String message = data['message'];
//         // final Map<String, dynamic> userData = data['data']['user'];
//         // Login successful, redirect to splash screen
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => LoginScreen()),
//         // );
//         print(message);
//        Get.to(()=>LoginScreen());
//       } else {
//         Fluttertoast.showToast(msg: 'Login failed. Please check your credentials.');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error during login. Please try again.');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     final userController = Get.put(UserController());
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//                ElevatedButton(
//       onPressed: () async{
//         // Handle button press
//      await   logOut();
//       },
//       style: ElevatedButton.styleFrom(
//         primary:  Color(0xFF832CE5
//                 ), // Button color
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0), // Border radius
//         ),
//         minimumSize: Size(80.w, 29.h), // Width and height
        
//       ),
//       child: Text('Quizez',style: TextStyle(color: Colors.white),),
//     ),
//           ElevatedButton(
//       onPressed: () async{
//         // Handle button press
//      await   logOut();
//       },
//       style: ElevatedButton.styleFrom(
//         primary:  Color(0xFF832CE5
//                 ), // Button color
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0), // Border radius
//         ),
//         minimumSize: Size(80.w, 29.h), // Width and height
        
//       ),
//       child: Text('Log Out',style: TextStyle(color: Colors.white),),
//     ),
//           //  LanguageButton(
//           //     language: 'Logout',
//           //     isSelected: ""
//           //     onPressed: () {
//           //       setState(() {
//           //         widget.selectedLanguage = 'arabic';
//           //       });
//           //     },
//           //   ),
//         ],
//         automaticallyImplyLeading: false,
        
       
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//             Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             LanguageButton(
//               language: 'english',
//               isSelected: widget.selectedLanguage == 'english',
//               onPressed: () {
//                 setState(() {
//                   widget.selectedLanguage = 'english';
//                 });
//               },
//             ),
//             SizedBox(width: 16.w),
//             LanguageButton(
//               language: 'soomaali',
//               isSelected: widget.selectedLanguage == 'soomaali',
//               onPressed: () {
//                 setState(() {
//                   widget.selectedLanguage = 'soomaali';
//                 });
//               },
//             ),
//             SizedBox(width: 16.w),
//             LanguageButton(
//               language: 'arabic',
//               isSelected: widget.selectedLanguage == 'arabic',
//               onPressed: () {
//                 setState(() {
//                   widget.selectedLanguage = 'arabic';
//                 });
//               },
//             ),
//           ],
//         ),
//                  Row(
//                    children: [
//                      SizedBox(width: 10,),
//                      Container(
//                                      decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
                      
//                       border: Border.all(width: 1.w,color: Color(0xFF832CE5
//                      ),),
//                                      ),
//                                      width: 240.w,
//                                      height: 44.h,
//                                      child: TextField(
//                        style: TextStyle(color: Colors.black),
//                                  controller: searchController,
//                                  decoration: InputDecoration(
//                                    hintText: 'Search',
//                                    border: InputBorder.none,
//                                   suffixIcon: IconButton(
//                                      icon: Icon(Icons.search),
//                                      onPressed: () {
//                       if (searchController.text.isNotEmpty) {
                                     
//                         setState(() {
//                               dataList.length = 0;
//                         });
//                         fetchExactTranslation(searchController.text, widget.selectedLanguage,widget.token!);
//                       }
//                                      },
//                                    ),
                                   
//                                  ),
//                                  onTap: () {
                                  
//                                    _fetchSuggestions(widget.selectedLanguage,widget.token!);
//                                  },
//                                ),
//                                    ),
//                                    SizedBox(width: 20,),
//                                      ElevatedButton(
//       onPressed: () async{
      
//    await  _getTranslation(userController.words.value, widget.selectedLanguage);
//       },
//       style: ElevatedButton.styleFrom(
//         primary:  Color(0xFF832CE5
//                 ), // Button color
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0), // Border radius
//         ),
//         minimumSize: Size(80.w, 29.h), // Width and height
        
//       ),
//       child: Text('Search',style: TextStyle(color: Colors.white),),
//     ),
//                    ],
//                  ),

//           // TextField(
//           //   controller: searchController,
//           //   decoration: InputDecoration(
//           //     labelText: 'Search',
//           //    suffixIcon: IconButton(
//           //       icon: Icon(Icons.search),
//           //       onPressed: () {
//           //         if (searchController.text.isNotEmpty) {
                
//           //           setState(() {
//           //                 dataList.length = 0;
//           //           });
//           //           fetchExactTranslation(searchController.text, widget.selectedLanguage,widget.token!);
//           //         }
//           //       },
//           //     ),
              
//           //   ),
//           //   onTap: () {
             
//           //     _fetchSuggestions(widget.selectedLanguage,widget.token!);
//           //   },
//           // ),
//           SizedBox(height: 20.h),
//           dataList.length != 0 ? 
//           SingleChildScrollView(
//             child: Container(
//               height: 300,
//               width: 500,
//               child: ListView.builder(
//                 itemCount: dataList.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(dataList[index]),
//                       onTap: () {
//                  //   _getTranslation(dataList[index], widget.selectedLanguage);
//                   },
//                   trailing:   Obx(
//                     ()=> Checkbox(
//                                           value: userController.words
//                                                   .contains(
//                                                   dataList[index]
                                                      
//                                                       )
//                                               ? true
//                                               : false,
//                                           onChanged: (val) {
//                                             if (userController.words
//                                                 .contains(
//                                                 dataList[index]
                                                    
//                                                     )) {
//                                               userController.words.remove(
//                                                   dataList[index]
                                                      
//                                                       );
//                                             } else {
//                                               userController.words.add(
//                                                 dataList[index]
                                                      
//                                                       );
//                                             }
//                                           }),
//                   ),
//                   );
//                 },
//               ),
//             ),
//           )
//           :
//           Container()
//           ,
//             //  if (translations.isNotEmpty)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [

              
//               Container(
//                 height: 200,
//                 width: MediaQuery.of(context).size.width /2,
//                 padding: EdgeInsets.all(16),
//                 color: Color(0xFFB4ACFF),
//                 child: 
//                 Column(
//                   children: [
//                widget.selectedLanguage ==  "english" ? Text ("Soomaali") : widget.selectedLanguage ==  "soomaali"  ? Text ("English") :widget.selectedLanguage ==  "arabic"? Text("English"):Text(""),
//               Expanded(
//                          child: ListView.builder(
//                                  itemCount: translations.length,
//                                  itemBuilder: (context, index) {
//                                    final word = translationsData!.keys.elementAt(index);
//                                    print(word);
//                                    final translations = translationsData![word];
                         
//                                    return

//                                    Column(children: [

                   
              
//                  widget.selectedLanguage ==  "english"?    Text(translations['soomaali'] ?? ''): widget.selectedLanguage ==  "soomaali" ?Text(translations['english'] ?? ''):widget.selectedLanguage ==  "arabic" ?Text(translations['english'] ?? ''):Text(""),
            
//               Align(
//                 alignment: Alignment.topRight,
//                 child: IconButton(
//                   icon: Icon(Icons.volume_up),
//                   onPressed: () {
//                  widget.selectedLanguage ==  "english"?    speak(translations['soomaali'],"so-SO"): widget.selectedLanguage ==  "soomaali" ?speak(translations['english'],"en-US"):widget.selectedLanguage ==  "arabic" ?speak(translations['english'],"en-US"):Text(""); // Replace with your dynamic text
//                   },
//                   // child: Text('Play Audio'),
//                 ),
//               ),
//                                    ],);
                                   
                            
                                
//                                  },
//                                ),
//                        ),
              
              
                       
//                   ],
//                 ),
//               ),


            
//               Container(
//                  height: 200,
//                 width: MediaQuery.of(context).size.width /2,
//                 padding: EdgeInsets.all(16),
//                 color: Color(0xFFE1C7FF),
//                 child: Column(
//                   children: [
//                       widget.selectedLanguage ==  "english" ? Text ("Arabic") : widget.selectedLanguage ==  "soomaali"  ? Text ("Arabic") :widget.selectedLanguage ==  "arabic"? Text("Soomaali"):Text(""),
//                  //   Text(translations['arabic'] != null ? 'Arabic' : ''),
// //                     widget.selectedLanguage ==  "english"?    Text(translations['arabic'] ?? ''): widget.selectedLanguage ==  "soomaali" ?Text(translations['arabic'] ?? ''):widget.selectedLanguage ==  "arabic" ?Text(translations['soomaali'] ?? ''):Text(""),
// //                     Align(
// // alignment: Alignment.topRight,
// //                       child: IconButton(
// //                          icon: Icon(Icons.volume_up),
// //                         onPressed: () {
// //                        widget.selectedLanguage ==  "english"?    speak(translations['arabic'],"ar"): widget.selectedLanguage ==  "soomaali" ?speak(translations['arabic'],"ar"):widget.selectedLanguage ==  "arabic" ?speak(translations['soomaali'],"so-SO"):Text(""); // Replace with your dynamic text
// //                         },
// //                         // child: Text('Play Audio'),
// //                       ),
// //                     ),
//                       Expanded(
//                          child: ListView.builder(
//                                  itemCount: translations.length,
//                                  itemBuilder: (context, index) {
//                                    final word = translationsData!.keys.elementAt(index);
//                                    print(word);
//                                    final translations = translationsData![word];
                         
//                                    return

//                                    Column(children: [

                   
              
//                   widget.selectedLanguage ==  "english"?    Text(translations['arabic'] ?? ''): widget.selectedLanguage ==  "soomaali" ?Text(translations['arabic'] ?? ''):widget.selectedLanguage ==  "arabic" ?Text(translations['soomaali'] ?? ''):Text(""),
            
//               Align(
//                 alignment: Alignment.topRight,
//                 child: IconButton(
//                   icon: Icon(Icons.volume_up),
//                   onPressed: () {
//                  widget.selectedLanguage ==  "english"?    speak(translations['arabic'],"ar"): widget.selectedLanguage ==  "soomaali" ?speak(translations['arabic'],"ar"):widget.selectedLanguage ==  "arabic" ?speak(translations['soomaali'],"so-SO"):Text(""); // Replace with your dynamic text
//                   },
//                   // child: Text('Play Audio'),
//                 ),
//               ),
//                                    ],);
                                   
                            
                                
//                                  },
//                                ),
//                        ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _fetchSuggestions(String query,String token) async {
//     print(token);
//     print(query);
//     try {
//       final response = await http.post(
//         Uri.parse('https://translation.saeedantechpvt.com/api/app/search-translate'),
//         headers: {
//           'Authorization':"Bearer " + token, // Replace with your actual auth token
//         },
//         body: {
//           'lang': query,
//           // 'query': query,
//         },
//       );
// print(response.statusCode);
//       if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//         List<dynamic> dataListFromApi = data['data'];

//         setState(() {
//           dataList = dataListFromApi.cast<String>();
//         });
//       } else {
//         // Handle error
//         print('API call failed');
//       }
//     } catch (e) {
//       // Handle exceptions
//       print('Exception during API call: $e');
//     }
//   }
//  Map<String, dynamic>? translationsData ;
//   Future<void> _getTranslation(List<String> word, String lang) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://translation.saeedantechpvt.com/api/app/get-translate'),
//          headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer ${widget.token}'
//         },
//         // headers: {},
//         body:  jsonEncode({'lang': lang, 'word': word}),
//       );
// print(response.statusCode);
// print(response.body);
//       if (response.statusCode == 200) {

//         final Map<String, dynamic> data = json.decode(response.body);
//          translationsData = data['data']['translations'];

//         setState(() {
//           translations = translationsData!;
//         });
//          userController.words.clear();
//       } else {
//         Fluttertoast.showToast(msg: 'Failed to get translation. Please try again.');
//          final userController = Get.put(UserController());
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: '${e}');
//        final userController = Get.put(UserController());
//       print(e);
//     }
//   }


//  Future<void> fetchExactTranslation(String query,String selectedLanguage,String token) async {
//     print(token);
//     print(query);
//     print(selectedLanguage);
//     try {
//       final response = await http.post(
//         Uri.parse('https://translation.saeedantechpvt.com/api/app/search-translate'),
//         headers: {
//           'Authorization':"Bearer " + token, // Replace with your actual auth token
//         },
//         body: {
//           'lang': selectedLanguage,
//           'word': query,
//         },
//       );
// print(response.statusCode);
//       if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//         List<dynamic> dataListFromApi = data['data'];

//         setState(() {
//           dataList = dataListFromApi.cast<String>();
//         });
//       } else {
//         // Handle error
//         print('API call failed');
//       }
//     } catch (e) {
//       // Handle exceptions
//       print('Exception during API call: $e');
//     }
//   }





//    Future<void> fetch(String query,String token) async {
//     print(token);
//     try {
//       final response = await http.post(
//         Uri.parse('https://translation.saeedantechpvt.com/api/app/search-translate'),
//         headers: {
//           'Authorization':"Bearer " + token, // Replace with your actual auth token
//         },
//         body: {
//           'lang': query,
//           // 'query': query,
//         },
//       );
// print(response.statusCode);
//       if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//         List<dynamic> dataListFromApi = data['data'];

//         setState(() {
//           dataList = dataListFromApi.cast<String>();
//         });
//       } else {
//         // Handle error
//         print('API call failed');
//       }
//     } catch (e) {
//       // Handle exceptions
//       print('Exception during API call: $e');
//     }
//   }
// }
// class LanguageButton extends StatelessWidget {
//   final String language;
//   final bool isSelected;
//   final VoidCallback onPressed;

//   LanguageButton({
//     required this.language,
//     required this.isSelected,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ButtonStyle(
//         backgroundColor: isSelected ? MaterialStateProperty.all(Colors.blue) : null,
//       ),
//       child: Text(language),
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:percent_indicator/percent_indicator.dart';

import 'controller/userController.dart';

class QuizPage extends StatefulWidget {
  String? token;
  QuizPage({ required this.token});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final String apiUrl = "https://translation.saeedantechpvt.com/api/app/get-questions?word=help&type=english to soomaali";
  List<Map<String, dynamic>> quizData = [];
  List<String> selectedAnswers = [];
   String selectedAnswerss = "";
   String groupValue = '';
  int currentIndex = 0;
  double quizProgress = 0.0;
    List<String> dataList = [];
  @override
  void initState() {
    super.initState();
   // fetchQuizData();
  }


final userController = Get.put(UserController());
  Future<void> _fetchSuggestions(String query,String token) async {
    print(token);
    print(query);
    try {
      final response = await http.post(
        Uri.parse('https://translation.saeedantechpvt.com/api/app/search-translate'),
        headers: {
          'Authorization':"Bearer " + token, // Replace with your actual auth token
        },
        body: {
          'lang': query,
          // 'query': query,
        },
      );
print(response.statusCode);
      if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> dataListFromApi = data['data'];

        setState(() {
          dataList = dataListFromApi.cast<String>();
        });
      } else {
        // Handle error
        print('API call failed');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during API call: $e');
    }
  }
  Future<void> fetchQuizData(List<String> word,String selectedLanguage) async {
    try {
      final response = await http.post(Uri.parse("https://translation.saeedantechpvt.com/api/app/get-questions"),
      
 headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':"Bearer "+"${widget.token}", // Replace with your actual auth token
        },
         body: 
     jsonEncode({'type': selectedLanguage, 'word': word}),
      
      );
      if (response.statusCode == 200) {
        setState(() {
          quizData = List<Map<String, dynamic>>.from(json.decode(response.body)["data"]);
        });
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  void handleAnswer(String answer) {
    setState(() {
   selectedAnswers[currentIndex] = answer;
    });
  }

    void updateQuizProgress() {
    setState(() {
      quizProgress = (currentIndex + 1) / quizData.length;
    });
  }

  void nextQuestion() {
    if (selectedAnswers[currentIndex].isNotEmpty && currentIndex < quizData.length - 1) {
      setState(() {
        currentIndex++;
       // selectedAnswer = ''; // Reset selected answer for the next question
         updateQuizProgress();
      });
    } else if (selectedAnswers[currentIndex].isNotEmpty) {
      Fluttertoast.showToast(msg: 'Please Select atleast one');
      // Show an error message because no option is selected
      // showErrorDialog('Please select an answer before proceeding.');
    }
  }

  void submitQuiz() {
     if (selectedAnswers[currentIndex].isNotEmpty){
       int correctAnswers = 0;
    int incorrectAnswers = 0;

    for (int i = 0; i < quizData.length; i++) {
      if ( quizData[i]["correct"]==selectedAnswers[0]) {
        correctAnswers++;

      } else {
        incorrectAnswers++;
      }
      print(correctAnswers);
      print(incorrectAnswers);
    }
updateQuizProgress();
    // Display results or navigate to results screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0XFFB4ACFF) ,
         // title: Text('Quiz Results'),
          content: 
          Container(
            width: 400,
            color: Color(0XFFB4ACFF),
            child: Column(
              children: [
                Container(height: 203.h,width: 189.w,decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("asset/fram.png",),fit: BoxFit.contain)),),
                    Text(' ${(correctAnswers / quizData.length * 100).toStringAsFixed(2)}% Score',style: TextStyle(color: Color(0xFF4209BB),fontSize: 48),),
                Text('Exam Completed Succesfully',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),), 
                SizedBox(height: 20,),   
                Text('You Attempted  ${quizData.length} questions and  $correctAnswers are correct',style: TextStyle(color: Colors.black,fontSize: 25,), ),

              //   LinearProgressIndicator(
              //   value: 50.0,
              //   backgroundColor: Colors.grey,
              //   minHeight: 20,
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              // ),
                // Text('Incorrect Answers: $incorrectAnswers'),
                // Text('Total Questions: ${quizData.length}'),
               // Text(' ${(correctAnswers / quizData.length * 100).toStringAsFixed(2)}%'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
     }
     else {
      Fluttertoast.showToast(msg: 'Please Select atleast one');
     }
    // Calculate and display results here
   
  }

void calculateResults() {
    int correctAnswers = 0;
    int incorrectAnswers = 0;

    for (int i = 0; i < quizData.length; i++) {
      print(quizData[i]["correct"]);
      print("sfdqer" + selectedAnswers[0]);
      if (quizData[i]["correct"] == selectedAnswers[0]) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
      print(correctAnswers);
    }}
   void _showLanguageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LanguageOption('english to soomaali', onSelectLanguage),
              LanguageOption('english to arabic', onSelectLanguage),
              LanguageOption('arabic to english', onSelectLanguage),
              LanguageOption('arabic to soomaali', onSelectLanguage),
              LanguageOption('soomaali to english', onSelectLanguage),
              LanguageOption('soomaali to arabic', onSelectLanguage),
            ],
          ),
        );
      },
    );
  }
  void onSelectLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
    Navigator.of(context).pop();
  }
  String selectedLanguage = 'Select Language';
  
TextEditingController searchController = TextEditingController();

  @override

  Widget build(BuildContext context) {
   // if (quizData.isEmpty) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Text('Loading...'),
    //     ),
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }
    //  else {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text('Quiz'),
        //   elevation: 0.0,
        //   backgroundColor: ,
        // ),
        body: Container(
            decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF832CE5), // Top color (#832CE5)
            Color(0xFF4E3DF8), // Bottom color (#4E3DF8)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
          child: 
        
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 340.w,
                  height: 30.h,
                  child: ElevatedButton(
                            onPressed: () {
                              _showLanguageOptions(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(selectedLanguage),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                ),
                SizedBox(height: 20.h,),
           Column(
                   children: [
                     SizedBox(width: 10,),
                     Container(
                                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      
                      border: Border.all(width: 1.w,color: Color(0xFF832CE5
                     ),),
                                     ),
                                     width: 360.w,
                                     height: 34.h,
                                     child: TextField(
                       style: TextStyle(color: Colors.black),
                                 controller: searchController,
                                 decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                   hintText: 'Search',
                                   border: InputBorder.none,
                                  suffixIcon: IconButton(
                                     icon: Icon(Icons.search),
                                     onPressed: () {
                      if (searchController.text.isNotEmpty) {
                                     
                        setState(() {
                              dataList.length = 0;
                        });
                     //   fetchExactTranslation(searchController.text, widget.selectedLanguage,widget.token!);
                      }
                                     },
                                   ),
                                   
                                 ),
                                 onTap: () {
                                  print(selectedLanguage);
                                   _fetchSuggestions(selectedLanguage,widget.token!);
                                 },
                               ),
                                   ),
                                   SizedBox(width: 20,),
                                     Row(
                                       children: [
                                         ElevatedButton(
                                               onPressed: () async{
                                               
                                            await  fetchQuizData(userController.words.value,selectedLanguage);
                                               },
                                               style: ElevatedButton.styleFrom(
                                                 primary:  Color(0xFF832CE5
                                                         ), // Button color
                                                 shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(20.0), // Border radius
                                                 ),
                                                 minimumSize: Size(80.w, 29.h), // Width and height
                                                 
                                               ),
                                               child: Text('Quiz by Words',style: TextStyle(color: Colors.white),),
                                             ),
                                                                                  SizedBox(width: 20,),
                                     ElevatedButton(
      onPressed: () async{
      //  dataList = 0;
  // await  _getTranslation(userController.words.value, widget.selectedLanguage);
    await  fetchQuizData(userController.nullList.value,selectedLanguage);
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF832CE5
                ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        minimumSize: Size(80.w, 29.h), // Width and height
        
      ),
      child: Text('All Quizez',style: TextStyle(color:Colors.white, ),),
    ),
                                       ],
                                     ),
 
                   ],
                 ),
                 dataList.length != 0 ? 
          SingleChildScrollView(
            child: Container(
              height: 300,
              width: 500,
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(dataList[index],style: TextStyle(color: Colors.white),),
                      onTap: () {
                 //   _getTranslation(dataList[index], widget.selectedLanguage);
                  },
                  trailing:   Obx(
                    ()=> Checkbox(
                                          value: userController.words
                                                  .contains(
                                                  dataList[index]
                                                      
                                                      )
                                              ? true
                                              : false,
                                          onChanged: (val) {
                                            if (userController.words
                                                .contains(
                                                dataList[index]
                                                    
                                                    )) {
                                              userController.words.remove(
                                                  dataList[index]
                                                      
                                                      );
                                            } else {
                                              userController.words.add(
                                                dataList[index]
                                                      
                                                      );
                                            }
                                          }),
                  ),
                  );
                },
              ),
            ),
          )
          :
          Container()
          ,
              //    LinearProgressIndicator(
              //   value: quizProgress,
              //   backgroundColor: Colors.grey,
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              // ),
              quizData.isEmpty ? Container() :
                //if(selectedLanguage != "Select Language") 
                 Column(
                   children: [
                     Padding(
                                   padding: EdgeInsets.all(15.0),
                                   child:  
                                   LinearPercentIndicator(
                                     width: 400.0,
                                     lineHeight: 30.0,
                                     percent: quizProgress,
                                     center: Text(
                      ' ${(quizProgress * 100).toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 12.0),
                                     ),
                                     linearStrokeCap: LinearStrokeCap.roundAll,
                                     backgroundColor: Colors.grey,
                                     progressColor: Colors.blue,
                                   ),
                                 ),
                                   Text(
                  'Question: ${currentIndex}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20,),
                Text(
              "${quizData[currentIndex]["question"]}",
                  style: TextStyle(fontSize: 30),
                ),
                 SizedBox(height: 16),
// Column(
//   children: [
//     for (var i = 1; quizData[currentIndex]["answer_$i"] != null; i++)
//       RadioListTile<String>(
//         title: Text(quizData[currentIndex]["answer_$i"]),
//         value: "answer_$i",
//         groupValue: selectedAnswers.isNotEmpty ? selectedAnswers[0] : null,
//         onChanged: (value) => handleAnswer(value!),
//       ),
//   ],
// ),



Column(
              children: [
                for (var i = 1; quizData[currentIndex]["answer_$i"] != null; i++)
                  ChoiceRadio(
                    text: quizData[currentIndex]["answer_$i"],
                    value: "answer_$i",
                    groupValue: selectedAnswers.isNotEmpty ? selectedAnswers[0] : null,
                    onChanged: (value) => setState(() => selectedAnswers = [value!]),
                  ),
              ],
            ),
                // Column(
                //   children: [
                //     for (String answer in [quizData[currentIndex]["answer_1"], quizData[currentIndex]["answer_2"]])
                //       RadioListTile<String>(
                //       //  selected: true,
                //         activeColor: Colors.white,
                //         title: Text(answer,style: TextStyle(color: Colors.white),),
                //         value: answer,
                //         groupValue: selectedAnswerss,
                //         onChanged: (value) => handleAnswer(value!),
                //       ),
                //   ],
                // ),

                  ElevatedButton(
              onPressed: () {
                if (selectedAnswers.isNotEmpty) {
                  if (currentIndex < quizData.length - 1) {
                    setState(() {
                      currentIndex++;
                      selectedAnswers = [];
                    });
                  } else {
                    // Calculate and display results
                    calculateResults();
                  }
                } else {
                  // Show an error message because no option is selected
               //   showErrorDialog('Please select an answer before proceeding.');
                }
              },
              child: Text(currentIndex < quizData.length - 1 ? 'Next' : 'Submit'),
            ),
                SizedBox(height: 16),
                if (currentIndex < quizData.length - 1)
                  ElevatedButton(
                    onPressed: nextQuestion,
                    child: Text('Next'),
                  )
                else
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: submitQuiz,
                        child: Text('Submit'),
                      ),
                      // ElevatedButton(
                      //   onPressed: submitQuiz,
                      //   child: Text('Next Question'),
                      // ), 
                    ],
                  ),
                   ],
                 ),
                
               
                
              ],
              
            ),
          ),
        ),
      );
    //}
    
  }
  
}
class LanguageOption extends StatelessWidget {
  final String language;
  final Function(String) onSelect;

  LanguageOption(this.language, this.onSelect);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(language),
      onTap: () {
        onSelect(language);
      },
    );
  }}



  class ChoiceRadio<T> extends StatelessWidget {
  final String text;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

  const ChoiceRadio({
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(text),
      ],
    );
  }
}