import 'package:flutter/material.dart';
import '../../theme/custom_text_style.dart';
import '../../utils/app_export.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import 'base_button.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    required super.text,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: height ?? 56,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              const SizedBox(
                width: AppSizes.spaceSmall,
              ),
              Text(
                  text,
                  style: buttonTextStyle ??
                      CustomTextStyles.b3.copyWith(
                        inherit: true,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500
                      ),
                ),

              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
