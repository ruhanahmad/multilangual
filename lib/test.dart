// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Quiz App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: QuizPage(),
//     );
//   }
// }

// class QuizPage extends StatefulWidget {
//   @override
//   _QuizPageState createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   final String apiUrl = "https://translation.saeedantechpvt.com/api/app/get-questions?word=help&type=english to soomaali";
//   List<Map<String, dynamic>> quizData = [];
//   List<String> selectedAnswers = [];
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     fetchQuizData();
//   }

//   Future<void> fetchQuizData() async {
//     try {
//       final response = await http.post(Uri.parse(apiUrl),
//        headers:<String,String> {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization':"Bearer "+"3|45JAmjAZgEAKfdS9nxZ8eT8SjVnzJcsjkcHe1rJd2efc4048" // Replace with your actual auth token
//         },
      
//       );
//       if (response.statusCode == 200) {
//         setState(() {
//           quizData = List<Map<String, dynamic>>.from(json.decode(response.body)["data"]);
//         });
//       } else {
//         print("Error: ${response.statusCode}, ${response.body}");
//       }
//     } catch (error) {
//       print("Error: $error");
//     }
//   }

//   void handleAnswer(String selectedAnswer) {
//     setState(() {
//       selectedAnswers.add(selectedAnswer);
//     });
//   }

//   void nextQuestion() {
//     if (currentIndex < quizData.length - 1) {
//       setState(() {
//         currentIndex++;
//       });
//     }
//   }

//   void submitQuiz() {
//     // Calculate and display results here
//     int correctAnswers = 0;
//     int incorrectAnswers = 0;

//     for (int i = 0; i < quizData.length; i++) {
//       if (selectedAnswers[i] == quizData[i]["correct"]) {
//         correctAnswers++;
//       } else {
//         incorrectAnswers++;
//       }
//     }

//     // Display results or navigate to results screen
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Quiz Results'),
//           content: Column(
//             children: [
//               Text('Correct Answers: $correctAnswers'),
//               Text('Incorrect Answers: $incorrectAnswers'),
//               Text('Total Questions: ${quizData.length}'),
//               Text('Percentage: ${(correctAnswers / quizData.length * 100).toStringAsFixed(2)}%'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (quizData.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Loading...'),
//         ),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     } else {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Quiz App'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Question: ${quizData[currentIndex]["question"]}',
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: 16),
//               Column(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => handleAnswer(quizData[currentIndex]["answer_1"]),
//                     child: Text(quizData[currentIndex]["answer_1"]),
//                   ),
//                   ElevatedButton(
//                     onPressed: () => handleAnswer(quizData[currentIndex]["answer_2"]),
//                     child: Text(quizData[currentIndex]["answer_2"]),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               if (currentIndex < quizData.length - 1)
//                 ElevatedButton(
//                   onPressed: nextQuestion,
//                   child: Text('Next'),
//                 )
//               else
//                 ElevatedButton(
//                   onPressed: submitQuiz,
//                   child: Text('Submit'),
//                 ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }

// class QuizPage extends StatefulWidget {
//   @override
//   _QuizPageState createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   final String apiUrl = "{{local}}/api/app/get-questions?word=help&type=english";
//   List<Map<String, dynamic>> quizData = [];
//   String selectedAnswer = '';
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     fetchQuizData();
//   }

//   Future<void> fetchQuizData() async {
//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         setState(() {
//           quizData = List<Map<String, dynamic>>.from(json.decode(response.body)["data"]);
//         });
//       } else {
//         print("Error: ${response.statusCode}, ${response.body}");
//       }
//     } catch (error) {
//       print("Error: $error");
//     }
//   }

//   void handleAnswer(String answer) {
//     setState(() {
//       selectedAnswer = answer;
//     });
//   }

//   void nextQuestion() {
//     if (currentIndex < quizData.length - 1) {
//       setState(() {
//         currentIndex++;
//         selectedAnswer = ''; // Reset selected answer for the next question
//       });
//     }
//   }

//   void submitQuiz() {
//     // Calculate and display results here
//     int correctAnswers = 0;
//     int incorrectAnswers = 0;

//     for (int i = 0; i < quizData.length; i++) {
//       if (selectedAnswer == quizData[i]["correct"]) {
//         correctAnswers++;
//       } else {
//         incorrectAnswers++;
//       }
//     }

//     // Display results or navigate to results screen
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Quiz Results'),
//           content: Column(
//             children: [
//               Text('Correct Answers: $correctAnswers'),
//               Text('Incorrect Answers: $incorrectAnswers'),
//               Text('Total Questions: ${quizData.length}'),
//               Text('Percentage: ${(correctAnswers / quizData.length * 100).toStringAsFixed(2)}%'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (quizData.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Loading...'),
//         ),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     } else {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Quiz App'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Question: ${quizData[currentIndex]["question"]}',
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: 16),
//               Column(
//                 children: [
//                   for (String answer in [quizData[currentIndex]["answer_1"], quizData[currentIndex]["answer_2"]])
//                     RadioListTile<String>(
//                       title: Text(answer),
//                       value: answer,
//                       groupValue: selectedAnswer,
//                       onChanged: (value) => handleAnswer(value!),
//                     ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               if (currentIndex < quizData.length - 1)
//                 ElevatedButton(
//                   onPressed: nextQuestion,
//                   child: Text('Next'),
//                 )
//               else
//                 ElevatedButton(
//                   onPressed: submitQuiz,
//                   child: Text('Submit'),
//                 ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:percent_indicator/percent_indicator.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Quiz App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: QuizPage(),
//     );
//   }
// }

// class QuizPage extends StatefulWidget {
//   @override
//   _QuizPageState createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   final String apiUrl = "{{local}}/api/app/get-questions?word=help&type=english";
//   List<Map<String, dynamic>> quizData = [];
//   String selectedAnswerKey = '';
//   double quizProgress = 0.0;
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     fetchQuizData();
//   }

//   Future<void> fetchQuizData() async {
//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         setState(() {
//           quizData = List<Map<String, dynamic>>.from(json.decode(response.body)["data"]);
//         });
//       } else {
//         print("Error: ${response.statusCode}, ${response.body}");
//       }
//     } catch (error) {
//       print("Error: $error");
//     }
//   }

//   void handleAnswer(String answerKey) {
//     setState(() {
//       selectedAnswerKey = answerKey;
//     });
//   }

//   void nextQuestion() {
//     if (selectedAnswerKey.isNotEmpty && currentIndex < quizData.length - 1) {
//       setState(() {
//         currentIndex++;
//         selectedAnswerKey = ''; // Reset selected answer for the next question
//         updateQuizProgress(); // Update progress when moving to the next question
//       });
//     } else if (selectedAnswerKey.isEmpty) {
//       // Show an error message because no option is selected
//       showErrorDialog('Please select an answer before proceeding.');
//     }
//   }

//   void submitQuiz() {
//     if (selectedAnswerKey.isNotEmpty) {
//       // Calculate and display results here
//       int correctAnswers = 0;
//       int incorrectAnswers = 0;

//       for (int i = 0; i < quizData.length; i++) {
//         if (selectedAnswerKey == quizData[i]["correct"]) {
//           correctAnswers++;
//         } else {
//           incorrectAnswers++;
//         }
//       }

//       // Update quiz progress with the final percentage
//       updateQuizProgress();

//       // Display results or navigate to results screen
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Quiz Results'),
//             content: Column(
//               children: [
//                 Text('Correct Answers: $correctAnswers'),
//                 Text('Incorrect Answers: $incorrectAnswers'),
//                 Text('Total Questions: ${quizData.length}'),
//                 LinearPercentIndicator(
//                   width: 400.0,
//                   lineHeight: 20.0,
//                   percent: quizProgress,
//                   center: Text(
//                     ' ${(quizProgress * 100).toStringAsFixed(2)}%',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                   linearStrokeCap: LinearStrokeCap.roundAll,
//                   backgroundColor: Colors.grey,
//                   progressColor: Colors.blue,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Show an error message because no option is selected
//       showErrorDialog('Please select an answer before submitting.');
//     }
//   }

//   void updateQuizProgress() {
//     setState(() {
//       quizProgress = (currentIndex + 1) / quizData.length;
//     });
//   }

//   void showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (quizData.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Loading...'),
//         ),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     } else {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Quiz App'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Question: ${quizData[currentIndex]["question"]}',
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: 16),
//               Column(
//                 children: [
//                   for (MapEntry<String, dynamic> entry in quizData[currentIndex]["choices"].entries)
//                     RadioListTile<String>(
//                       title: Text(entry.value),
//                       value: entry.key,
//                       groupValue: selectedAnswerKey,
//                       onChanged: (value) => handleAnswer(value!),
//                     ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               LinearPercentIndicator(
//                 width: 400.0,
//                 lineHeight: 20.0,
//                 percent: quizProgress,
//                 center: Text(
//                   ' ${(quizProgress * 100).toStringAsFixed(2)}%',
//                   style: TextStyle(fontSize: 12.0),
//                 ),
//                 linearStrokeCap: LinearStrokeCap.roundAll,
//                 backgroundColor: Colors.grey,
//                 progressColor: Colors.blue,
//               ),
//               SizedBox(height: 16),
//               if (currentIndex < quizData.length - 1)
//                 ElevatedButton(
//                   onPressed: nextQuestion,
//                   child: Text('Next'),
//                 )
//               else
//                 ElevatedButton(
//                   onPressed: submitQuiz,
//                   child: Text('Submit'),
//                 ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }
// ```