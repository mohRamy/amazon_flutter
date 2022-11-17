import 'package:amazon_flutter/core/utils/components/components.dart';
import 'package:amazon_flutter/core/widgets/custom_button.dart';
import 'package:amazon_flutter/features/address/address_ctrl/address_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dimensions.dart';

class PickAddressMap extends StatefulWidget {
  const PickAddressMap({super.key});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

const kGoogleApiKey = "AIzaSyAj2MKle2E-Z-ZeWlqr3m_d0h5usgTEzg4";
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _PickAddressMapState extends State<PickAddressMap> {
  late GoogleMapController _mapController;

  Set<Marker> markersList = {};

  final Mode _mode = Mode.overlay;

  String _address = '';
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressCtrl>(
      builder: (addressCtrl) {
        _address =
            '${addressCtrl.placemark.value.administrativeArea ?? ''}${addressCtrl.placemark.value.locality ?? ''}${addressCtrl.placemark.value.street ?? ''}${addressCtrl.placemark.value.postalCode ?? ''}';
        return Scaffold(
          key: homeScaffoldKey,
          body: Stack(
            children: [
              GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: addressCtrl.initPosition,
                  zoom: 17.0,
                ),
                markers: markersList,
                onTap: (latLng) {
                  markersList.clear();
                  markersList.add(
                    Marker(
                      markerId: const MarkerId('0'),
                      position: LatLng(latLng.latitude, latLng.longitude),
                    ),
                  );
                  setState(() {});
                },
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) =>
                    _mapController = controller,
                zoomControlsEnabled: true,
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
                  addressCtrl.updatePosition(addressCtrl.initPosition, true);
                },
              ),
              // Center(
              //   child: addressCtrl.loading
              //       ? const CustomLoader()
              //       : Image.asset(
              //           'assets/images/maps_marker.jpg',
              //           width: 100,
              //           height: 100,
              //         ),
              // ),
              Positioned(
                top: Dimensions.height45 + 40,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: InkWell(
                  onTap: () => _handlePressButton(),
                  // Get.dialog(AddressSearch(mapController: _mapController)),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius20 / 2),
                    ),
                    child: GetBuilder<AddressCtrl>(builder: (addressCtrl) {
                      return Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 25,
                            color: AppColors.yellowColor,
                          ),
                          SizedBox(
                            width: Dimensions.width20,
                          ),
                          Expanded(
                            child: Text(
                              _address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font16 + 2,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.width10),
                          Icon(Icons.search,
                              size: 25, color: AppColors.yellowColor),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                right: Dimensions.width20,
                left: Dimensions.width20,
                child: CustomButton(
                  buttomText: 'Pick address',
                  onPressed: addressCtrl.loading
                      ? null
                      : () {
                          if (_address.isNotEmpty) {
                            Get.back();
                          }
                        },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    Components.showCustomSnackBar(response.errorMessage!);
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [''],
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        components: [
          Component(
            Component.country,
            'pk',
          ),
        ]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(
      Marker(
        markerId: const MarkerId('0'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: detail.result.name,
        ),
      ),
    );
    setState(() {});

    _mapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 17));
  }
}
