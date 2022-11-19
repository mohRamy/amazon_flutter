import 'dart:async';

import 'package:amazon_flutter/config/routes/app_pages.dart';
import 'package:amazon_flutter/features/admin/admin_screens/orders_screen.dart';
import 'package:amazon_flutter/features/order/order_screen/order_screen.dart';

import '../../../core/utils/components/components.dart';
import '../../../controller/user_controller.dart';
import '../../../core/widgets/custom_button.dart';
import '../../auth/auth_ctrl/auth_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/big_text.dart';
import '../address_ctrl/address_ctrl.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  AuthCtrl authCtrl = Get.find<AuthCtrl>();
  UserCtrl userCtrl = Get.find<UserCtrl>();
  AddressCtrl addressCtrl = Get.find<AddressCtrl>();

  late bool _isLogged; // للتأكد من تسجيل الدخول

  // late LatLng _initPosition = const LatLng(43.896236,
  //     -16.937405); // احداثيات الموقع توضع بدل الثوابت في المتغير اعلاه

  bool _isPosition = false;
  Future getPosition() async {
    bool services;
    LocationPermission per;

    services = await Geolocator.isLocationServiceEnabled();

    if (services == false) {
      Components.showCustomSnackBar("Services Not Enabled");
    }

    per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }

    if (per != LocationPermission.denied) {
      var position = await Geolocator.getCurrentPosition();

      setState(() {
        addressCtrl.initPosition =
            LatLng(position.latitude, position.longitude);
        _isPosition = true;
      });
    }
  }

  @override
  void initState() {
    getPosition();
    _isLogged = authCtrl.userLoggedIn();
    if (_isLogged && userCtrl.user == null) {
      authCtrl.getUserData();
    }
    if (userCtrl.user.name.isNotEmpty) {
      addressCtrl.nameC.text = userCtrl.user.name;
    }
    if (userCtrl.user.phone.isNotEmpty) {
      addressCtrl.phoneC.text = userCtrl.user.phone;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserCtrl>(
        builder: (userCtrl) {
          return GetBuilder<AddressCtrl>(
            builder: (addressCtrl) {
              addressCtrl.addressC.text =
                  '${addressCtrl.placemark.value.administrativeArea ?? ''}${addressCtrl.placemark.value.locality ?? ''}${addressCtrl.placemark.value.street ?? ''}${addressCtrl.placemark.value.postalCode ?? ''}';
              return Column(
                children: [
                  Container(
                    height: 160,
                    width: Dimensions.screenWidth,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: AppColors.mainColor,
                      ),
                    ),
                    child: _isPosition != false
                        ? GoogleMap(
                            mapType: MapType.hybrid,
                            initialCameraPosition: CameraPosition(
                              target: addressCtrl.initPosition,
                              zoom: 17.0,
                            ),
                            onTap: (latLng) {
                              Get.toNamed(
                                Routes.PICK_ADDRESS,
                              );
                            },
                            myLocationEnabled: true,
                            onMapCreated: (GoogleMapController controller) =>
                                addressCtrl.setMapController(controller),
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            onCameraMove: ((position) {
                              addressCtrl.initPosition = LatLng(
                                position.target.latitude,
                                position.target.longitude,
                              );
                            }),
                            onCameraIdle: () {
                              addressCtrl.updatePosition(
                                  addressCtrl.initPosition, true);
                            },
                          )
                        : Container(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      child: ListView(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Dimensions.height45 + 5,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: addressCtrl.addressTypeList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        addressCtrl.setAddressTypeIndex(index);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width20,
                                            vertical: Dimensions.height10),
                                        margin: EdgeInsets.only(
                                            right: Dimensions.width10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20 / 4),
                                          color: Theme.of(context).cardColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[200]!,
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          index == 0
                                              ? Icons.home_filled
                                              : index == 1
                                                  ? Icons.work
                                                  : Icons.location_on,
                                          color: addressCtrl.addressTypeIndex ==
                                                  index
                                              ? AppColors.mainColor
                                              : Theme.of(context).disabledColor,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(height: Dimensions.height20),
                            BigText(
                              text: 'Delivery Address',
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            AppTextField(
                              textContainer: addressCtrl.addressC,
                              hintText: 'Your address',
                              icon: Icons.map,
                            ),
                            SizedBox(height: Dimensions.height20),
                            BigText(
                              text: 'Delivery Name',
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            AppTextField(
                              textContainer: addressCtrl.nameC,
                              hintText: 'Your name',
                              icon: Icons.map,
                            ),
                            SizedBox(height: Dimensions.height20),
                            BigText(
                              text: 'Delivery Phone',
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            AppTextField(
                              textContainer: addressCtrl.phoneC,
                              hintText: 'Your Phone',
                              icon: Icons.map,
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<AddressCtrl>(builder: (addressCtrl) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.height20 * 8,
              padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                right: Dimensions.width20,
                left: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 200,
                    height: 80,
                    radius: Dimensions.radius20,
                    fontSize: Dimensions.font20,
                    buttomText: 'Save Address',
                    onPressed: addressCtrl.loading
                        ? null
                        : () {
                            if (addressCtrl.addressC.text.isNotEmpty) {
                              addressCtrl.saveUserAddress(
                                addressCtrl.addressC.text,
                                addressCtrl.nameC.text,
                                addressCtrl.phoneC.text,
                              );
                              Get.back();
                            }
                          },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
