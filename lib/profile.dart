import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multitranslation/history.dart';

class UserDetailsScreen extends StatelessWidget {
  String token;
   Map<String, dynamic> userData;
  UserDetailsScreen({required this.token, required this.userData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF4E3DF8),
      // appBar: AppBar(
      //   title: Text('User Details'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
           "Full Name : " +  userData["firstname"],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
            "Email : " +  userData["email"],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(token:token!)),
                );
              },
              child: Text('History'),
            ),
          ],
        ),
      ),
    );
  }
}
