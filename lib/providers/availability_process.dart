// ignore_for_file: avoid_print, use_rethrow_when_possible, avoid_returning_null_for_void, avoid_web_libraries_in_flutter, unused_import, unnecessary_null_comparison, dead_code, unused_local_variable, camel_case_types
import 'dart:convert';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:nanirecruitment/models/Category_model.dart';
class AvailabilityModel with ChangeNotifier {
  final String id;
  final String name;

  AvailabilityModel({
    required this.id,
    required this.name,
  });
}

class Availability_Section with ChangeNotifier {
  List<AvailabilityModel> _availability = [];
  List<AvailabilityModel> get availability {
    return [..._availability];
  }

  Future<List<AvailabilityModel>> fetchAndSetshifts() async {
    var url = "http://192.168.100.202/nanirecruitment//client_app/availability";
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      });
      // final response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
      if (response.statusCode == 200) {
        final List<AvailabilityModel> loadedshifts = [];
        final extractedData = json.decode(response.body);

        for (int i = 1; i < extractedData.length; i++) {
          loadedshifts.add(
            AvailabilityModel(
              id: extractedData[i]['id'],
              name: extractedData[i]['name'],
            ),
          );
        }
        _availability = loadedshifts.toList();
        return _availability;
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
