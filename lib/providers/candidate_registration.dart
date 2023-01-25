// ignore_for_file: non_constant_identifier_names, unused_import, avoid_web_libraries_in_flutter, use_rethrow_when_possible, avoid_print, unused_local_variable, prefer_const_declarations, dead_code, unnecessary_this, duplicate_ignore

import 'dart:convert';
import 'dart:io';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nanirecruitment/models/http_exception.dart';

class NationalityModel with ChangeNotifier {
  final String id;
  final String name;

  NationalityModel({
    required this.id,
    required this.name,
  });
   ///this method will prevent the override of toString
  String userAsString() {
    // ignore: unnecessary_this
    return '#${this.id} ${this.name}';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    return this.name.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(NationalityModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}

class Candidate with ChangeNotifier {
  final String? role_id;
  final String? fname;
  final String? lname;
  final String? national;
  final String? gender;
  final String? location;
  final String? mobile;
  final String? title;
  final String? email;
  final String? Languages;
  final String? nokname;
  final String? nokaddress;
  final String? nokmobile;
  final String? user_name;
  final String? passwd;
  final File? imageUrl;

  Candidate({
    this.role_id,
    this.fname,
    this.lname,
    this.national,
    this.gender,
    this.location,
    this.mobile,
    this.title,
    this.email,
    this.Languages,
    this.nokname,
    this.nokaddress,
    this.nokmobile,
    this.user_name,
    this.passwd,
    this.imageUrl,
  });
  List<NationalityModel> _nationality = [];
  List<NationalityModel> get nationality {
    return [..._nationality];
  }

  Future<void> addCandidate(Candidate Candidate, File imga, String role_id,
      String selectedValue) async {
    final url =
        "http://192.168.100.202/nanirecruitment/client_app/addcandidate";
    try {
      // preparing the fil
      List<int> imageBytes = imga.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      //convert file image to Base64 encoding
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'role_id': role_id,
          'fname': Candidate.fname,
          'lname': Candidate.lname,
          'national': Candidate.national,
          'gender': selectedValue,
          'location': Candidate.location,
          'mobile': Candidate.mobile,
          'title': Candidate.title,
          'email': Candidate.email,
          'Languages': Candidate.Languages,
          'nokname': Candidate.nokname,
          'nokaddress': Candidate.nokaddress,
          'nokmobile': Candidate.nokmobile,
          'user_name': Candidate.user_name,
          'passwd': Candidate.passwd,
          'imageUrl': baseimage
        }),
      );
      var message = jsonDecode(response.body);
      print(message);
      print(role_id);
      print(selectedValue);
      return message;

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // fill shifts drop down
  Future<List<NationalityModel>> fetchAndSetnatinality() async {
    var url =
        "http://192.168.100.202/nanirecruitment//client_app/fill_nationality";
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      });
      // final response = await http.get(Uri.parse(url));
      print("hello");
      print(json.decode(response.body));

      if (response.statusCode == 200) {
        final List<NationalityModel> loadednationality = [];
        final extractedData = json.decode(response.body);

        for (int i = 0; i < extractedData.length; i++) {
          loadednationality.add(
            NationalityModel(
              id: extractedData[i]['num_code'],
              name: extractedData[i]['nationality'],
            ),
          );
        }
        _nationality = loadednationality.toList();
        return _nationality;
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
