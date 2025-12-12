import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controllers/address_controller.dart';
import '../../../data/models/address_model.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/icon_constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/textfield_label.dart';


class AddNewAddressScreen extends StatefulWidget {
  final LatLng latLng;
  final String address;
  final String? label;
  final String? house;
  final String? building;
  final String? landmark;
  final String? receiverName;
  final String? receiverPhone;
  final String? id;
  final AddressData? addressData;
  final bool fromSavedAddresses; // New parameter
  final double? latitude;
  final double? longitude;

  const AddNewAddressScreen({
    super.key,
    required this.latLng,
    required this.address,
    this.label,
    this.house,
    this.building,
    this.landmark,
    this.receiverName,
    this.receiverPhone,
    this.latitude,
    this.longitude,
    this.addressData,
    this.id,
    this.fromSavedAddresses = false, // Default to false (from Home),
  });

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final AddressController addressController = Get.put(AddressController());
  final TextEditingController houseController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController saveAsController = TextEditingController();

  String selectedLabel = 'Home';

  late GoogleMapController mapController;

  // Helper method to get icon based on address type
  String getAddressIcon(String? addressType) {
    final type = addressType?.toLowerCase().trim();
    switch (type) {
      case 'home':
        return AppIcons.homeOutlined;
      case 'work':
        return AppIcons.workOutlined;
      case 'family & friends':
        return AppIcons.friendAndFamOutlined;
      default:
        return AppIcons.markerOutlined;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedLabel = widget.addressData?.aType ?? 'Home';
    houseController.text = widget.addressData?.address??"";
    buildingController.text = widget.building?? "";
    landmarkController.text = widget.addressData?.landmark ?? '';
    nameController.text = widget.receiverName ?? '';
    phoneNumberController.text = widget.receiverPhone ?? '';
    if (selectedLabel == 'Others' && widget.label != null) {
      saveAsController.text = widget.label ?? '';
    }
  }



  final Map<String, Map<String, String>> labelIcons = {
    'Home': {
      'selected': AppIcons.homeOutlined,
      'unselected': AppIcons.homeOutlined,
    },
    'Work': {
      'selected': AppIcons.workOutlined,
      'unselected': AppIcons.workOutlined,
    },
    'Family & Friends': {
      'selected': AppIcons.friendAndFamOutlined,
      'unselected': AppIcons.friendAndFamOutlined,
    },
    'Others': {
      'selected':AppIcons.markerOutlined,
      'unselected': AppIcons.markerOutlined,
    },
  };

  Future<void> _openPhoneContacts() async {
    // Step 1: Check manually via flutter_contacts
    bool granted = await FlutterContacts.requestPermission();

    if (granted) {
      final Contact? contact = await FlutterContacts.openExternalPick();
      if (contact != null) {
        setState(() {
          nameController.text = contact.displayName;
          phoneNumberController.text = contact.phones.first.number;
        });
      }
    } else {
      // Confirm actual Android/iOS permission
      final status = await Permission.contacts.status;
      if (status.isPermanentlyDenied) {
        showOpenAppSettings(context);
      } else {
        AppUtils.showToastMessage("Contact permission is required.");
      }
    }
  }

  void showOpenAppSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      showDragHandle: false,
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Main modal content with rounded top corners
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// White content area
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Access Required',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'To select a contact from your phone, please enable contact access in your device settings.',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        SizedBox(height: 24),
                        CustomElevatedButton(
                          onPressed: () {
                            openAppSettings();
                          },
                          text: "Go to App Settings",
                          buttonStyle: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            /// Floating Close Button on top
            Positioned(
              top: -45,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: CustomImageView(
                  imagePath: AppIcons.clear,
                ),
                // child: const CircleAvatar(
                //   backgroundColor: Colors.white,
                //   child: Icon(Icons.close, color: AppColors.primary,),
                //   radius: 16,
                // ),
              ),
            ),
          ],
        );
      },
    );


  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    houseController.dispose();
    buildingController.dispose();
    landmarkController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    print("Building AddNewAddressScreen with selectedLabel: $selectedLabel");

    print("address details passed");
    print(widget.addressData);
    return Scaffold(
      appBar:
      CustomAppBar(title: "Enter address details",),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Mini Map
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 180,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: widget.latLng,
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('selected'),
                      position: widget.latLng,
                    ),
                  },
                  onMapCreated: (controller) => mapController = controller,
                  zoomControlsEnabled: false,
                  myLocationEnabled: false,
                  liteModeEnabled: true, // optional for lightweight map
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// Address
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.address,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.black), // Border color
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size(0, 0), // Allow compact size
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink touch area
                  ),
                  onPressed: () => Get.back(), // Go back to change location
                  child: Text(
                    "Change",
                    style: TextStyle(color: AppColors.black, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),

            Divider(color: Colors.grey.shade300, thickness: 1), // Line above address


            const SizedBox(height: 12),
            Text("Add Address", style: TextStyle(fontWeight: FontWeight.w500,fontSize:14 )),
            const SizedBox(height: 12),

            TextFieldLabel(label: "House No.& Floor",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.darkGrey),isMandatory: true,),
            CustomTextFormField(hintText: "House No.& floor",controller: houseController),
            SizedBox(height: 10,),
            TextFieldLabel(label: "Building & Block No. (Optional)",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.darkGrey),isMandatory: false,),
            CustomTextFormField(hintText: "Building,Block No",controller: buildingController),
            SizedBox(height: 10,),
            TextFieldLabel(label: "Landmark & Area name (Optional)",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.darkGrey),isMandatory: false,),
            CustomTextFormField(hintText: "Landmark & Area name",controller: landmarkController,),



            const SizedBox(height: 16),
            Text("Add Address Label", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14)),

            Wrap(
              spacing: 10,
              children: labelIcons.keys.map((label) {
                final isSelected = selectedLabel == label;
                final iconPath = isSelected
                    ? labelIcons[label]!['selected']!
                    : labelIcons[label]!['unselected']!;

                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        iconPath,
                        height: 16,
                        width: 16,
                        colorFilter: ColorFilter.mode(
                          isSelected ? AppColors.primary : Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(label),
                    ],
                  ),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedLabel = label;
                      if (label != 'Others') {
                        saveAsController.clear();
                      }
                    });
                  },
                  backgroundColor: Colors.white,
                  selectedColor: AppColors.primary.withOpacity(0.3),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : Colors.black,
                      //width: 1.5,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.primary : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
            // if(selectedLabel=="Family & Friends")...[
            // const SizedBox(height: 16),
            // Text("Receiver Details", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14)),
            // SizedBox(height: 8,),
            //
            // TextFieldLabel(label: "Receiver's Name",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.darkGrey),isMandatory: false,),
            // CustomTextFormField(
            //   hintText: "Receiver's Name",
            //   controller: nameController,
            //   suffix: CustomImageView(
            //     imagePath: AppIcons.contact,
            //     height: 20,
            //     onTap: ()=> _openPhoneContacts(),
            //   ),
            // ),
            //
            // SizedBox(height: 10,),
            //
            // TextFieldLabel(label: "Receiver's Phone Number",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.darkGrey),isMandatory: false,),
            // CustomTextFormField(hintText: "Receiver's Phone Number", controller: phoneNumberController,),
            //
            // const SizedBox(height: 20)],

            if (selectedLabel == "Family & Friends" || selectedLabel == "Others") ...[
              const SizedBox(height: 16),
              Text("Receiver Details", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              SizedBox(height: 8),
              if (selectedLabel == "Others") ...[
                TextFieldLabel(
                  label: "Save As",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.darkGrey),
                  isMandatory: true,
                ),
                CustomTextFormField(
                  hintText: "Custom Label",
                  controller: saveAsController,
                  onChanged: (value) {
                    print("Save As input: $value");
                  },
                ),
                SizedBox(height: 10),
              ],
              TextFieldLabel(
                label: "Receiver's Name",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.darkGrey),
                isMandatory: false,
              ),
              CustomTextFormField(
                hintText: "Receiver's Name",
                controller: nameController,
                suffix: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                  child: CustomImageView(
                    imagePath: AppIcons.contact,
                    height: 16,
                    width: 16,
                    onTap: () => _openPhoneContacts(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFieldLabel(
                label: "Receiver's Phone Number",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.darkGrey),
                isMandatory: false,
              ),
              CustomTextFormField(hintText: "Receiver's Phone Number", controller: phoneNumberController),
              const SizedBox(height: 20),
            ],


            // CustomElevatedButton(
            //     text: "Save Address",
            //     buttonStyle:  ButtonStyle(
            //         backgroundColor: WidgetStateProperty.all(AppColors.primary)),
            //     onPressed: () async{
            //       // You can collect and send this data to your backend
            //       final Map<String, dynamic> body = {
            //         "id":widget.id??"",
            //         "lats": widget.latitude,
            //         "longs": widget.longitude,
            //         "address": "${houseController.text},${buildingController.text}",
            //         "landmark": landmarkController.text,
            //         "r_instruction": "hjk",
            //         "a_type": selectedLabel,
            //         "name": nameController.text,
            //         "mobile": phoneNumberController.text
            //
            //       };
            //
            //       // Save or pass back
            //       print(body);
            //      await addressController.addAddress(body);
            //     },
            // )

            CustomElevatedButton(
              text: "Save Address",
              buttonStyle:  ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.primary)),
              // onPressed: () async{
              //   // You can collect and send this data to your backend
              //   final Map<String, dynamic> body = {
              //     "lats": widget.latitude,
              //     "longs": widget.longitude,
              //     "address": "${houseController.text},${buildingController.text}",
              //     "landmark": landmarkController.text,
              //     "r_instruction": "hjk",
              //     "a_type": selectedLabel,
              //     "id":widget.id??""
              //   };
              //
              //   // Save or pass back
              //   print(body);
              //  await addressController.addAddress(body,fromSavedAddresses:widget.fromSavedAddresses);
              // },

              onPressed: () async {
                // 1️⃣ Build request body
                final Map<String, dynamic> body = {
                  "lats": widget.latitude ?? widget.latLng.latitude,
                  "longs": widget.longitude ?? widget.latLng.longitude,
                  "address": "${houseController.text}, ${buildingController.text}",
                  "landmark": landmarkController.text,
                  "r_instruction": "hjk",
                  "a_type": selectedLabel,
                  "id": widget.id ?? "",
                };

                print(body);

                // 2️⃣ Add address using your controller method
                await addressController.addAddress(body,fromSavedAddresses: true);

                // 3️⃣ OPTIONAL: fetch updated addresses to ensure list is fresh
                await addressController.fetchAddresses();

                // 4️⃣ Find the newly added address
                final newAddress = addressController.addressList.last;

                // 5️⃣ Update LocationController
                // final locationController = Get.find<LocationController>();
                // locationController.setSelectedAddress(
                //   newAddress.address ?? '',
                //   newAddress.aType ?? 'Other',
                //   getAddressIcon(newAddress.aType),
                //   LatLng(
                //     double.tryParse(newAddress.aLat ?? '0') ?? widget.latLng.latitude,
                //     double.tryParse(newAddress.aLong ?? '0') ?? widget.latLng.longitude,
                //   ),
                // );

                // ✅ Pop until Saved Address Screen
                // Get.until((route) => Get.currentRoute == '/SavedAddressScreen');

                // 6️⃣ Pass it back to Instant Cart screen
                Get.back(result: newAddress);
              },

            )
          ],
        ),
      ),
    );
  }
}