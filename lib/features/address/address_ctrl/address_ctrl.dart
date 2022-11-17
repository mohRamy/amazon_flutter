import 'dart:convert';

import 'package:amazon_flutter/core/utils/app_colors.dart';

import '../../../core/utils/components/components.dart';
import '../../../controller/user_controller.dart';
import '../../../models/user_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/constants/error_handling.dart';
import '../address_repo/address_repo.dart';

class AddressCtrl extends GetxController implements GetxService {
  final AddressRepo addressRepo;
  AddressCtrl({
    required this.addressRepo,
  });

  late LatLng initPosition = const LatLng(43.896236, -16.937405);

  bool _loading = false;
  bool get loading => _loading;
  late Position _position; //  لتحديد الموقع على الخريطة بدون نقر تحريك فقط
  Position get position => _position;
  // late Position _pickPosition; // تحديد الموقع على الخريطة بعد النقر
  // Position get pickPosition => _pickPosition;
  Rx<Placemark> _placemark =
      Rx(Placemark()); // للعلامات العامة مثل المنتزهات والمقاهي
  Rx<Placemark> get placemark => _placemark;
  // Placemark _pickPlacemark = Placemark(); // للعلامات التي اضعها انا
  // Placemark get pickPlacemark => _pickPlacemark;
  // List<AddressModel> _addressList = []; // معلومات عن العنوان وصاحبه عنوان واحد
  // List<AddressModel> get addressList => _addressList;
  // late List<AddressModel> _allAddressList = []; // حفظ كل معلومات جميع العناوين
  final List<String> _addressTypeList = [
    'home',
    'office',
    'others'
  ]; // قائمة نوع العنوان
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0; // home لفهرس قائمة العنوان هنا صفر يشير الى
  int get addressTypeIndex => _addressTypeIndex;
  // late Map<String, dynamic> _getAddress; // لأنه يكون في قاعدة البيانات addressModel.fromjson لجلب العنوان ويكون على شكل
  // Map<String, dynamic> get getAddress => _getAddress;

  // late GoogleMapController _mapControlle;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  // bool _udpateAddressData = true;
  // bool _changeAddress = true;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(LatLng cPosition, bool fromAddress) async {
    // if (_udpateAddressData) {
    _loading = true;
    update();
    try {
      if (fromAddress) {
        _position = Position(
          longitude: cPosition.longitude,
          latitude: cPosition.latitude,
          timestamp: DateTime.now(),
          accuracy: 1,
          altitude: 1,
          heading: 1,
          speed: 1,
          speedAccuracy: 1,
        );
      }
      
      var geocoder = GeocodingPlatform.instance;
      final coordinates = await geocoder.placemarkFromCoordinates(
        cPosition.latitude,
        cPosition.longitude,
      );
      var address = coordinates.first;
      _placemark.value = address;
      _loading = false;
      update();
    } catch (e) {
      print(e);
    }
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  void saveUserAddress(String address) async {
    UserCtrl userCtrl = Get.find<UserCtrl>();
    try {
      http.Response res = await addressRepo.saveUserAddress(address);

      httpErrorHandle(
        res: res,
        onSuccess: () {
          UserModel user = userCtrl.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );
          userCtrl.setUserFromModel(user);
          // Get.back();
          Components.showCustomSnackBar(
            "Address Added Successfully",
            color: AppColors.mainColor,
          );
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }
}
