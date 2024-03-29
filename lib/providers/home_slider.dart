// ignore_for_file: avoid_print, use_rethrow_when_possible, avoid_returning_null_for_void, avoid_web_libraries_in_flutter, unused_import, unnecessary_null_comparison, dead_code
import 'dart:convert';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:nanirecruitment/models/home_slider_model.dart';

import '../services/api_urls.dart';

class HomeSlider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<HomeSliderModel> _images = [
  ];
  List<HomeSliderModel> get images {
    return [..._images];
  }

  Future<List<HomeSliderModel>> fetchAndSetHomeSlideImage() async {
    var url = "${ApiUrls.BASE_URL}client_app/imageslider";
    try {
      final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json',
'Access-Control-Allow-Origin': '*'});
      // final response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
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
