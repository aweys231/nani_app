// ignore_for_file: unused_local_variable, unused_import, prefer_final_fields, dead_code, avoid_print, use_rethrow_when_possible, prefer_const_declarations, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:nanirecruitment/helpers/db_helper.dart';
import 'package:nanirecruitment/models/palce.dart';
import '../helpers/location_helper.dart';
import 'dart:io';

import '../services/api_urls.dart';

class GreatPlaces with ChangeNotifier {
  List<Place?> _items = [];
  List<Place?> get items {
    return [..._items];
  }

  Place? findById(String? id) {
    return _items.firstWhere((place) => place?.id == id);
  }
//  Future<void> addPlace(
//     // String pickedTitle,
//     // File pickedImage,
//     PlaceLcation pickedLocation,
//   ) async {
//     final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
//     final updatedLocation = PlaceLcation(
//       latitude: pickedLocation.latitude,
//       longitude: pickedLocation.longitude,
//       address: address,
//     );
//     final newPlace = Place(
//       // id: DateTime.now().toString(),
//       // image: pickedImage,
//       // title: pickedTitle,
//       location: updatedLocation,
//     );
//     _items.add(newPlace);
//     notifyListeners();
//     DBHelper.insert('user_places', {
//       // 'id': newPlace.id,
//       // 'title': newPlace.title,
//       // 'image': newPlace.image.path,
//       'loc_lat': newPlace.location!.latitude,
//       'loc_lng': newPlace.location!.longitude,
//       'address': newPlace.location!.address!,
//     });
//   }

  Future<void> addPlace(
    PlaceLcation pickedLocation, String candidate_id
  ) async {
    // final address = await LocationHelper.getPlaceAddress(
    //     pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLcation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      // address: address,
    );

    final url =
        "${ApiUrls.BASE_URL}client_app/addcandidate_location";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'candidate_id': candidate_id,
          'latitude': pickedLocation.latitude,
          'longitude': pickedLocation.longitude,
          'address': '',
        }),
      );
      var message = jsonDecode(response.body);
      print(message);

      return message;

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
  
  // Future<void> fetchAndSetPlace() async {
  //   final dataList = await DBHelper.getData('user_places');
  //   _items = dataList
  //       .map((item) => Place(
  //           id: item['id'],
  //           title: item['title'],
  //           location: PlaceLcation(
  //                 latitude: item['loc_lat'],
  //                 longitude: item['loc_lng'],
  //                 address: item['address'],
  //               ),
  //           // image: File(item['image'])
  //           )
  //           )
  //       .toList();
  //   notifyListeners();
  // }
}
