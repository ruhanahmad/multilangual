

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  // final storage = GetStorage();
  
  final _locale = Locale('en').obs;
  Locale get locale => _locale.value;

  // @override
  // void onInit() {
  //   super.onInit();
  //   _loadSavedLocale();
  // }

  // void _loadSavedLocale() {
  //   final savedLocale = storage.read('locale');
  //   if (savedLocale != null) {
  //     _locale.value = Locale(savedLocale);
  //   }
  // }

  // void changeLocale(String langCode) {
  //   _locale.value = Locale(langCode);
  //   storage.write('locale', langCode);
  //   Get.updateLocale(locale);
  // }
}
