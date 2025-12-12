class AddressResponse {
  final String? responseCode;
  final String? result;
  final String? responseMsg;
  final List<AddressData>? data;

  AddressResponse({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.data,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      responseCode: json['ResponseCode'] as String?,
      result: json['Result'] as String?,
      responseMsg: json['ResponseMsg'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => AddressData.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ResponseCode': responseCode,
      'Result': result,
      'ResponseMsg': responseMsg,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class AddressData {
  final String? id;
  final String? uid;
  final String? address;
  final String? landmark;
  final String? rInstruction;
  final String? aType;
  final String? aLat;
  final String? aLong;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final List<PersonAddress>? personaddress;

  AddressData({
    this.id,
    this.uid,
    this.address,
    this.landmark,
    this.rInstruction,
    this.aType,
    this.aLat,
    this.aLong,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.personaddress,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    final dynamic personAddressJson = json['personaddress'];

    List<PersonAddress> parsedPersonAddresses = [];

    if (personAddressJson is List) {
      parsedPersonAddresses = personAddressJson
          .map((e) => PersonAddress.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (personAddressJson is Map<String, dynamic>) {
      parsedPersonAddresses = [PersonAddress.fromJson(personAddressJson)];
    }

    return AddressData(
      id: json['id'] as String?,
      uid: json['uid'] as String?,
      address: json['address'] as String?,
      landmark: json['landmark'] as String?,
      rInstruction: json['r_instruction'] as String?,
      aType: json['a_type'] as String?,
      aLat: json['a_lat'] as String?,
      aLong: json['a_long'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      personaddress: parsedPersonAddresses,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'address': address,
      'landmark': landmark,
      'r_instruction': rInstruction,
      'a_type': aType,
      'a_lat': aLat,
      'a_long': aLong,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'personaddress': personaddress?.map((e) => e.toJson()).toList(),
    };
  }
}

class PersonAddress {
  final String? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? addressId;
  final String? orderId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  PersonAddress({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.addressId,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PersonAddress.fromJson(Map<String, dynamic> json) {
    return PersonAddress(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      addressId: json['address_id'] as String?,
      orderId: json['order_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'address_id': addressId,
      'order_id': orderId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}