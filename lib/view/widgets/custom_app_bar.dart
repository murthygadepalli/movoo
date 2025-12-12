import 'package:flutter/material.dart';

import '../../theme/custom_text_style.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/icon_constants.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/size_utils.dart';
import 'custom_image_view.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.elevation,
    this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.leadingBack = true,
    this.onLeadingTap,
    this.title,
    this.titleWidget,
    this.textStyle,
    this.centerTitle,
    this.actions,
    this.shadowColor,
    this.backgroundColor,
    this.leadingBackColor,
    this.textColor,
  });

  final double? elevation;
  final double? height;
  final Style? styleType;
  final double? leadingWidth;
  final Widget? leading;
  final bool? leadingBack;
  final Function()? onLeadingTap;
  final String? title;
  final Widget? titleWidget;
  final TextStyle? textStyle;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color? shadowColor;
  final Color? backgroundColor;
  final Color? leadingBackColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      toolbarHeight: height ?? AppSizes.appBarHeight,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? AppColors.white,
      leadingWidth: leadingWidth ?? 42,
      leading: _leading(context),
      title: titleWidget ?? _buildTitle(),
      titleSpacing: 8,
      centerTitle: centerTitle ?? false,
      actions: actions,
      shadowColor: shadowColor,
    );
  }

  Widget _buildTitle(){
    return Text(title ?? '', style: textStyle ?? CustomTextStyles.b3_primary1.copyWith(color: textColor ?? AppColors.primary),);
  }

  Widget? _leading(BuildContext context) {
    if (leadingBack == false) {
      return Padding(
        padding: const EdgeInsets.only(left: AppSizes.md),
        child: leading,
      );
    } else {
      return GestureDetector(
        onTap: () {
          if(onLeadingTap != null){
            onLeadingTap;
          }else{
            Navigator.pop(context);
          }

        },
        child: Padding(
          padding: const EdgeInsets.only(left: AppSizes.md),
          child: CustomImageView(
            color: leadingBackColor ?? AppColors.primary,
            imagePath:  AppIcons.arrowBack,
            width: 24,
            height: 24,
          ),
        ),
      );
    }
  }


  @override
  Size get preferredSize => Size(
    SizeUtils.width,
    height ?? AppSizes.appBarHeight,
  );

}

enum Style {
  bgShadow,
}