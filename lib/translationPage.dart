import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multitranslation/controller/languageController.dart';
import 'package:multitranslation/controller/userController.dart';
import 'package:multitranslation/loginPage.dart';
import 'package:multitranslation/profile.dart';
import 'package:path_provider/path_provider.dart';

import 'controller/languageController.dart';
import 'package:multitranslation/quizez.dart';

class NextPage extends StatefulWidget {
  String selectedLanguage;
  String? token;
  Map<String, dynamic>? userData;
  NextPage({required this.selectedLanguage, this.token, this.userData});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  TextEditingController searchController = TextEditingController();
  final userController = Get.put(UserController());
  List<String> dataList = [];
  Map<String, dynamic> translations = {};
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterTts.setLanguage("en-US");
    print(widget.token);
  }

  LanguageController _languageController = Get.put(LanguageController());

  Future<void> speak(String text, String selectedLanguage) async {
    await flutterTts.setLanguage(
        selectedLanguage); // Replace with the language code you want to use (e.g., "so-SO" for Somali, "ar-SA" for Arabic)
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  Future<void> logOut() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://translation.saeedantechpvt.com/api/auth/logout',
        ),
        headers: {
          'Authorization': "Bearer " +
              "${widget.token}", // Replace with your actual auth token
        },
      );
 Get.to(() => LoginScreen());
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String message = data['message'];
        // final Map<String, dynamic> userData = data['data']['user'];
        // Login successful, redirect to splash screen
        // Navigator.push(
        //   context,heade
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
        print(message);
        Get.to(() => LoginScreen());
      } else {
        Fluttertoast.showToast(
            msg: 'Login failed. Please check your credentials.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error during login. Please try again.');
    }
  }
  Future<void> textToSpeech({required String textToSpeak}) async {
    // final String apiKey = Platform.environment['SnAEBdbq564owoayOZpBX1YvRVZTlzaO5Qkbluo6'] ?? '';
    const String voice = 'mickey';
    //const String text = 'Hello, ruhan sir how are you?';
    final String url =
        'https://api.narakeet.com/text-to-speech/mp3?voice=$voice';

    // if (apiKey.isEmpty) {
    //   print('Please set NARAKEET_API_KEY environment variable');
    //   return;
    // }

    final http.Client client = http.Client();

    try {
      final http.Response response = await client.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/octet-stream',
          'Content-Type': 'text/plain',
          'x-api-key': "SnAEBdbq564owoayOZpBX1YvRVZTlzaO5Qkbluo6",
        },
        body: utf8.encode(textToSpeak),
      );

      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        final File file = File('${tempDir.path}/output.mp3');
        final IOSink sink = file.openWrite();
        sink.add(response.bodyBytes);
        await sink.close();

        // Play the audio
        await playAudio(file.path);

        print('File saved at: ${file.path}');
      } else {
        print('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      client.close();
    }
  }

  Future<void> playAudio(String filePath) async {
    final AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(
      UrlSource(filePath),
    );
  }
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          //            ElevatedButton(
          //   onPressed: () async{
          //     // Handle button press
          // Get.to(()=>QuizPage());
          //   },
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(20.0), // Border radius
          //     ),
          //     minimumSize: Size(40.w, 29.h), // Width and height

          //   ),
          //   child: Text('Learning Plan',style: TextStyle(color: Color(0xFF573AF5,),fontSize: 12),),
          // ),
          ElevatedButton(
            onPressed: () async {
              // Handle button press
              Get.to(() => QuizPage(token: widget.token,language:widget.selectedLanguage));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Border radius
              ),
              minimumSize: Size(20.w, 29.h), // Width and height
            ),
            child:
            
            widget.selectedLanguage == "soomaali" ?
             Text(
              'Leeyli & Imtixaan',
              style: TextStyle(color: Color(0xFF573AF5), fontSize: 12),
            )
            :
             widget.selectedLanguage == "english" ?
              Text(
              'Exercise & Quizzes',
              style: TextStyle(color: Color(0xFF573AF5), fontSize: 12),
            )
            :
             widget.selectedLanguage == "arabic" ?
             Text(
              'تحان تم',
              style: TextStyle(color: Color(0xFF573AF5), fontSize: 12),
            ):
            Text(""),
          ),
          ElevatedButton(
            onPressed: () async {
              // Handle button press
              await logOut();
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF832CE5), // Button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Border radius
              ),
              minimumSize: Size(80.w, 29.h), // Width and height
            ),
            child: Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => UserDetailsScreen(
                  token: widget.token!, userData: widget.userData!));
            },
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white,
                child: Text(
                  'P', // Display the user's initial
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          //  LanguageButton(
          //     language: 'Logout',
          //     isSelected: ""
          //     onPressed: () {
          //       setState(() {
          //         widget.selectedLanguage = 'arabic';
          //       });
          //     },
          //   ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LanguageButton(
                language: 'english',
                isSelected: widget.selectedLanguage == 'english',
                onPressed: () {
                  setState(() {
                    widget.selectedLanguage = 'english';
                  });
                },
              ),
              SizedBox(width: 16.w),
              LanguageButton(
                language: 'soomaali',
                isSelected: widget.selectedLanguage == 'soomaali',
                onPressed: () {
                  setState(() {
                    widget.selectedLanguage = 'soomaali';
                  });
                },
              ),
              SizedBox(width: 16.w),
              LanguageButton(
                language: 'arabic',
                isSelected: widget.selectedLanguage == 'arabic',
                onPressed: () {
                  setState(() {
                    widget.selectedLanguage = 'arabic';
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1.w,
                    color: Color(0xFF832CE5),
                  ),
                ),
                width: 240.w,
                height: 44.h,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search'.tr,
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          setState(() {
                            dataList.length = 0;
                          });
                          fetchExactTranslation(searchController.text,
                              widget.selectedLanguage, widget.token!);
                        }
                      },
                    ),
                  ),
                  onTap: () {
                    _fetchSuggestions(widget.selectedLanguage, widget.token!);
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await _getTranslation(
                      userController.words.value, widget.selectedLanguage);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF832CE5), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Border radius
                  ),
                  minimumSize: Size(80.w, 29.h), // Width and height
                ),
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          // TextField(
          //   controller: searchController,
          //   decoration: InputDecoration(
          //     labelText: 'Search',
          //    suffixIcon: IconButton(
          //       icon: Icon(Icons.search),
          //       onPressed: () {
          //         if (searchController.text.isNotEmpty) {

          //           setState(() {
          //                 dataList.length = 0;
          //           });
          //           fetchExactTranslation(searchController.text, widget.selectedLanguage,widget.token!);
          //         }
          //       },
          //     ),

          //   ),
          //   onTap: () {

          //     _fetchSuggestions(widget.selectedLanguage,widget.token!);
          //   },
          // ),
          SizedBox(height: 20.h),
          dataList.length != 0
              ? SingleChildScrollView(
                  child: Container(
                    height: 300,
                    width: 500,
                    child: ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(dataList[index]),
                          onTap: () {
                            //   _getTranslation(dataList[index], widget.selectedLanguage);
                          },
                          trailing: Obx(
                            () => Checkbox(
                                value: userController.words
                                        .contains(dataList[index])
                                    ? true
                                    : false,
                                onChanged: (val) {
                                  if (userController.words
                                      .contains(dataList[index])) {
                                    userController.words
                                        .remove(dataList[index]);
                                  } else {
                                    userController.words.add(dataList[index]);
                                  }
                                }),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Container(),
          //  if (translations.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.all(16),
                color: Color(0xFFB4ACFF),
                child: Column(
                  children: [
                    widget.selectedLanguage == "english"
                        ? Text("Soomaali",style: TextStyle(color: Colors.black),)
                        : widget.selectedLanguage == "soomaali"
                            ? Text("English",style: TextStyle(color: Colors.black),)
                            : widget.selectedLanguage == "arabic"
                                ? Text("English",style: TextStyle(color: Colors.black),)
                                : Text(""),
                    Expanded(
                      child: ListView.builder(
                        itemCount: translations.length,
                        itemBuilder: (context, index) {
                          final word = translationsData!.keys.elementAt(index);
                          print(word);
                          final translations = translationsData![word];

                          return Row(
                            children: [
                              widget.selectedLanguage == "english"
                                  ? Expanded(child: Text(translations['soomaali'] ?? '',style: TextStyle(color: Colors.black),))
                                  : widget.selectedLanguage == "soomaali"
                                      ? Expanded(child: Text(translations['english'] ?? '',style: TextStyle(color: Colors.black),))
                                      : widget.selectedLanguage == "arabic"
                                          ? Expanded(child: Text(translations['english'] ?? '',style: TextStyle(color: Colors.black),))
                                          : Text(""),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.volume_up),
                                  onPressed: () {
                                    widget.selectedLanguage == "english"
                                        ? 
                                        textToSpeech(textToSpeak: translations['soomaali'])
                                        // speak(
                                        //     translations['soomaali'], "so-SO")
                                        : widget.selectedLanguage == "soomaali"
                                            ? speak(translations['english'],
                                                "en-US")
                                            : widget.selectedLanguage ==
                                                    "arabic"
                                                ? speak(translations['english'],
                                                    "en-US")
                                                : Text(
                                                    ""); // Replace with your dynamic text
                                  },
                                  // child: Text('Play Audio'),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.all(16),
                color: Color(0xFFE1C7FF),
                child: Column(
                  children: [
                    widget.selectedLanguage == "english"
                        ? Text("Arabic",style: TextStyle(color: Colors.black),)
                        : widget.selectedLanguage == "soomaali"
                            ? Text("Arabic",style: TextStyle(color: Colors.black),)
                            : widget.selectedLanguage == "arabic"
                                ? Text("Soomaali",style: TextStyle(color: Colors.black),)
                                : Text(""),
                    //   Text(translations['arabic'] != null ? 'Arabic' : ''),
//                     widget.selectedLanguage ==  "english"?    Text(translations['arabic'] ?? ''): widget.selectedLanguage ==  "soomaali" ?Text(translations['arabic'] ?? ''):widget.selectedLanguage ==  "arabic" ?Text(translations['soomaali'] ?? ''):Text(""),
//                     Align(
// alignment: Alignment.topRight,
//                       child: IconButton(
//                          icon: Icon(Icons.volume_up),
//                         onPressed: () {
//                        widget.selectedLanguage ==  "english"?    speak(translations['arabic'],"ar"): widget.selectedLanguage ==  "soomaali" ?speak(translations['arabic'],"ar"):widget.selectedLanguage ==  "arabic" ?speak(translations['soomaali'],"so-SO"):Text(""); // Replace with your dynamic text
//                         },
//                         // child: Text('Play Audio'),
//                       ),
//                     ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: translations.length,
                        itemBuilder: (context, index) {
                          final word = translationsData!.keys.elementAt(index);
                          print(word);
                          final translations = translationsData![word];

                          return Row(
                            children: [
                              widget.selectedLanguage == "english"
                                  ? Expanded(child: Text(translations['arabic'] ?? '',style: TextStyle(color: Colors.black),))
                                  : widget.selectedLanguage == "soomaali"
                                      ? Expanded(child: Text(translations['arabic'] ?? '',style: TextStyle(color: Colors.black),))
                                      : widget.selectedLanguage == "arabic"
                                          ? Expanded(child: Text(translations['soomaali'] ?? '',style: TextStyle(color: Colors.black),))
                                          : Text(""),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.volume_up),
                                  onPressed: () {
                                    widget.selectedLanguage == "english"
                                        ? speak(translations['arabic'], "ar")
                                        : widget.selectedLanguage == "soomaali"
                                            ? speak(
                                                translations['arabic'], "ar")
                                            : widget.selectedLanguage ==
                                                    "arabic"
                                                ? textToSpeech(textToSpeak: translations['soomaali'])
                                                : Text(
                                                    ""); // Replace with your dynamic text
                                  },
                                  // child: Text('Play Audio'),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _fetchSuggestions(String query, String token) async {
    print(token);
    print(query);
    try {
      final response = await http.post(
        Uri.parse(
            'https://translation.saeedantechpvt.com/api/app/search-translate'),
        headers: {
          'Authorization':
              "Bearer " + token, // Replace with your actual auth token
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

  Map<String, dynamic>? translationsData;
  
  Future<void> _getTranslation(List<String> word, String lang) async {
    try {

      print(word);
      print(lang);
      final response = await http.post(
        Uri.parse(
            'https://translation.saeedantechpvt.com/api/app/get-translate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${widget.token}'
        },
        // headers: {},
        body: jsonEncode({'lang': lang, 'word': word}),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        translationsData = data['data']['translations'];

        setState(() {
          translations = translationsData!;
        });
        userController.words.clear();
      } else {
        Fluttertoast.showToast(
            msg: 'Failed to get translation. Please try again.');
            userController.words.clear();
      //  final userController = Get.put(UserController());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '${e}');
      userController.words.clear();
     // final userController = Get.put(UserController());
      print(e);
    }
  }

  Future<void> fetchExactTranslation(
      String query, String selectedLanguage, String token) async {
    print(token);
    print(query);
    print(selectedLanguage);
    try {
      final response = await http.post(
        Uri.parse(
            'https://translation.saeedantechpvt.com/api/app/search-translate'),
        headers: {
          'Authorization':
              "Bearer " + token, // Replace with your actual auth token
        },
        body: {
          'lang': selectedLanguage,
          'word': query,
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

  Future<void> fetch(String query, String token) async {
    print(token);
    try {
      final response = await http.post(
        Uri.parse(
            'https://translation.saeedantechpvt.com/api/app/search-translate'),
        headers: {
          'Authorization':
              "Bearer " + token, // Replace with your actual auth token
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












// // ... (imports)

// class SearchScreen extends StatefulWidget {
//   final String selectedLanguage;
//   final String token;

//   SearchScreen({required this.selectedLanguage, required this.token});

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   TextEditingController searchController = TextEditingController();
//   List<String> searchResults = [];
//   Map<String, dynamic> translations = {};

//   Future<void> _searchTranslate(String word, String lang) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://translation.saeedantechpvt.com/api/app/search-translate'),
//         headers: {'Authorization': 'Bearer ${widget.token}'},
//         body: {'lang': lang, 'word': word},
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         final Map<String, dynamic> translationsData = data['data']['translations'];

//         setState(() {
//           translations = translationsData;
//         });
//       } else {
//         Fluttertoast.showToast(msg: 'Failed to get translations. Please try again.');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error during translation. Please try again.');
//     }
//   }

//   Future<void> _getTranslation(String word, String lang) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://translation.saeedantechpvt.com/api/app/get-translate'),
//         headers: {'Authorization': 'Bearer ${widget.token}'},
//         body: {'lang': lang, 'word': word},
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         final Map<String, dynamic> translationsData = data['data']['translations'];

//         setState(() {
//           translations = translationsData;
//         });
//       } else {
//         Fluttertoast.showToast(msg: 'Failed to get translation. Please try again.');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error during translation. Please try again.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search and Translate'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(
//               controller: searchController,
//               onChanged: (value) {
//                 setState(() {
//                   searchResults.clear();
//                 });
//               },
//               onSubmitted: (value) {
//                 if (value.isNotEmpty) {
//                   _searchTranslate(value, widget.selectedLanguage);
//                 }
//               },
//               decoration: InputDecoration(
//                 hintText: 'Enter a word...',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//                     if (searchController.text.isNotEmpty) {
//                       _searchTranslate(searchController.text, widget.selectedLanguage);
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: searchResults.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(searchResults[index]),
//                   onTap: () {
//                     _getTranslation(searchResults[index], widget.selectedLanguage);
//                   },
//                 );
//               },
//             ),
//           ),
//           if (translations.isNotEmpty)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   color: Colors.blue,
//                   child: Column(
//                     children: [
//                       Text(translations['soomaali'] != null ? 'Soomaali' : ''),
//                       Text(translations['soomaali'] ?? ''),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   color: Colors.green,
//                   child: Column(
//                     children: [
//                       Text(translations['arabic'] != null ? 'Arabic' : ''),
//                       Text(translations['arabic'] ?? ''),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }
