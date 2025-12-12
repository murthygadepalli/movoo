import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/widgets/custom_image_view.dart';
import 'constants/colors.dart';
import 'constants/icon_constants.dart';
import 'constants/sizes.dart';

class WebResponsiveUtils {
  static EdgeInsets webPadding(BuildContext context) => EdgeInsets.symmetric(
      horizontal: (MediaQuery.of(context).size.width > 1000
          ? 300
          : MediaQuery.of(context).size.width < 470
              ? 16
              : MediaQuery.of(context).size.width / 4));

  //static int get responsiveGridItemCount => Get.size.width > 750 ? 2 : 1;
  static int responsiveGridItemCount(BuildContext context) {
    return MediaQuery.of(context).size.width > 750 ? 2 : 1;
  }

  static double get responsiveButtonWidth =>
      Get.size.width < 600 ? Get.size.width : Get.size.width * 0.5;

  static double get responsiveWidth =>
      Get.size.width > 600 ? 600 : Get.size.width;

  static PreferredSizeWidget ownerWebAppBar(
      int currentWebIndex, BuildContext context) {
    bool isMobileWeb = MediaQuery.of(context).size.width <= 600;

    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        toolbarHeight: 80,
        leading: isMobileWeb
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              )
            : null,
        actions: [
          isMobileWeb
              ? mobileWebNotification()
              : const SizedBox(),
        ],
        title: Row(
          children: [
            CustomImageView(
              height: 30,
              width: 123,
              imagePath: AppIcons.appLogo,
              color: AppColors.white,
            ),
            const Spacer(),
            if (!isMobileWeb)
              Row(
                children: [
                  // _buildIconButton(
                  //     "home", 0, const OwnerHomeScreen(), currentWebIndex),
                  // _buildIconButton(
                  //     "orders", 1,  OwnerOrderList(), currentWebIndex),
                  // _buildIconButton(
                  //     "report", 2,  OwnerReports(), currentWebIndex),
                  // _buildIconButton("profile", 3, const OwnerProfileScreen(),
                  //     currentWebIndex),
                  // _buildIconButton("notification", 4,
                  //     const NotificationScreen(), currentWebIndex),
                ],
              ),
          ],
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
    );
  }

  static PreferredSizeWidget dentistWebAppBar(
      int currentWebIndex, BuildContext context) {
    bool isMobileWeb = MediaQuery.of(context).size.width <= 600;
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        toolbarHeight: 120,

        // leadingWidth: Get.size.width,
        // automaticallyImplyLeading: false,
        // backgroundColor: AppColors.primary,
        // elevation: 0,
        leading: isMobileWeb
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              )
            : null,

        actions: [
          isMobileWeb
              ? mobileWebNotification()
              : const SizedBox(),
        ],
        title: Row(
          children: [
            CustomImageView(
              height: 30,
              width: 123,
              imagePath: AppIcons.appLogo,
              color: AppColors.white,
            ),
            Spacer(),

            //SizedBox(width: MediaQuery.of(context).size.width>750?Get.size.width*0.5:Get.size.width),
            if (!isMobileWeb)
              Row(
                children: [
                  //Spacer(),
                  // _buildIconButton(
                  //     "home", 0, DentistHomeScreen(), currentWebIndex),
                  // _buildIconButton(
                  //     "orders", 1, DentistOrdersScreen(), currentWebIndex),
                  // _buildIconButton(
                  //     "report", 2, DentistReportsScreen(), currentWebIndex),
                  // _buildIconButton(
                  //     "profile", 3, DentistProfilescreen(), currentWebIndex),
                  // _buildIconButton(
                  //     "notification", 4, NotificationScreen(), currentWebIndex),
                  // _buildProfileButton(currentWebIndex, isMobileWeb),
                  // _buildNotificationButton(isMobileWeb),
                  //Spacer(),
                ],
              )
          ],
        ),
      ),
    );
  }

  static PreferredSizeWidget technicianWebAppBar(
      int currentWebIndex, BuildContext context) {
    bool isMobileWeb = kIsWeb && (Get.size.width <= 600);
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        toolbarHeight: 120,
        // leadingWidth: Get.size.width,
        // automaticallyImplyLeading: false,
        // backgroundColor: AppColors.primary,
        //elevation: 0,
        leading: isMobileWeb
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              )
            : null,

        actions: [
          isMobileWeb
              ? mobileWebNotification()
              : const SizedBox(),
        ],

        title: Row(
          children: [
            CustomImageView(
              height: 30,
              width: 123,
              imagePath: AppIcons.appLogo,
              color: AppColors.white,
            ),
            const Spacer(),
            if (!isMobileWeb)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // _buildIconButton(
                  //     "home", 0, const TechHomeScreen(), currentWebIndex),
                  // _buildIconButton("orders", 1,  TechOrderlistScreen(),
                  //     currentWebIndex),
                  // _buildIconButton(
                  //     "profile", 2, const TechProfileScreen(), currentWebIndex),
                  // _buildIconButton("notification", 3,
                  //     const NotificationScreen(), currentWebIndex),
                  // _buildProfileButton(currentWebIndex, isMobileWeb),
                  // _buildNotificationButton(isMobileWeb),
                ],
              )
          ],
        ),
      ),
    );
  }

  static PreferredSizeWidget deliveryWebAppBar(
      int currentWebIndex, BuildContext context) {
    bool isMobileWeb = kIsWeb && (Get.size.width <= 600);
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        toolbarHeight: 120,
        // leadingWidth: Get.size.width,
        // automaticallyImplyLeading: false,
        // backgroundColor: AppColors.primary,
        // elevation: 0,
        leading: isMobileWeb
            ? Builder(
              builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
              }
            )
            : null,

        actions: [
          isMobileWeb
              ? mobileWebNotification()
              : const SizedBox(),
        ],

        title: Row(
          children: [
            CustomImageView(
              height: 30,
              width: 123,
              imagePath: AppIcons.appLogo,
              color: AppColors.white,
            ),
            const Spacer(),

            //SizedBox(width: MediaQuery.of(context).size.width>750?Get.size.width*0.5:Get.size.width),
            if (!isMobileWeb)
              Row(
                children: [
                  //Spacer(),
                  // _buildIconButton("home", 0, const DeliveryBoyHomeScreen(),
                  //     currentWebIndex),
                  // _buildIconButton("orders", 1, DeliveryOrderListScreen(),
                  //     currentWebIndex),
                  // _buildIconButton("profile", 2, const DeliveryProfileScreen(),
                  //     currentWebIndex),
                  // _buildIconButton("notification", 3,
                  //     const NotificationScreen(), currentWebIndex),
                  // _buildProfileButton(currentWebIndex, isMobileWeb),
                  // _buildNotificationButton(isMobileWeb),
                  //Spacer(),
                ],
              )
          ],
        ),
      ),
    );
  }

  static Widget _buildIconButton(
      String iconName, int index, Widget screen, int currentWebIndex) {
    return GestureDetector(
      onTap: () => Get.offAll(() => screen),
      child: Container(
        height: 40,
        width: 40,
        margin: Get.size.width < 500
            ? const EdgeInsets.symmetric(horizontal: 3)
            : const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.1),
          border: currentWebIndex == index
              ? Border.all(color: Colors.white, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 6,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomImageView(
            imagePath:
                "assets/icons/${currentWebIndex == index ? '$iconName.svg' : '${iconName}_outlined.svg'}",
            color: Colors.white,
            width: 14,
          ),
        ),
      ),
    );
  }


}

Widget mobileWebNotification(){
  return Padding(
    padding: const EdgeInsets.only(right: AppSizes.md),
    child: GestureDetector(
     // onTap: () => Get.to(() => const NotificationScreen()),
      child: Container(
        height: 40,
        width: 40,
        margin: Get.size.width < 500
            ? const EdgeInsets.symmetric(horizontal: 3)
            : const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 6,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomImageView(
            imagePath: AppIcons.notification,
            color: Colors.white,
            width: 14,
          ),
        ),
      ),
    ),
  );
}
