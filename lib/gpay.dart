import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multitranslation/splashpage.dart';
import 'package:pay/pay.dart';

class GPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 200,
            child: GooglePayButton(
              // ignore: deprecated_member_use
              paymentConfigurationAsset: 'sample_payment_configuration.json',
              paymentItems: _paymentItems,
              type: GooglePayButtonType.pay,
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      )),
    );
  }

  final _paymentItems = [
    const PaymentItem(
      label: 'Total',
      amount: '1.0',
      status: PaymentItemStatus.final_price,
    ),
  ];
  // In your Stateless Widget class or State
  void onGooglePayResult(paymentResult) async {
    // Send the resulting Google Pay token to your server or PSP

    Get.to(() => SplashScreen());
    Fluttertoast.showToast(msg: "Paid successfully");
  }
}
