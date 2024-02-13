import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:multitranslation/loginPage.dart';
import 'package:multitranslation/paymentScreen.dart';
import 'package:multitranslation/splashpage.dart';
import 'package:multitranslation/storage/keys.dart';
import 'package:multitranslation/storage/storage.dart';
import 'package:multitranslation/twoThreeSeconds.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  MpesaFlutterPlugin.setConsumerKey(
      "B2qlFEVmMT5Ls2VtPwpveQdTE54bRtuQktBFGG51mS1ozU97");
  MpesaFlutterPlugin.setConsumerSecret(
      "vtqKbajz1AwnPplw6mSGB5tLkuwjjlUQdyLkFDN94SCllw0ldc7B0ip5ruf6XOQP");
  // await GetStorage.init();
  await StorageServices.to.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          //        localeResolutionCallback: (locale, supportedLocales) {
          // return const Locale('en', ''); // Force LTR layout
          // },
          // locale: Get.deviceLocale, // Set the default locale
          //      fallbackLocale: const Locale('en', 'US'),
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
          builder: EasyLoading.init(),
        );
      },
      child: StorageServices.to.getString(userToken).isNotEmpty
          ? PaymentScreen()
          : VeryFirstScreen(),
    );
  }
}
