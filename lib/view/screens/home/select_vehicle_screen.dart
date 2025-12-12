import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../theme/custom_text_style.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/icon_constants.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_outlined_button.dart';

class SelectVehicleScreen extends StatefulWidget {
  const SelectVehicleScreen({Key? key}) : super(key: key);

  @override
  State<SelectVehicleScreen> createState() => _SelectVehicleScreenState();
}

class _SelectVehicleScreenState extends State<SelectVehicleScreen> {
  int selectedIndex = 1; // Default: Pickup 8ft

  final vehicles = [
    {"name": "14ft", "weight": "3520kgs", "time": "26 mins", "price": "₹220", "image": "assets/icons/truck1.svg"},
    {"name": "Pickup 8ft", "weight": "6000kgs", "time": "26 mins", "price": "₹220", "image": "assets/icons/truck2.svg"},
    {"name": "10ft", "weight": "4500kgs", "time": "22 mins", "price": "₹180", "image": "assets/icons/truck1.svg"},
    {"name": "12ft", "weight": "5000kgs", "time": "24 mins", "price": "₹200", "image": "assets/icons/truck2.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEAF1),
      appBar: AppBar(
        title: const Text("Select Vehicle", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Pickup & Drop Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _locationRow(Icons.location_on, Colors.green,
                                "Suresh Pyla .9876543218",
                                "E 11 - Sheikh Zayed Road, 347 mi"),
                            const SizedBox(height: 8),
                            _locationRow(Icons.location_on, Colors.red,
                                "Akhil Diddi .8876543218",
                                "DXB - Dubai International Airport, 5 mi"),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          Icons.swap_vert,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: CustomOutlinedButton(
                          text: "Add Stop",
                          buttonTextStyle: CustomTextStyles.b6_3.copyWith(
                            fontFamily: "Poppins",
                            color: AppColors.primary,
                          ),
                          leftIcon: CustomImageView(
                            imagePath: AppIcons.add,
                            color: AppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          height: 36,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomElevatedButton(
                          text: "Edit Location",
                          buttonTextStyle: CustomTextStyles.b6_3.copyWith(
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                          leftIcon: CustomImageView(
                            imagePath: AppIcons.editprofile,
                            color: Colors.white,
                          ),
                          height: 36,
                          onPressed: () {},
                          buttonStyle: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(AppColors.primary),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Recommended
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Recommended", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),

            /// Vehicle List
      Expanded(
        child: ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 12),
                height: isSelected ? 120 : 70,
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                    colors: [Color(0xFF5B2C6F), Color(0xFFCCBED2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  color: isSelected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                    width: 1.2,
                  ),
                ),
                child: isSelected
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 8),
                    SvgPicture.asset(vehicle["image"]!, height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle["name"]!,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${vehicle["weight"]} • ${vehicle["time"]}",
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            vehicle["price"]!,
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
                    : Row(
                  children: [
                    const SizedBox(width: 12),
                    SvgPicture.asset(vehicle["image"]!, height: 20),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          vehicle["name"]!,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${vehicle["weight"]} • ${vehicle["time"]}",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        vehicle["price"]!,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
          ],
        ),
      ),

      /// Bottom Proceed Button
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {},
            child: const Text("Proceed", style: TextStyle(fontFamily: "Poppins", color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _locationRow(IconData icon, Color color, String title, String subtitle) {
    return Row(
      children: [
        CircleAvatar(radius: 12, backgroundColor: color.withOpacity(0.1), child: Icon(icon, size: 14, color: color)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.w500)),
              Text(subtitle, style: const TextStyle(fontFamily: "Poppins", fontSize: 12, color: Colors.grey)),
            ],
          ),
        )
      ],
    );
  }
}
