// //add Dart Async to the imports since this is an asynchronous process
// import 'dart:async';


// class MyAppState extends State<MyApp> {
// //create the lipaNaMpesa method here.Please note, the method can have any name, I chose lipaNaMpesa
// Future<void> lipaNaMpesa() async {
// dynamic transactionInitialisation;
// try {
// transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
// businessShortCode: "174379",
// transactionType: TransactionType.CustomerPayBillOnline,
// amount: 1.0,
// partyA:  "Place your phonenumber here eg..25472.........9",
// partyB: "174379",
// //Lipa na Mpesa Online ShortCode
// callBackURL: Uri(scheme: "https",
//                  host: "mpesa-requestbin.herokuapp.com",
//                  path: "/1hhy6391"),
// //This url has been generated from http://mpesa-requestbin.herokuapp.com/?ref=hackernoon.com for test purposes
// accountReference: "Maureen Josephine Clothline",
// phoneNumber:  "Place your phonenumber here eg..25472.........9",
// baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
// transactionDesc: "purchase",
// passKey: "Get Your Pass Key from Test Credentials its random eg..'c893059b1788uihh'...");
// //This passkey has been generated from Test Credentials from Safaricom Portal
	
// return transactionInitialisation;
// }
	
// catch (e) {
// print("CAUGHT EXCEPTION: " + e.toString());
// }
// }
