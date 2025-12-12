import 'package:flutter/material.dart';
import 'package:movo_customer/theme/custom_text_style.dart';
import 'package:movo_customer/view/screens/home/select_vehicle_screen.dart';
import 'package:movo_customer/view/widgets/custom_image_view.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/icon_constants.dart';
import '../account/account_screen.dart';
import '../orders/orders_screen.dart';
import '../wallets/add_wallet_screen.dart';
import 'add_stops_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomeContent(),
      OrdersScreen(),// index 0
      Center(child: Text("Coins Screen")), // index 2
      WalletScreen(),
      AccountScreen()// index 3
    ];

    return Scaffold(
      backgroundColor:  Color(0xffEFEAF1),
      body: SafeArea(
        child: pages[_selectedIndex], // ✅ show content based on index
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  /// Extracted original home UI into a separate widget
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Location dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: CustomImageView(imagePath: AppIcons.location),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Pickup at", style: CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins")),
                      const SizedBox(height: 2),
                      Text(
                        "N 30 - Dubai International, 120 mi",
                        style: CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins"),
                      ),
                    ],
                  ),
                ),
                CustomImageView(imagePath: AppIcons.arrowDown),
              ],
            ),
          ),
          const SizedBox(height: 16),

          /// 2 Wheelers card
          _buildOptionCard(AppIcons.bike, "2 Wheelers"),
          const SizedBox(height: 12),

          /// Trucks card
          _buildOptionCard(AppIcons.car, "Trucks"),
          const SizedBox(height: 12),

          /// Rewards banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF5B2C6F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CustomImageView(imagePath: AppIcons.rewards, height: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Explore movo Rewards\nEarn 2 Coins for every 1000 spent",
                    style: CustomTextStyles.b4_1.copyWith(
                      fontFamily: "Poppins",
                      color: AppColors.white,
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: AppIcons.arrowForward,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildBottomNavBar() {
    final items = [
      {'icon': AppIcons.homeOutlined, 'activeIcon': AppIcons.home, 'label': 'Home'},
      {'icon': AppIcons.orderoutlined, 'activeIcon': AppIcons.orders, 'label': 'Orders'},
      {'icon': AppIcons.coinsOutlined, 'activeIcon': AppIcons.coinsOutlined, 'label': 'Coins'},
      {'icon':AppIcons.walletoutlined, 'activeIcon': AppIcons.walletoutlined, 'label': 'Wallet'},
      {'icon': AppIcons.profileOutlined, 'activeIcon': AppIcons.profile, 'label': 'Account'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            behavior: HitTestBehavior.translucent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 isSelected
                    ? CustomImageView(imagePath: items[index]['activeIcon'] as String, height: 26)
                    : CustomImageView(imagePath: items[index]['icon'] as String, height: 26),
                const SizedBox(height: 4),
                Text(
                  items[index]['label'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: isSelected ? const Color(0xFF5B2C6F) : Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                if (isSelected)
                  Container(
                    height: 3,
                    width: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBE6F3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  )
                else
                  const SizedBox(height: 3),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// Card widget for options
  /// Card widget for options
  Widget _buildOptionCard(String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) =>  MultiStopScreen()),
        );
      },
      child: Container(
        height: 88,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 50), // left gap before image
            CustomImageView(imagePath: imagePath),
            const SizedBox(width: 70), // gap between image & text
            Expanded(
              child: Text(
                title,
                style: CustomTextStyles.b4_1.copyWith(fontFamily: "Poppins"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CustomImageView(imagePath: AppIcons.arrowForward),
            ),
          ],
        ),
      ),
    );
  }
}
