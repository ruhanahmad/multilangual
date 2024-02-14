import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multitranslation/gpay.dart';
import 'package:multitranslation/loginPage.dart';
import 'package:multitranslation/splashpage.dart';
import 'package:multitranslation/storage/keys.dart';
import 'package:multitranslation/storage/storage.dart';
import 'package:http/http.dart' as http;
// // import 'package:multitranslation/stripePayment.dart';
import 'package:pay/pay.dart';
//import 'payment_configuration.dart' as payment_configurations;
import 'paymentScreen.dart';

class SelectPaymentMethods extends StatefulWidget {
  String? token;
  Map<String, dynamic>? userData;

  SelectPaymentMethods({this.token, this.userData});
  @override
  State<SelectPaymentMethods> createState() => _SelectPaymentMethodsState();
}

class _SelectPaymentMethodsState extends State<SelectPaymentMethods> {
  final _paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    ),
  ];
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
        await StorageServices.to.remove(userToken);
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

  // In your Stateless Widget class or State
  void onGooglePayResult(paymentResult) async {
    // Send the resulting Google Pay token to your server or PSP
    print(paymentResult);
    Get.to(() => SplashScreen(token: widget.token, userData: widget.userData));
  }

  // late final Future<PaymentConfiguration> _googlePayConfigFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  _googlePayConfigFuture =
    //     PaymentConfiguration.fromAsset('default_google_pay_config.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        ElevatedButton(
          onPressed: () async {
            // Handle button press
            await logOut();
          },
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF832CE5), // Button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Border radius
            ),
            minimumSize: Size(80.w, 29.h), // Width and height
          ),
          child: const Text(
            'Log Out',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Select payment Method",
              style: TextStyle(fontSize: 30.sp, color: Colors.black),
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => PaymentScreen());
                },
                child: const Text("Pay with Waafi")),
            const SizedBox(
              height: 20,
            ),

            GooglePayButton(
              // ignore: deprecated_member_use
              paymentConfigurationAsset: 'sample_payment_configuration.json',
              paymentItems: _paymentItems,
              type: GooglePayButtonType.pay,
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       Get.to(() => GPay());
            //     },
            //     child: const Text("Pay with Gpay")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  //      Get.to(() => StripePayment());
                },
                child: const Text("Pay with Stripe")),
            const SizedBox(
              height: 60,
            ),
            //  Container(
            //   height: 50,
            //   width: 200,

            //   child: GooglePayButton(
            //     // ignore: deprecated_member_use
            //     paymentConfigurationAsset: 'sample_payment_configuration.json',
            //     paymentItems: _paymentItems,
            //     type: GooglePayButtonType.pay,
            //     onPaymentResult: onGooglePayResult,
            //     loadingIndicator: const Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   ),
            // ),
            // FutureBuilder<PaymentConfiguration>(
            //     future: _googlePayConfigFuture,
            //     builder: (context, snapshot) => snapshot.hasData
            //         ? GooglePayButton(
            //             paymentConfiguration: snapshot.data!,
            //             paymentItems: _paymentItems,
            //             type: GooglePayButtonType.buy,
            //             margin: const EdgeInsets.only(top: 15.0),
            //             onPaymentResult: onGooglePayResult,
            //             loadingIndicator: const Center(
            //               child: CircularProgressIndicator(),
            //             ),
            //           )
            //         : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  // final _paymentItems = [
  //   const PaymentItem(
  //     label: 'Total',
  //     amount: '1.0',
  //     status: PaymentItemStatus.final_price,
  //   ),
  // ];

  // In your Stateless Widget class or State
  // void onGooglePayResult(paymentResult) async {
  //   // Send the resulting Google Pay token to your server or PSP

  //   Get.to(() => SplashScreen());
  //   Fluttertoast.showToast(msg: "Paid successfully");
  // }
}
