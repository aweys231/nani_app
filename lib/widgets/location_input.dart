// ignore_for_file: sized_box_for_whitespace, implementation_imports, unnecessary_import, unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unused_element, unused_import, avoid_print, avoid_web_libraries_in_flutter, depend_on_referenced_packages, unnecessary_new, import_of_legacy_library_into_null_safe

// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:location/location.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nanirecruitment/helpers/location_helper.dart';
import 'package:nanirecruitment/screens/map_screen.dart';

import '../constants.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  String? _selectedLocation;
  void _showPreview(double lat, double lng) {
    // final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
    //   latitude: lat,
    //   longitude: lng,
    // );
    final text = 'you have selected location' ;
    setState(() {
      // _previewImageUrl = staticMapImageUrl;
      _selectedLocation = text;
    });

  }


  // Future<void> _getCurreinLoaction() async {
  //   final locData = await Location().getLocation();
  //   final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
  //       latitude: locData.latitude, longitude: locData.longitude);
  //   setState(() {
  //     _previewImageUrl = staticMapImageUrl;
  //   });
  //   // print(locData.altitude);
  //   // print(locData.longitude);
  // }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      // final coordinates = new Coordinates(locData.latitude, locData.longitude);
      // var addresses =
      //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
// first = addresses.first;
      // print(addresses.first);
      print(locData.latitude!);
      print(locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }



  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      print('locationka  la lama soo doortay');
      return;
    }
   
    print(selectedLocation.latitude.toDouble());
    
      widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude,'');
       print('locationka funtion ka waa loo pasay');
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
   
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _selectedLocation == null
              ? Text(
                  'No location choosen',
                  textAlign: TextAlign.center,
                )
              : Text(
                  _selectedLocation! ,
          )

              // : Image.network(
              //     _selectedLocation!,
              //     fit: BoxFit.cover,
              //     width: double.infinity,
              //   ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TextButton.icon(
            //   style: TextButton.styleFrom(primary: Colors.blue),
            //   icon: Icon(Icons.location_on),
            //   label: Text('Current Laction'),
            //   // textColor: Theme.of(context).primaryColor,
            //   // onPressed: _getCurreinLoaction,
            //   onPressed: _getCurrentUserLocation,
            // ),
            TextButton.icon(
              style: TextButton.styleFrom(primary: txtcolor),
              icon: Icon(Icons.map),
              label: Text('Select location on Map',
              style: TextStyle(
                color: txtcolor,
              ),
              ),
              // textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            )
          ],
        )
      ],
    );
  }
}
