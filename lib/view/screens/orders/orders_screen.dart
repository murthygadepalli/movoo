import 'package:flutter/material.dart';
import 'package:movo_customer/theme/custom_text_style.dart';
import 'package:movo_customer/utils/constants/colors.dart';
import 'package:movo_customer/utils/constants/icon_constants.dart';
import 'package:movo_customer/view/widgets/custom_elevated_button.dart';
import 'package:movo_customer/view/widgets/custom_image_view.dart';

import 'order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const Color kPrimary = Color(0xFF5B2C6F);
  static const Color kLightPurple = Color(0xFFF5F1F8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFEAF1),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Orders',
              style: CustomTextStyles.b2_1.copyWith(
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Past Orders',
              style: CustomTextStyles.b4_1.copyWith(
                fontFamily: "Poppins",
              ),
            ),
            const SizedBox(height: 16),
            _buildOrderCard(
              context: context,
              pickupName: 'Suresh Pyla',
              pickupId: '9876543218',
              dropName: 'Akhil Diddi',
              dropId: '8876543218',
              pickupLocation: 'E 11 - Sheikh Zayed Road, 347 mi',
              dropLocation: 'DXB - Dubai International Airport, 5 mi',
              status: 'Completed',
              vehicleType: '2 Wheeler',
              time: '03 Aug 2025, 03:35 PM',
              cost: '₹1250',
            ),
            const SizedBox(height: 16),
            _buildOrderCard(
              context: context,
              pickupName: 'Suresh Pyla',
              pickupId: '9876543218',
              dropName: 'Akhil Diddi',
              dropId: '8876543218',
              pickupLocation: 'E 11 - Sheikh Zayed Road, 347 mi',
              dropLocation: 'DXB - Dubai International Airport, 5 mi',
              status: 'Completed',
              vehicleType: '4 Wheeler',
              time: '03 Aug 2025, 03:35 PM',
              cost: '₹1250',
            ),
            const SizedBox(height: 16),
            _buildOrderCard(
              context: context,
              pickupName: 'Maya Singh',
              pickupId: '1234567890',
              dropName: 'Ravi Kumar',
              dropId: '2234567890',
              pickupLocation: 'N 45 - Marina Mall, 12 mi',
              dropLocation: 'DXB - Al Maktoum International Airport, 18 mi',
              status: 'In Progress',
              vehicleType: '4 Wheeler',
              time: '03 Aug 2025, 03:35 PM',
              cost: '₹1250',
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 1,
      //   selectedItemColor: kPrimary,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.reorder), label: 'Orders'),
      //     BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: 'Coins'),
      //     BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
      //   ],
      // ),
    );
  }

  Widget _buildOrderCard({
    required String pickupName,
    required String pickupId,
    required String dropName,
    required String dropId,
    required String pickupLocation,
    required String dropLocation,
    required String status,
    required String vehicleType,
    required String time,
    required String cost,
    required BuildContext context,

  }) {
    return InkWell(
        onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TripDetailsScreen(
            pickupName: pickupName,
            pickupId: pickupId,
            dropName: dropName,
            dropId: dropId,
            pickupLocation: pickupLocation,
            dropLocation: dropLocation,
            status: status,
            vehicleType: vehicleType,
            time: time,
            cost: cost,
          ),
        ),
      );
    },
    child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.06),
    blurRadius: 8,
    offset: const Offset(0, 2),
    ),
    ],
    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pickup + Drop Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pickup
                    Row(
                      children: [
                Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),

                child: CustomImageView(
                          imagePath: AppIcons.location,
                        )),

                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$pickupName  .$pickupId",
                                style: CustomTextStyles.b6_3.copyWith(
                                  fontFamily: "Inter",

                                ),
                              ),
                              SizedBox(height: 2,),
                              Text(
                                pickupLocation,
                                style: CustomTextStyles.b6_3.copyWith(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Drop
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            shape: BoxShape.circle,
                          ),

                         child:  CustomImageView(
                          imagePath: AppIcons.location,
                          color: Colors.red,
                        )),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$dropName  .$dropId",
                                style: CustomTextStyles.b6_3.copyWith(
                                  fontFamily: "Inter",

                                ),
                              ),
                              SizedBox(height: 2,),
                              Text(
                                dropLocation,
                                style: CustomTextStyles.b6_3.copyWith(
                                  fontFamily: "Inter",
                                fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Pickup/Drop labels
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Pickup at',
                    style: CustomTextStyles.b6_3.copyWith(
                      fontFamily: "Inter",

                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Drop at',
                    style: CustomTextStyles.b6_3.copyWith(
                      fontFamily: "Inter",

                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Status
          Row(
            children: [Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: CustomImageView(
                imagePath: AppIcons.correct,
              )),

              const SizedBox(width: 6),
              Text(
                status,
                style: CustomTextStyles.b6_3.copyWith(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  color: status == 'Completed' ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          const Divider(height: 1, thickness: 1, color: Colors.grey),
          const SizedBox(height: 8),

          // Vehicle & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          spreadRadius: 2
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: vehicleType == '2 Wheeler'
                        ? CustomImageView(
                      imagePath: AppIcons.motorcycle,
                      height: 20,
                      width: 20,
                      color: const Color(0xFF5B2C6F),
                    )
                        : CustomImageView(
                      imagePath: AppIcons.fourwheeler,
                      height: 20,
                      width: 20,
                      color: const Color(0xFF5B2C6F),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicleType,
                        style: CustomTextStyles.b6_3.copyWith(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                        ),
                      ),
                      Text(
                        time,
                        style: CustomTextStyles.b6_3.copyWith(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w400

                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                cost,
                style: CustomTextStyles.b3_1.copyWith(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Button
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              onPressed: () {},
              height: 35,
              buttonStyle: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.primary)
              ),
              buttonTextStyle: CustomTextStyles.b6_1.copyWith(
                color: AppColors.white,
                fontFamily: "Poppins"


              ),

              text:
                'Book Again',

            ),
          ),
        ],
      ),
    ));
  }

}