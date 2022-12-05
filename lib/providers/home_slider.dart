// ignore_for_file: avoid_print, use_rethrow_when_possible, avoid_returning_null_for_void, avoid_web_libraries_in_flutter, unused_import, unnecessary_null_comparison, dead_code
import 'dart:convert';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:nanirecruitment/models/home_slider_model.dart';

class HomeSlider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<HomeSliderModel> _images = [
    // HomeSliderModel(
    //   id: 'p1',
    //   imageUrl: 'assets/sliderimages/00.jpg',
    // ),
    // HomeSliderModel(
    //   id: 'p2',
    //   imageUrl: 'assets/sliderimages/1.jpg',
    // ),
    // HomeSliderModel(
    //   id: 'p3',
    //   imageUrl: 'assets/sliderimages/2.jpg',
    // ),
    // HomeSliderModel(
    //   id: 'p4',
    //   imageUrl: 'assets/sliderimages/01.jpg',
    // ),
    // HomeSliderModel(
    //   id: 'p4',
    //   imageUrl: 'assets/sliderimages/02.jpg',
    // ),
  ];
  List<HomeSliderModel> get images {
    return [..._images];
  }

  Future<List<HomeSliderModel>> fetchAndSetHomeSlideImage() async {
    // var url = 'https://myshop-e5cf5-default-rtdb.firebaseio.com/products.json';
    var url = "http://192.168.100.202/nanirecruitment//client_app/imageslider";
    // var url = "http://192.168.100.202/ex.asalxpress.com//Wallet/imageslider";

    try {
      final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json',
'Access-Control-Allow-Origin': '*'});
      // final response = await http.get(Uri.parse(url));
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        return _images = [
          for (final image in jsonDecode(response.body))
            HomeSliderModel.fromJson(image),
        ];
      // return _images;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load album');
      }

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
