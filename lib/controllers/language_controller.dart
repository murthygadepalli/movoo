import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../models/language_model.dart';


class LanguageController extends GetxController {
  var languages = <LanguageModel>[
    LanguageModel(name: "English", code: "en"),
    LanguageModel(name: "हिंदी", code: "hi"),
    // LanguageModel(name: "বাংলা", code: "bn"),
    // LanguageModel(name: "मराठी", code: "mr"),
    LanguageModel(name: "తెలుగు", code: "te"),
    LanguageModel(name: "தமிழ்", code: "ta"),
    // LanguageModel(name: "ગુજરાતી", code: "gu"),
    // LanguageModel(name: "ಕನ್ನಡ", code: "kn"),
    // LanguageModel(name: "മലയാളം", code: "ml"),
    // LanguageModel(name: "অসমীয়া", code: "as"),
    // LanguageModel(name: "मैथिली", code: "mai"),
    // LanguageModel(name: "মণিপুরী", code: "mni"),
    // LanguageModel(name: "नेपाली", code: "ne"),
    // LanguageModel(name: "कोंकणी", code: "kok"),
  ].obs;

  var selectedIndex = 0.obs;

  static Locale get currentLocale {
    final controller = Get.find<LanguageController>();
    final langCode = controller.selectedLanguage.code;
    return Locale(langCode);
  }

  LanguageModel get selectedLanguage => languages[selectedIndex.value];

  void selectLanguage(int index) {
    selectedIndex.value = index;
    Get.updateLocale(Locale(languages[index].code));
  }
}
