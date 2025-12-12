import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:movo_customer/utils/constants/constants.dart';

import '../../../data/models/address_model.dart';
import '../../../utils/constants/colors.dart';
import '../../widgets/custom_app_bar.dart';
import 'add_new_address_screen.dart';

class FullMapScreen extends StatefulWidget {
  final LatLng initialLocation;
  final AddressData? address;
  final bool fromSavedAddresses;
  final bool autoOpenBottomSheet; // Changed to bool for clarity

  const FullMapScreen({
    this.fromSavedAddresses = false,
    super.key,
    required this.initialLocation,
    this.autoOpenBottomSheet = false,
    this.address,
  });

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {
  double? selectedLatitude;
  double? selectedLongitude;

  GoogleMapController? _mapController;

  late LatLng selectedLocation;
  String selectedAddress = "Fetching address...";
  Map<String, String> addressDetails = {};
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _suggestions = [];

  bool _showCustomBottomSheet = true;

  final String apiKey = AppConstants.googleApiKey;

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initialLocation;
    selectedLatitude = selectedLocation.latitude;
    selectedLongitude = selectedLocation.longitude;
    _getAddressFromLatLng(selectedLocation);

    if (widget.autoOpenBottomSheet) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _showCustomBottomSheet = true;
        });
      });
    }

    print("Initial Location: ${widget.initialLocation}");
    print("Auto open sheet: ${widget.autoOpenBottomSheet}");
  }

  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        setState(() {
          selectedAddress =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
          addressDetails = {
            "houseNumber": place.subThoroughfare ?? "",
            "street": place.thoroughfare ?? "",
            "city": place.locality ?? "",
            "state": place.administrativeArea ?? "",
            "country": place.country ?? "",
            "postalCode": place.postalCode ?? "",
            "address": selectedAddress,
          };
        });
      }
    } catch (e) {
      setState(() {
        selectedAddress = "Failed to fetch address. Tap to retry.";
        addressDetails = {};
      });
    }
  }

  Future<void> _getPlaceSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() {
        _suggestions.clear();
      });
      return;
    }

    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&components=country:in';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        _suggestions = json['predictions'];
      });
    } else {
      print("Autocomplete error: ${response.body}");
    }
  }

  Future<void> _onSuggestionTap(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final location = json['result']['geometry']['location'];
      final latLng = LatLng(location['lat'], location['lng']);

      setState(() {
        selectedLocation = latLng;
        _suggestions.clear();
        _searchController.clear();
        selectedLatitude = latLng.latitude;
        selectedLongitude = latLng.longitude;
      });

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(latLng, 15),
        );
      }

      await _getAddressFromLatLng(latLng);
      setState(() {
        _showCustomBottomSheet = true;
      });
    } else {
      print("Place details error: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Select Location",
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: selectedLocation, zoom: 15),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: {
              Marker(
                markerId: const MarkerId("selected-location"),
                position: selectedLocation,
                draggable: true,
                onDragEnd: (newPosition) {
                  setState(() {
                    selectedLocation = newPosition;
                    selectedLatitude = newPosition.latitude;
                    selectedLongitude = newPosition.longitude;
                  });
                  _getAddressFromLatLng(newPosition);
                },
              ),
            },
            onTap: (LatLng latLng) async {
              setState(() {
                selectedLocation = latLng;
                selectedLatitude = latLng.latitude;
                selectedLongitude = latLng.longitude;
              });
              await _getAddressFromLatLng(latLng);
              setState(() {
                _showCustomBottomSheet = true;
              });
            },
          ),
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search location",
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: AppColors.primary,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    ),
                    onChanged: (value) {
                      _getPlaceSuggestions(value);
                    },
                  ),
                ),
                if (_suggestions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 5)
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_suggestions[index]['description']),
                          onTap: () {
                            _onSuggestionTap(_suggestions[index]['place_id']);
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          if (_showCustomBottomSheet)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10)
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _getAddressFromLatLng(selectedLocation),
                      child: Text(
                        selectedAddress,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: () async {
                        setState(() {
                          _showCustomBottomSheet = false;
                        });
                        // Navigate to AddNewAddressScreen and wait for result
                        final result = await Get.to(() => AddNewAddressScreen(
                          latLng: selectedLocation,
                          address: selectedAddress,
                          latitude: selectedLatitude,
                          longitude: selectedLongitude,
                          addressData: widget.address,
                          id: widget.address?.id ?? "",
                          receiverName: widget.address?.personaddress?.first.name ?? "",
                          receiverPhone: widget.address?.personaddress?.first.mobile ?? "",
                          fromSavedAddresses: widget.fromSavedAddresses,
                        ));
                        // Return AddressData to AddLocation
                        if (result != null && result is AddressData) {
                          Get.back(result: result);
                        }
                      },
                      child: const Text(
                        "Confirm Location",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}