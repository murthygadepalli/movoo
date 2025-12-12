import 'package:movo_customer/view/widgets/textfield_label.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import 'custom_text_form_field.dart';

class LabelTextField extends StatelessWidget {
  final String label;
  final String hint;
  final int? maxLines;
  final TextEditingController controller;
  final bool isDisabled;
  final Widget? suffix;
  final TextInputType? inputType;
  final bool? isMandatory;
  final bool? obscureText;
  final String? Function(String?)? validator;

  const LabelTextField({
    super.key,
    required this.label,
    required this.hint,
    this.maxLines,
    required this.controller,
    this.isDisabled = false,
    this.suffix,
    this.inputType,
    this.isMandatory,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldLabel(
          label: label,
          color: isDisabled ? AppColors.darkerGrey : null,
          isMandatory: isMandatory ?? true,
        ),
        CustomTextFormField(
          hintText: hint,
          controller: controller,
          enabled: !isDisabled,
          suffix: suffix,
          textInputType: inputType,
          obscureText: obscureText,
          validator: validator,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
