import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movo_customer/theme/app_decoration.dart';

import '../../../controllers/address_controller.dart';
import '../../../data/models/address_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/icon_constants.dart';
import '../../../utils/constants/sizes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_outlined_button.dart';
import 'full_screen_map.dart';

class SavedAddressesScreen extends StatefulWidget {
  final bool isForSelection; // <-- new flag
  final AddressData? selectedAddress;

  const SavedAddressesScreen({super.key, required this.isForSelection, this.selectedAddress});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  ///api-controller
  final AddressController addressController = Get.put(AddressController());

  String? selectedAddressId;

  @override
  void initState() {
    addressController.deleteAddress("");
    selectedAddressId = widget.selectedAddress?.id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      addressController.fetchAddresses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Saved Addresses"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  bool serviceEnabled;
                  LocationPermission permission;

                  // Check if location services are enabled
                  serviceEnabled = await Geolocator.isLocationServiceEnabled();
                  if (!serviceEnabled) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location services are disabled.')));
                    return;
                  }

                  // Check location permission
                  permission = await Geolocator.checkPermission();
                  if (permission == LocationPermission.denied) {
                    permission = await Geolocator.requestPermission();
                    if (permission == LocationPermission.denied) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location permission denied')));
                      return;
                    }
                  }

                  if (permission == LocationPermission.deniedForever) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location permission permanently denied')));
                    return;
                  }

                  // Get current position
                  try {
                    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

                    LatLng currentLatLng = LatLng(position.latitude, position.longitude);

                    Get.to(
                      () => FullMapScreen(
                        initialLocation: currentLatLng,
                        autoOpenBottomSheet: true,
                        fromSavedAddresses: true, // Explicitly set to true
                      ),
                    );
                  } catch (e) {
                    print("Failed to get location: $e");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not fetch your current location')));
                  }
                },
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text(
                        "Add new address",
                        style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              const Text('My Addresses', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,)),
              SizedBox(height: 4),
              const SizedBox(height: 8),
              GetBuilder<AddressController>(
                builder: (controller) {
                  // if(controller.isLoading){
                  //return Center(child: AppProgressIndicator());
                  // }
                  if (controller.addressList.isEmpty) {
                    return Center(child: Text("No data available"));
                  }
                  return ListView.builder(
                    itemCount: controller.addressList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final address = controller.addressList[index];
                      final addressType = address.aType?.toLowerCase().trim();
                      String iconPath;
                      switch (addressType) {
                        case 'home':
                          iconPath = AppIcons.homeOutlined;
                          break;
                        case 'office':
                          iconPath = AppIcons.workOutlined;
                          break;
                        case 'family & friends':
                          iconPath = AppIcons.friendAndFamOutlined;
                          break;
                        default:
                          iconPath = AppIcons.markerOutlined;
                      }
                      final isHome = (address.aType?.toLowerCase().trim() == "home");
                      //final iconPath = isHome ? AppIcons.homeOutlined : AppIcons.workOutlined;

                      final LatLng initialLocation = LatLng(double.tryParse(address.aLat ?? '') ?? 0.0, double.tryParse(address.aLong ?? '') ?? 0.0);
                      final isSelected = selectedAddressId == address.id;

                      return GestureDetector(
                        onTap: () {
                          if (widget.isForSelection) {
                            setState(() {
                              selectedAddressId = address.id;
                            });
                            print("address.id");
                            print(address.id);
                            Get.back(result: address); // <--- return selected address
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: AppSizes.md),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.transparent, width: 1.5),
                            boxShadow: AppDecoration.shadow1_3,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CustomImageView(imagePath: iconPath, color: AppColors.primary, height: 18, width: 18),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          address.aType?.capitalize ?? 'Address',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black, fontFamily: 'Roboto'),
                                        ),
                                        Text(
                                          '${address.personaddress?.first.name}, ${address.personaddress?.first.mobile}' ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, fontFamily: 'Roboto'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (widget.isForSelection) Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: AppColors.primary),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Divider(height: 12, color: AppColors.primary, thickness: 0.5),
                              const SizedBox(height: 4),
                              Text(
                                address.address ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, fontFamily: 'Roboto'),
                              ),
                              const SizedBox(height: AppSizes.spaceSmall,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomOutlinedButton(
                                    width: Get.size.width * 0.4,
                                    height: 32,
                                    borderRadius: BorderRadius.circular(8),
                                    text: 'Edit',
                                    leftIcon: CustomImageView(imagePath: AppIcons.edit, color: AppColors.primary, height: 20,),
                                    onPressed: () => Get.off(() => FullMapScreen(initialLocation: initialLocation, address: address, fromSavedAddresses: true)),
                                  ),
                                  const SizedBox(width: 12),
                                  CustomOutlinedButton(
                                    width: Get.size.width * 0.4,
                                    height: 32,
                                    borderRadius: BorderRadius.circular(8),
                                    text: 'Delete',
                                    leftIcon: CustomImageView(imagePath: AppIcons.delete, color: AppColors.primary, width: 16,),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  "Are you sure you want to",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 4),
                                                const Text(
                                                  "delete this address?",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 24),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    CustomOutlinedButton(
                                                      width: Get.size.width * 0.34,
                                                      height: 34,
                                                      onPressed: () => Navigator.pop(context),
                                                      text: "Cancel",
                                                      textColor: AppColors.primary,
                                                    ),
                                                    SizedBox(width: AppSizes.sm),
                                                    CustomElevatedButton(
                                                      width: Get.size.width * 0.34,
                                                      height: 34,
                                                      buttonStyle: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                                                      onPressed: () {
                                                        addressController.deleteAddress(address.id ?? "");
                                                        Navigator.pop(context);
                                                      },
                                                      text: 'Delete',
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
