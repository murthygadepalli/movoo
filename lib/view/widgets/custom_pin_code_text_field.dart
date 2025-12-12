import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../theme/custom_text_style.dart';
import '../../utils/app_export.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({
    super.key,
    required this.context,
    required this.onChanged,
    required this.onCompleted,
    this.alignment,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.validator,
    this.borderWith,
    this.width,
    this.height,
    required this.errorAnimationController,
    this.hasError= false,

  });

  final Alignment? alignment;

  final BuildContext context;

  final TextEditingController? controller;
  final StreamController<ErrorAnimationType> errorAnimationController;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  final Function(String) onChanged;
  final Function(String) onCompleted;

  final FormFieldValidator<String>? validator;

  final double? borderWith;
  final double? height;
  final double? width;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget,
          )
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => PinCodeTextField(
    errorTextMargin: const EdgeInsets.symmetric(vertical: 0, horizontal: AppSizes.md),
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        autoDisposeControllers: false,
        appContext: context,
        controller: controller,
        length: 6,
        keyboardType: TextInputType.number,
        textStyle: textStyle ?? CustomTextStyles.h5.copyWith(color: AppColors.black),
        hintStyle: hintStyle,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        enableActiveFill: true,
        errorAnimationController: errorAnimationController,

        pinTheme: PinTheme(

          fieldHeight: height ?? 50,
          fieldWidth: width ?? 50,
          shape: PinCodeFieldShape.box,
          borderWidth: borderWith ?? 0.6,
          borderRadius: BorderRadius.circular(8),
          inactiveColor: hasError ? AppColors.red :AppColors.primary,
          activeColor: hasError ? AppColors.red : AppColors.primary,
          inactiveFillColor:hasError ? AppColors.red.withOpacity(0.2): AppColors.white,
          activeFillColor: hasError ? AppColors.red.withOpacity(0.2) :AppColors.white,
          selectedColor: hasError ? AppColors.red :AppColors.primary,
          selectedFillColor: hasError ? AppColors.red.withOpacity(0.2) :AppColors.white.withOpacity(0.2),
          inactiveBorderWidth: 1,
          errorBorderColor: AppColors.red,
          errorBorderWidth: borderWith ?? 1,
        ),
        onCompleted: (value) => onCompleted(value),
        onChanged: (value) => onChanged(value),
        validator: validator,

      );
}
