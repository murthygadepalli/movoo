import 'package:movo_customer/theme/widget_themes/appbar_theme.dart';
import 'package:movo_customer/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:movo_customer/theme/widget_themes/checkbox_theme.dart';
import 'package:movo_customer/theme/widget_themes/chip_theme.dart';
import 'package:movo_customer/theme/widget_themes/dialog_theme.dart';
import 'package:movo_customer/theme/widget_themes/elevated_button_theme.dart';
import 'package:movo_customer/theme/widget_themes/outlined_button_theme.dart';
import 'package:movo_customer/theme/widget_themes/progress_bar_theme.dart';
import 'package:movo_customer/theme/widget_themes/text_field_theme.dart';
import 'package:movo_customer/theme/widget_themes/text_selection_theme.dart';
import 'package:movo_customer/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class IAppTheme {
  IAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors().createMaterialColor(AppColors.primary)).copyWith(
      primary: AppColors.primary,
      secondary: AppColors.white,
      error: AppColors.red,
    ),

    disabledColor: AppColors.buttonDisabled,
    brightness: Brightness.light,
    dialogBackgroundColor: AppColors.white,
    progressIndicatorTheme: IProgressBarTheme.lightProgressIndicatorTheme,
    primaryColor: AppColors.primary,
    textTheme: ITextTheme.lightTextTheme,
    chipTheme: IChipTheme.lightChipTheme,
    scaffoldBackgroundColor: AppColors.background1,
    appBarTheme: IAppBarTheme.lightAppBarTheme,
    checkboxTheme: ICheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: IBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: IElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: IOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: ITextFormFieldTheme.lightInputDecorationTheme,
    textSelectionTheme: ITextSelection.lightTextSelectionTheme,
    dialogTheme: IDialogTheme.lightDialogTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    disabledColor: AppColors.grey,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    textTheme: ITextTheme.darkTextTheme,
    chipTheme: IChipTheme.darkChipTheme,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: IAppBarTheme.darkAppBarTheme,
    checkboxTheme: ICheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: IBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: IElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: IOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: ITextFormFieldTheme.darkInputDecorationTheme,
  );
}

ThemeData get theme => IAppTheme.lightTheme;
