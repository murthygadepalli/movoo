import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movo_customer/theme/custom_text_style.dart';
import 'package:movo_customer/utils/constants/icon_constants.dart';
import 'package:movo_customer/view/screens/saved_addresses/saved_address_screen.dart';
import 'package:movo_customer/view/widgets/custom_elevated_button.dart';
import 'package:movo_customer/view/widgets/custom_image_view.dart';
import 'package:movo_customer/view/widgets/custom_outlined_button.dart';

import '../../../utils/constants/colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  static const Color kPrimary = Color(0xFF5B2C6F);

  static const Color kBg = Color(0xFFF6F6F8);
  static const double kRadius = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFEAF1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // === PROFILE CARD ===
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kRadius),
                  border: Border.all(color: Colors.black.withOpacity(0.08)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: kPrimary,
                          child: const Text(
                            'SP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                'Suresh Pyla',
                                style:CustomTextStyles.b2_1.copyWith(
                                  fontFamily: "Poppins"
                                )
                              ),
                              SizedBox(height: 2),
                              Text(
                                'sureshpyle420840@gmail.com',
                                style:CustomTextStyles.b6_3.copyWith(
                                    fontFamily: "Poppins")),
                              SizedBox(height: 2),
                              Text(
                                'Verify Email ID',
                                  style:CustomTextStyles.b6_3.copyWith(
                                      fontFamily: "Poppins",
                                    color: AppColors.primary
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: CustomOutlinedButton(text:"Edit Profile",
                            buttonTextStyle:CustomTextStyles.b6_3.copyWith(
                              fontFamily: "Poppins"
                            ),
                            leftIcon: CustomImageView(
                              imagePath: AppIcons.editprofile,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            height: 32,
                            width: 170,
                            onPressed: () {},

                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomElevatedButton(text: "Add GST Details",
                            buttonTextStyle: CustomTextStyles.b6_3.copyWith(color: AppColors.white,fontFamily: "Poppins"),
                            leftIcon: CustomImageView(imagePath: AppIcons.add, color: AppColors.white,),
                            height: 32,
                            width: 170,
                            onPressed: () {},

                            buttonStyle: ButtonStyle(

                              backgroundColor: WidgetStateProperty.all(AppColors.primary),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // === MENU GROUP BOX ===
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kRadius),
                  border: Border.all(color: Colors.black.withOpacity(0.06)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _menuTile(
                      onTap: (){
                        Get.to(() => SavedAddressesScreen(isForSelection: true));
                      },
                      icon: CustomImageView(imagePath:AppIcons.location1,),
                      title: 'Saved Addresses',
                      showDivider: true,
                    ),
                    _menuTile(
                      onTap: (){},
                      icon: CustomImageView(imagePath:AppIcons.refer,),
                      title: 'Refer & Earn',
                      showDivider: true,
                    ),
                    _menuTile(
                      onTap: (){},
                      icon: CustomImageView(imagePath:AppIcons.language,),
                      title: 'Choose Languages',
                      showDivider: true,
                    ),
                    _menuTile(
                      onTap: (){},
                      icon: CustomImageView(imagePath:AppIcons.help,),
                      title: 'Help & Support',
                      showDivider: true,
                    ),
                    _menuTile(
                      onTap: (){},
                      icon: CustomImageView(imagePath:AppIcons.termsandcond,),
                      title: 'Terms & Conditions',
                      showDivider: true,
                    ),
                    _menuTile(
                      onTap: (){},
                      icon: CustomImageView(imagePath:AppIcons.about,),
                      title: 'About Us',
                      showDivider: false,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // === LOGOUT PILL ===
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(kRadius),
                child: Container(
                  padding:  EdgeInsets.symmetric(vertical: 14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kRadius),
                    border: Border.all(color: Colors.black.withOpacity(0.08)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      CustomImageView(imagePath: AppIcons.logout,),
                      SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: CustomTextStyles.b4_1.copyWith(
                          fontFamily: "Poppins"
                        )
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // Single row tile with divider like in the screenshot
  Widget _menuTile({
    required Function() onTap,
    required Widget icon, // ✅ Changed from IconData to Widget
    required String title,
    required bool showDivider,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                icon, // ✅ Directly use the widget
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: CustomTextStyles.b6_1.copyWith(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                CustomImageView(imagePath: AppIcons.arrowForward),
              ],
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black.withOpacity(0.06),
            ),
        ],
      ),
    );
  }
}
