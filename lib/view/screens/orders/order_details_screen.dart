import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movo_customer/theme/custom_text_style.dart';
import 'package:movo_customer/utils/constants/colors.dart';
import 'package:movo_customer/utils/constants/icon_constants.dart';
import 'package:movo_customer/view/widgets/custom_elevated_button.dart';
import 'package:movo_customer/view/widgets/custom_image_view.dart';

class TripDetailsScreen extends StatefulWidget {
  final String pickupName;
  final String pickupId;
  final String dropName;
  final String dropId;
  final String pickupLocation;
  final String dropLocation;
  final String status;
  final String vehicleType;
  final String time;
  final String cost;

  const TripDetailsScreen({
    Key? key,
    required this.pickupName,
    required this.pickupId,
    required this.dropName,
    required this.dropId,
    required this.pickupLocation,
    required this.dropLocation,
    required this.status,
    required this.vehicleType,
    required this.time,
    required this.cost,
  }) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  late GoogleMapController _mapController;

  final LatLng pickupLatLng = const LatLng(17.4336, 78.4121);
  final LatLng dropLatLng = const LatLng(17.4375, 78.4483);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEAF1),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          "Trip Details",
          style: CustomTextStyles.b2_1.copyWith(fontFamily: "Poppins"),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: CustomImageView(
              imagePath: AppIcons.download,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// MAP
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 180,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: dropLatLng,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("pickup"),
                      position: pickupLatLng,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                    ),
                    Marker(
                      markerId: const MarkerId("drop"),
                      position: dropLatLng,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                    ),
                  },
                  onMapCreated: (controller) => _mapController = controller,
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// TRIP INFO CARD
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tripHeader(),
                  const SizedBox(height: 8),
                  _pickupDropSection(),
                  const SizedBox(height: 8),
                  _statusSection(),
                  const Divider(
                    color:Color(0xff808080), // Light grey but visible
                    thickness: 1,
                    height: 16,
                  ),
                  _driverFareSection(),
                ],
              ),
            ),
            const SizedBox(height: 12),

            /// FARE DETAILS
            _fareDetailsCard(),

            const SizedBox(height: 12),

            /// PAYMENT DETAILS
            _paymentDetailsCard(),

            const SizedBox(height: 60),
          ],
        ),
      ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20), // more padding for height
          child: CustomElevatedButton(
            onPressed: () {},
            height: 50, // fixed button height
            buttonStyle: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.primary),
            ),
            text: "Book Again",
          ),
        )
    );
  }

  Widget _tripHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Yellow round timer icon
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFFFFA500), // Orange/Yellow
                shape: BoxShape.circle,
              ),
              child: CustomImageView(
                imagePath: AppIcons.timer, // Your timer icon path
                height: 14,
                width: 14,
                color: Colors.white, // Icon color
              ),
            ),
            const SizedBox(width: 12),

            // CRN and time text
            Text(
              "CRN9876543219\n${widget.time}",
              style: CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins"),
            ),
          ],
        ),

        // Stars rating
        Row(
          children: List.generate(
            5,
                (index) => const Icon(
              Icons.star,
              size: 16,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }

  Widget _pickupDropSection() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.green.shade50, shape: BoxShape.circle),
              child: CustomImageView(imagePath: AppIcons.location),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "${widget.pickupName} ${widget.pickupId}\n${widget.pickupLocation}",
                style: CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins"),
              ),
            ),
            Text("Pickup at",
                style: CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins")),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.red.shade50, shape: BoxShape.circle),
              child: CustomImageView(
                imagePath: AppIcons.location,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "${widget.dropName} ${widget.dropId}\n${widget.dropLocation}",
                style: CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins"),
              ),
            ),
            Text("Drop at",
                style: CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins")),
          ],
        ),
      ],
    );
  }

  Widget _statusSection() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            shape: BoxShape.circle,
          ),
          child: CustomImageView(imagePath: AppIcons.correct),
        ),
        const SizedBox(width: 12),
        Text(
          widget.status,
          style: CustomTextStyles.b6_3.copyWith(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: widget.status == 'Completed'
                ? Colors.green
                : Colors.orangeAccent,
          ),
        ),
      ],
    );
  }

  Widget _driverFareSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CustomImageView(
                imagePath: AppIcons.motorcycle,
                height: 20,
                width: 20,
                color: const Color(0xFF5B2C6F),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Vikas\n${widget.vehicleType} | TS-09-C 4299",
              style: CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins"),
            ),
          ],
        ),
        Text(
          widget.cost,
          style: CustomTextStyles.b3_1.copyWith(
            fontFamily: "Roboto",
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _fareDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomImageView(
                    imagePath: AppIcons.reports, // Your receipt icon path
                    height: 18,
                    width: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Fare details",
                    style: CustomTextStyles.b4_1.copyWith(fontFamily: "Poppins"),
                  ),
                ],
              ),
              CustomImageView(
                imagePath: AppIcons.download,
                height: 18,
                width: 18,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Trip Fare + discount text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trip Fare",
                    style:
                    CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins"),
                  ),
                  Text(
                    "Discount Applied of ₹50",
                    style: CustomTextStyles.b6_3.copyWith(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Text(
                "₹550",
                style: CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins"),
              ),
            ],
          ),
          _dottedDivider(),

          _fareRow("Fare Without Tax", "₹550",),
          _dottedDivider(),

          _fareRow("CGST Tax", "₹0.0"),
          _dottedDivider(),

          _fareRow("SGST Tax", "₹0.0"),
          _dottedDivider(),

          _fareRow("Rounding", "₹0.15"),
          const Divider(),

          // Total Order Fare
          _fareRow("Total Order Fare", "₹550", isBold: true),
          const SizedBox(height: 4),
          Text(
            "Incl. all taxes and charges",
            style: CustomTextStyles.b6_3.copyWith(
              fontFamily: "Poppins",
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fareRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isBold
                ? CustomTextStyles.b4_1.copyWith(fontFamily: "Poppins")
                : CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins"),
          ),
          Text(
            value,
            style: isBold
                ? CustomTextStyles.b4_1.copyWith(fontFamily: "Poppins")
                : CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins"),
          ),
        ],
      ),
    );
  }

// Custom dotted divider
  Widget _dottedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dashWidth = 4.0;
          final dashCount = (constraints.maxWidth / (2 * dashWidth)).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _paymentDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Details",
                style: CustomTextStyles.b4_1.copyWith(fontFamily: "Poppins"),
              ),
              const SizedBox(height: 4),
              Text(
                "Cash",
                style: CustomTextStyles.b6_3.copyWith(fontFamily: "Poppins"),
              ),
            ],
          ),
          Text(
            "₹550",
            style: CustomTextStyles.b4_1.copyWith(fontFamily: "Poppins"),
          ),
        ],
      ),
    );
  }

}
