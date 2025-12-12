import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movo_customer/theme/custom_text_style.dart';
import 'package:movo_customer/utils/constants/colors.dart';
import 'package:movo_customer/view/screens/authentication/otp_screen.dart';
import 'package:movo_customer/view/widgets/custom_image_view.dart';
import 'package:movo_customer/view/widgets/custom_text_form_field.dart';

import '../../../utils/constants/icon_constants.dart';
import '../../widgets/custom_elevated_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _selectedRequirement;
  String? _selectedReferralOption;
  bool allowWhatsApp = false;

  final TextEditingController referralCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// Logo
              CustomImageView(
                imagePath: AppIcons.appLogo,
              ),
              const SizedBox(height: 50),

              /// Phone number + change
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: AppIcons.flag,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "9876543290",
                      style: CustomTextStyles.b4_1.copyWith(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(width: 14),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Change",
                        style: CustomTextStyles.b4_1.copyWith(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: const Color(0xff5B2C6F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildTextField("First Name", "Enter your First name"),
                    const SizedBox(height: 16),
                    _buildTextField("Last Name", "Enter your Last name"),
                    const SizedBox(height: 16),
                    _buildTextField("Email ID", "Enter Email ID",
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 16),

                    /// Requirement dropdown
                    _buildDropdownField(
                      "Requirement",
                      ["Business", "Personal", "HouseShifting"],
                      _selectedRequirement,
                          (val) {
                        setState(() {
                          _selectedRequirement = val;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    /// Referral code Yes/No dropdown
                    _buildDropdownField(
                      "Have referral code",
                      ["Yes", "No"],
                      _selectedReferralOption,
                          (val) {
                        setState(() {
                          _selectedReferralOption = val;
                          if (val == "No") {
                            referralCodeController.text = "No";
                          } else {
                            referralCodeController.clear();
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    /// Referral Code text field (only show if Yes)
                    if (_selectedReferralOption == "Yes")
                      _buildTextField(
                        "Referral Code",
                        "Enter referral code",
                        controller: referralCodeController,
                      ),

                    const SizedBox(height: 16),

                    /// WhatsApp checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: allowWhatsApp,
                          activeColor: const Color(0xff5B2C6F),
                          onChanged: (value) {
                            setState(() {
                              allowWhatsApp = value ?? false;
                            });
                          },
                        ),
                        const Text(
                          "Allow to send Updates on ",
                          style: TextStyle(fontSize: 10),
                        ),
                        CustomImageView(imagePath: AppIcons.whatsapp),
                        const SizedBox(width: 4),
                        const Text(
                          "WhatsApp",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),


              /// Register button
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white, // Background for the bar area
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
          child: SizedBox(
            height: 56,
            width: double.infinity,
            child: CustomElevatedButton(
              buttonTextStyle:CustomTextStyles.b3_1.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins"
              ),
              buttonStyle: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  AppColors.primary
                )
              ),

              onPressed: () {
                Get.to(()=> OtpScreen());
                // Handle register click

              },

               text:  "Register",

            ),
          ),
        )
    );
  }

  Widget _buildTextField(
      String label,
      String hint, {
        TextInputType keyboardType = TextInputType.text,
        TextEditingController? controller,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: CustomTextStyles.b4_1.copyWith(
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: CustomTextStyles.b4_1.copyWith(
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
              color: const Color(0xff35181E).withOpacity(0.5),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              const BorderSide(color: Color(0xFF5B2C6F), width: 1.2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
      String label,
      List<String> items,
      String? selectedValue,
      ValueChanged<String?> onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: CustomTextStyles.b4_1.copyWith(
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              "Select",
              style: CustomTextStyles.b4_1.copyWith(
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
                color: const Color(0xff35181E).withOpacity(0.5),
              ),
            ),
            value: selectedValue,
            buttonStyleData: ButtonStyleData(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              offset: const Offset(0, 0),
            ),
            items: items.map((value) {
              int index = items.indexOf(value);
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
                  decoration: BoxDecoration(
                    border: index != items.length - 1
                        ? const Border(
                      bottom: BorderSide(
                          color: Color(0xFFE0E0E0), width: 1),
                    )
                        : null,
                  ),
                  child: Text(
                    value,
                    style: CustomTextStyles.b4_1.copyWith(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
