class AddressModel {
  final int id;
  final double lat;
  final double lng;
  final bool isDefault;
  final String address;
  final String phone;
  final String addressType;
  final int userId;

  AddressModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.isDefault,
    required this.address,
    required this.phone,
    required this.addressType,
    required this.userId,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? 0,
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
      isDefault: json['isDefault'] ?? false,
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      addressType: json['addressType'] ?? '',
      userId: json['userId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'lng': lng,
      'isDefault': isDefault,
      'address': address,
      'phone': phone,
      'addressType': addressType,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'AddressModel(id: $id, lat: $lat, lng: $lng, isDefault: $isDefault, address: $address, phone: $phone, addressType: $addressType, userId: $userId)';
  }
}
