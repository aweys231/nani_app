// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_null_comparison, depend_on_referenced_packages, library_private_types_in_public_api, unnecessary_new, avoid_print

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nanirecruitment/models/palce.dart';
import 'package:location/location.dart';




class MapScreen extends StatefulWidget {
  final PlaceLcation initialLocation;
  final bool isSelecting;

  const MapScreen({
    this.initialLocation =
        const PlaceLcation(latitude: 37.422, longitude: -122.084),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
     LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

 Location location = new Location();
 bool? _serviceEnabled;
 PermissionStatus? _permissionGranted;
 LocationData? _locationData;
 double? fieldLatitude;
 double? fieldLogitude;
var _isInit = true;
var _isLoading = false;


@override
  void initState() {
    
    super.initState();
    
  }


  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
     
     getfieldlocation().then((_){
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  Future<void> getfieldlocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    setState(() {
      fieldLatitude = _locationData?.latitude;
      fieldLogitude = _locationData?.longitude;
      print(fieldLatitude);
      print(fieldLogitude);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map here'),
          actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            ),
        ],
      ),
      body:
      _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  :
        GoogleMap(
        initialCameraPosition: 
                   CameraPosition(
          target: LatLng(
            fieldLatitude!,fieldLogitude!
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation == null
            ? {}
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLocation!,
                ),
              },
      ),
    );
  }
}
