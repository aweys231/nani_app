// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/foundation.dart';

class PlaceLcation {
  final double latitude;
  final double longitude;
  final String? address;
  const PlaceLcation(
      {required this.latitude, required this.longitude,  this.address});
}

class Place {
  final String? id;
  final String? title;
  final PlaceLcation? location;
  // final File image;

  Place(
      { this.id,
       this.title,
      required this.location,
      // required this.image
      });
}
