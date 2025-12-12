import 'package:flutter/material.dart';
import 'package:movo_customer/utils/constants/colors.dart';
import 'package:movo_customer/view/screens/splash_screen.dart';
import 'package:movo_customer/view/widgets/custom_elevated_button.dart';
import 'package:pinput/pinput.dart';

import '../../../theme/custom_text_style.dart';
import '../home/home_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isError = false;

  void verifyOtp() {
    if (otpController.text == "123456") {
      setState(() => isError = false);

      // Navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(), // Replace with your actual screen
        ),
      );
    } else {
      setState(() => isError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = isError ? Colors.red : const Color(0xFF5B2C6F);

    final defaultPinTheme = PinTheme(
      width: 40,
      height: 50,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      decoration: const BoxDecoration(), // No individual box decoration
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Verify OTP",
                  style:CustomTextStyles.h6.copyWith(
                    fontFamily: "Poppins"
                  )
                ),
                const SizedBox(height: 15),
                 Text(
                  "Enter the 6-digit code sent to 9876543210",
                  style: CustomTextStyles.b4_1.copyWith(
                    fontFamily: "Poppins"
                  ),
                ),
                const SizedBox(height: 10),

                /// OTP field with single box style
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor, width: 1.5),
                  ),
                  child: Pinput(
                    length: 6,
                    controller: otpController,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 20),
                    showCursor: true,
                  ),
                ),

                if (isError)
                   Padding(
                    padding: EdgeInsets.only(top: 6, left: 2),
                    child: Text(
                      "OTP Entered is incorrect, Please Try again",
                      style:CustomTextStyles.b4_1.copyWith(
                        fontFamily: "Poppins"
                      )
                    ),
                  ),

                const SizedBox(height: 20),

                /// Send OTP button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomElevatedButton(
                    buttonStyle: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.primary)
                    ),
                    buttonTextStyle:CustomTextStyles.b3_1.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"
                    ),

                    onPressed: verifyOtp,
                    text:
                      "Verify OTP",

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
