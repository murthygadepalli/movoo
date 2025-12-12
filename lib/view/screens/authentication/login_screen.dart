import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movo_customer/theme/custom_text_style.dart';
import 'package:movo_customer/utils/constants/icon_constants.dart';
import 'package:movo_customer/view/screens/authentication/register_screen.dart';
import 'package:movo_customer/view/widgets/custom_elevated_button.dart';
import 'package:movo_customer/view/widgets/custom_image_view.dart';

import '../../../utils/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    setState(() {}); // refresh UI when phone input changes
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// Logo that moves slightly up when keyboard is open
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              top: isKeyboardOpen ? 80 : MediaQuery.of(context).size.height / 3,
              left: 0,
              right: 0,
              child: Center(
                child: CustomImageView(
                  imagePath: AppIcons.appLogo,
                ),
              ),
            ),

            /// Bottom Login Section
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "Welcome",style: CustomTextStyles.h6.copyWith(
                       fontFamily: "Poppins"
                     ),
                    ),
                    const SizedBox(height: 8),
                     Text(
                      "Log in with your phone number",
                      style: CustomTextStyles.b4_1.copyWith(
                          fontFamily: "Poppins"
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Single Box Phone Number Field
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff5B2C6F),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                           Text(
                            "+91",
                            style:CustomTextStyles.b3_1.copyWith(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              color: AppColors.black
                            )
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                counterText: "",
                                hintText: "Enter Phone Number",
                                hintStyle: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 15,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 12),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (_errorText != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        _errorText!,
                        style:
                        const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ],

                    const SizedBox(height: 24),

                    /// Continue Button (only visible when 10 digits entered)
                    if (_phoneController.text.length == 10)
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomElevatedButton(
                          buttonTextStyle:CustomTextStyles.b3_1.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins"
                          ),
                          buttonStyle: ButtonStyle(

                            backgroundColor: MaterialStateProperty.all(AppColors.primary),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          text: "Continue",
                          onPressed: () {
                            Get.to(()=>RegisterScreen());
                            setState(() {
                              _errorText = null;
                            });
                            // ✅ Proceed with phone number
                          },

                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
