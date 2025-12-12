import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movo_customer/theme/theme.dart';
import 'package:movo_customer/view/screens/splash_screen.dart';
import 'controllers/language_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Register the controller with GetX
  Get.put(LanguageController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // ✅ Changed from MaterialApp to GetMaterialApp
      debugShowCheckedModeBanner: false,
      title: 'Movo',
      theme: theme,
      home: const SplashScreen(),
    );
  }
}
