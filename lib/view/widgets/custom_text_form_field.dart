import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../theme/app_decoration.dart';
import '../../theme/custom_text_style.dart';
import '../../utils/app_export.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.height,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
    this.onChanged,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onFocusChange,
    this.borderColor,
    this.onTap,
    this.disabledBorderColor,
    this.allowShadow = true,
  });

  final Alignment? alignment;
  final double? width;
  final double? height;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool enabled;
  final bool? autofocus;
  final ValueChanged<String>? onChanged;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final void Function(bool)? onFocusChange;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Color? disabledBorderColor;
  final bool allowShadow;

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode focusNode1;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    focusNode1 = widget.focusNode ?? FocusNode();

    // Add listener to detect focus change
    focusNode1.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode1.removeListener(() {}); // Remove listener to avoid memory leaks
    if (widget.focusNode == null) {
      focusNode1.dispose(); // Dispose focusNode only if it was created in this widget
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
      alignment: widget.alignment ?? Alignment.center,
      child: textFormFieldWidget(context),
    )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) {
    return SizedBox(
      width: widget.width ?? (MediaQuery.of(context).size.width < 600 ? Get.size.width : (MediaQuery.of(context).size.width > 600 && MediaQuery.of(context).size.width < 1000) ?  Get.size.width * 0.8  :  Get.size.width * 0.5),
     height: widget.height,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: hasError
              ? [] // No shadow when there's an error
              : widget.allowShadow
              ? AppDecoration.shadow1_3 // Apply shadow if no error
              : null,
          color: Colors.white,
          borderRadius: BorderRadiusStyle.border12,
        ),
        child: TextFormField(
          scrollPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: widget.controller,
          focusNode: focusNode1,
          onTapOutside: (event) {
            focusNode1.unfocus();
            widget.onFocusChange?.call(false);
          },
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          autofocus: widget.autofocus!,
          style: widget.textStyle ??
              CustomTextStyles.b2.copyWith(
                color: !widget.enabled ? AppColors.darkerGrey : AppColors.black,
                fontWeight: FontWeight.w500,
              ),
          obscureText: widget.obscureText!,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines ?? 1,
          decoration: getDecoration(),
          validator: (value) {
            String? validationResult = widget.validator?.call(value);
            setState(() {
              hasError = validationResult != null; // Toggle shadow based on validation result
            });
            return validationResult;
          },
          onTap: () {
            widget.onFocusChange?.call(true);
            widget.onTap?.call();
          },
          onEditingComplete: () {
            widget.onFocusChange?.call(false);
          },
        ),
      ),
    );
  }

  InputDecoration getDecoration() {
    return InputDecoration(
      hintText: widget.hintText ?? "",
      hintStyle: widget.hintStyle ??
          CustomTextStyles.b5.copyWith(color: AppColors.darkGrey),
      prefixIcon: widget.prefix,
      prefixIconConstraints: widget.prefixConstraints,
      suffixIcon: widget.suffix,
      suffixIconConstraints: widget.suffixConstraints,
      isDense: true,
      contentPadding: widget.contentPadding ??
          const EdgeInsets.symmetric(vertical: 18, horizontal: AppSizes.md),
      fillColor: focusNode1.hasFocus || widget.enabled
          ? Colors.white
          : AppColors.grey.withOpacity(0.1),
      filled: widget.filled,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadiusStyle.border12,
        borderSide: const BorderSide(
          color: AppColors.red,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius:BorderRadiusStyle.border12 ,
        borderSide: const BorderSide(
          color: AppColors.red,
          width: 1,
        ),
      ),
      errorStyle: CustomTextStyles.b6.copyWith(color: Colors.red),
      border: widget.borderDecoration ??
          OutlineInputBorder(
            borderRadius: BorderRadiusStyle.border12,
            borderSide: const BorderSide(
              width: 1,
            ),
          ),
      enabledBorder: widget.borderDecoration ??
          OutlineInputBorder(
            borderRadius: BorderRadiusStyle.border12,
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
      focusedBorder: widget.borderDecoration ??
          OutlineInputBorder(
            borderRadius: BorderRadiusStyle.border12,
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.primary,
              width: 1,
            ),
          ),
    );
  }
}