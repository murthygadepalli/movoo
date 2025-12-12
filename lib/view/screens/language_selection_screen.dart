import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movo_customer/theme/custom_text_style.dart';
import 'package:movo_customer/view/widgets/custom_elevated_button.dart';
import '../../controllers/language_controller.dart';
import '../../utils/constants/colors.dart';
import 'authentication/login_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final LanguageController controller = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEFEFE),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
      ),

      /// ✅ Continue button always sticks at the bottom
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 128,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24), // keeps space around button
            child: Align(
              alignment: Alignment.topCenter, // keep button at top of container
              child: SizedBox(
                width: double.infinity,
                height: 56, // fixed button height
                child: CustomElevatedButton(
                  buttonTextStyle: CustomTextStyles.b3_1.copyWith(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600
                  ),
                  buttonStyle: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.primary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  onPressed: () {
                    final lang = controller.selectedLanguage;
                    log('Selected: ${lang.name} (${lang.code})');
                    Get.to(()=>LoginScreen());

                  },
                  text: "Continue",

                ),
              ),
            ),
          ),
        ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Select language",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(height: 20),

              /// Languages Grid
              Expanded(
                child: Obx(() {
                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 16), // leaves gap before button
                    itemCount: controller.languages.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final lang = controller.languages[index];

                      return Obx(() {
                        final isSelected =
                            controller.selectedIndex.value == index;

                        return GestureDetector(
                          onTap: () => controller.selectLanguage(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey.shade300,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              gradient: isSelected
                                  ? const LinearGradient(
                                colors: [
                                  Color.fromRGBO(91, 44, 111, 0.25),
                                  Color.fromRGBO(91, 44, 111, 0.25),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              lang.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
