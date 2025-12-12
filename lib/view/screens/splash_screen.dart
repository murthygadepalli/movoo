import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../theme/custom_text_style.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/icon_constants.dart';
import '../widgets/custom_image_view.dart';
import 'language_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if(mounted){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>    const LanguageSelectionScreen()), // Replace with your next screen

        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CustomImageView(
              imagePath: AppIcons.appLogo,
            ),
            const Spacer(),
            // Text(
            //   'All Your Dental Needs in',
            //   style: CustomTextStyles.b1,
            // ),
            // Text(
            //   'One Place',
            //   style: CustomTextStyles.b1,
            // ),
            // Spacer(),
            const SizedBox(height: 16,),
            const SpinKitCircle(
              color: AppColors.primary,
              size: 50.0,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

