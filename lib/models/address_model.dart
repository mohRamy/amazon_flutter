class AddressModel {
  late String _addressType; // مكتب او منزل
  late String?
      _contactPersonName; // الاسم الافتراضي في حين لم يسجل المستخدم اسم
  late String?
      _contactPersonNumber; // الرقم الافتراضي في حين لم يسجل المستخدم الرقم
  late String? _address; // نص الموقع
  late String? _latitude; // خطوط الطول
  late String? _longitude; // خطوط العرض

  AddressModel({
    required addressType,
    contactPersonName,
    contactPersonNumber,
    address,
    latitude,
    longitude,
  }) {
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String? get address => _address;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  AddressModel.fromjson(Map<String, dynamic> json) {
    _addressType = json['addressType'] ?? '';
    _contactPersonName = json['contactPersonName'] ?? '';
    _contactPersonNumber = json['contactPersonNumber'] ?? '';
    _address = json['address'] ?? '';
    _latitude = json['latitude'] ?? '';
    _longitude = json['longitude'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['addressType'] = _addressType;
    data['contactPersonName'] = _contactPersonName;
    data['contactPersonNumber'] = _contactPersonNumber;
    data['address'] = _address;
    data['latitude'] = _latitude;
    data['longitude'] = _longitude;
    return data;
  }
}
