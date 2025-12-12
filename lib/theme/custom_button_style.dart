import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // text button style
  static ButtonStyle get darkBlueButton => ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.buttonSecondary),
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: AppColors.buttonSecondary),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );

  static ButtonStyle get roundButton => ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
    side: WidgetStateProperty.all<BorderSide>(
      const BorderSide(color: AppColors.buttonSecondary),
    ),
      );
}
