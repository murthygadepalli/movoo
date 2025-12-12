import 'package:get/get.dart';
import '../data/models/address_model.dart';

class AddressController extends GetxController{
  bool isLoading = false;
  AddressResponse? addressResponse;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses(); // or wherever you load the addresses
  }
  RxList<AddressData> filteredAddressList = <AddressData>[].obs;

  List<AddressData> get addressList => addressResponse?.data ?? [];

  // 🔍 Search method
  void searchAddress(String query) {
    final allAddresses = addressList; // always get fresh list from model

    if (query.trim().isEmpty) {
      filteredAddressList.value = allAddresses;
    } else {
      filteredAddressList.value = allAddresses.where((address) {
        final searchText = query.toLowerCase();
        final addr = address.address?.toLowerCase() ?? '';
        final type = address.aType?.toLowerCase() ?? '';
        return addr.contains(searchText) || type.contains(searchText);
      }).toList();
    }
  }

  ///To fetch address
  Future<void> fetchAddresses() async {
    // isLoading = true;
    // update();
    //
    // log('🔑 token : ${getData.read('token')}');
    // log("🔄 Fetching addresses from endpoint: ${Config.address}");
    //
    // try {
    //   String url = Config.baseUrl + Config.address;
    //   var val = await ApiService.getRequest(url);
    //
    //   if (val != null && val.isNotEmpty && val["ResponseCode"] == "200") {
    //     try {
    //       addressResponse = AddressResponse.fromJson(val);
    //       filteredAddressList.value = addressList; // Copy all to show by default
    //       log("✅ Addresses loaded successfully");
    //     } catch (e) {
    //       log("⛔ Parsing error: $e");
    //       AppUtils.showToastMessage('Error parsing address data');
    //     }
    //   } else {
    //     log("❌ API response is empty or unsuccessful");
    //     AppUtils.showToastMessage(val["ResponseMsg"] ?? 'No addresses found');
    //   }
    // } catch (e, stackTrace) {
    //   log("❌ Exception during fetch: $e");
    //   // AppUtils.showToastMessage('Something went wrong! Please try again.');
    // } finally {
    //   isLoading = false;
    //   update();
    // }
    addressResponse = AddressResponse.fromJson({
      "ResponseCode": "200",
      "Result": "true",
      "ResponseMsg": "Address list fetched successfully",
      "data": [
        {
          "id": "101",
          "uid": "5001",
          "address": "123 Main Street, Springfield",
          "landmark": "Near City Mall",
          "r_instruction": "Ring the doorbell twice",
          "a_type": "Home",
          "a_lat": "37.7749",
          "a_long": "-122.4194",
          "createdAt": "2025-08-17T10:30:00Z",
          "updatedAt": "2025-08-17T12:00:00Z",
          "deletedAt": null,
          "personaddress": [
            {
              "id": "1",
              "name": "John Doe",
              "email": "john.doe@example.com",
              "mobile": "+1234567890",
              "address_id": "101",
              "order_id": "7001",
              "createdAt": "2025-08-17T10:35:00Z",
              "updatedAt": "2025-08-17T11:15:00Z",
              "deletedAt": null
            },
            {
              "id": "2",
              "name": "Jane Smith",
              "email": "jane.smith@example.com",
              "mobile": "+0987654321",
              "address_id": "101",
              "order_id": "7002",
              "createdAt": "2025-08-17T10:40:00Z",
              "updatedAt": "2025-08-17T11:20:00Z",
              "deletedAt": null
            }
          ]
        },
        {
          "id": "102",
          "uid": "5002",
          "address": "456 Park Avenue, Metropolis",
          "landmark": "Opposite Central Park",
          "r_instruction": "Call before reaching",
          "a_type": "Office",
          "a_lat": "40.7128",
          "a_long": "-74.0060",
          "createdAt": "2025-08-15T09:00:00Z",
          "updatedAt": "2025-08-16T14:30:00Z",
          "deletedAt": null,
          "personaddress": {
            "id": "3",
            "name": "Alice Johnson",
            "email": "alice.j@example.com",
            "mobile": "+1122334455",
            "address_id": "102",
            "order_id": "7003",
            "createdAt": "2025-08-15T09:05:00Z",
            "updatedAt": "2025-08-16T13:45:00Z",
            "deletedAt": null
          }
        }
      ]
    }
    );

  }

  ///To Add Address
  Future<void> addAddress(Map<String, dynamic>? body,{bool fromSavedAddresses = false}) async{
    // isLoading = true;
    // update();
    // log('🔑 token : ${getData.read('token')}');
    // log("🔄 Adding addresses from endpoint: ${Config.address}");
    //
    // try{
    //   var response = await ApiService.postRequest(
    //       Config.baseUrl + Config.address,
    //       body!
    //   );
    //   if(response!=null && response['Result'] == "true"){
    //     AppUtils.showToastMessage("✅ Address added successfully!");
    //     fetchAddresses();
    //     if (fromSavedAddresses) {
    //       Get.back(); // Navigate to SavedAddressesScreen
    //     } else {
    //       Get.offAll(() => HomeScreen()); // Navigate to HomeScreen
    //     }
    //   }
    //   else{
    //     AppUtils.showToastMessage(response?['ResponseMsg'] ?? "Failed to add address");
    //   }
    // }
    // catch(e, stackTrace){
    //   // AppUtils.showToastMessage("Something went wrong");
    //   // log("❌ Error in posting address: $e");
    // }
    // finally {
    //   isLoading = false;
    //   update();
    // }
  }


  ///To delete Address
  Future<void> deleteAddress(String? addressId) async{
    // try{
    //   final token = await getData.read('token');
    //   final url = Config.baseUrl + Config.deleteAddress(addressId??"");
    //   log(url);
    //   final response = await http.delete(
    //       Uri.parse(url),
    //       headers:{
    //         'Authorization': 'Bearer $token',
    //         'Content-Type': 'application/json',
    //       }
    //   );
    //   if(response.statusCode == 200){
    //     addressList.removeWhere((element) => element.id == addressId);
    //     AppUtils.showToastMessage("Address deleted successfully");
    //     fetchAddresses();
    //   }
    //   else{
    //     print("Failed to delete address");
    //   }
    // }catch(e){
    //   AppUtils.showToastMessage("Something went wrong");
    //   log("Exception $e");
    // }
  }
}