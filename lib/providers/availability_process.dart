// ignore_for_file: avoid_print, use_rethrow_when_possible, avoid_returning_null_for_void, avoid_web_libraries_in_flutter, unused_import, unnecessary_null_comparison, dead_code, unused_local_variable, camel_case_types, prefer_final_fields, non_constant_identifier_names, prefer_const_declarations, list_remove_unrelated_type, equal_keys_in_map
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

class Shifts_Model with ChangeNotifier {
  final String candidateid;
  final String shift;
  final String year;
  final String month;
  final String day;
  final String dayname;
  String  fulldate;
  Shifts_Model({
    required this.candidateid,
    required this.shift,
    required this.year,
    required this.month,
    required this.day,
    required this.dayname,
    required this.fulldate
  });
}

class Availability_Section with ChangeNotifier {
  List<AvailabilityModel> _availability = [];
  List<AvailabilityModel> get availability {
    return [..._availability];
  }

  List<Shifts_Model> _items = [];

  List<Shifts_Model> get items {
    return [..._items];
  }

  void addItem(String candidateid, String shift, String year, String month,
      String day, String dayname, String  fulldate) {
    _items.add(
      Shifts_Model(
        candidateid: candidateid,
        shift: shift,
        year: year,
        month: month,
        day: day,
        dayname: dayname,
        fulldate:fulldate
      ),
    );
    notifyListeners();
  }

  // this function will remove if there is  prrvious select if the user change the previous selecting
  Future<void> removeSingleItem(String days) async {
    if (_items.where((item) => item.day == days).isNotEmpty) {
      _items.removeWhere((item) => item.day == days);
      print(days);
      print('remove day');
      return;
    }
    print('the day will list was added');
    print(days);
    print('length');
    print(_items.length);

    notifyListeners();
  }

// fill shifts drop down
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

        for (int i = 0; i < extractedData.length; i++) {
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

  Future<void> addAvailability(String candidateId) async {
    final url =
        "http://192.168.100.202/nanirecruitment/client_app/add_availabilit";
    try {
      

    var jsonTags = _items.map((e){
    return {
          'cand_id': e.candidateid,
          'availability':e.shift,
          'day_name': e.dayname,
          'year': e.year,
          'month': e.month,
          'day': e.day,
          'full_date' : e.fulldate, 
          'creation_date' : DateTime.now().toString(),  
        };
  }).toList(); //convert to map

  
String stringstudents = json.encode(jsonTags);

      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'items': jsonTags
        }),
      );
      // var message = jsonDecode(response.body);
      var message = response.body;
      // print(dayname);
      // print(_items.length);
      print(message);
      _items.clear();
      // return message;

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
