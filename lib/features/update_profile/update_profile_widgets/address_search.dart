// import 'package:amazon_flutter/core/utils/dimensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';

// class AddressSearch extends StatelessWidget {
//   final GoogleMapController mapController;
//   const AddressSearch({
//     Key? key,
//     required this.mapController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    

    

    
        
//     final TextEditingController _addressC = TextEditingController();
//     return Container(
//       padding: EdgeInsets.all(Dimensions.width10),
//       child: Material(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
//         ),
//         child: SizedBox(
//           width: Dimensions.screenWidth,
//           child: TypeAheadField(
//             textFieldConfiguration: TextFieldConfiguration(
//               controller: _addressC,
//               textInputAction: TextInputAction.search,
//               autofocus: true,
//               textCapitalization: TextCapitalization.words,
//               keyboardType: TextInputType.streetAddress,
//             ),
//             onSuggestionSelected: (suggestion) {},
//             suggestionsCallback: (String pattern) {},
//             itemBuilder: (BuildContext context, Object? itemBuilder) {},
//           ),
//         ),
//       ),
//     );
//   }
// }
