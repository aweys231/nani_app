// ignore_for_file: non_constant_identifier_names, unused_import, avoid_web_libraries_in_flutter, use_rethrow_when_possible, avoid_print, unused_local_variable, prefer_const_declarations, dead_code

import 'dart:convert';
import 'dart:io';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nanirecruitment/models/http_exception.dart';

class Candidate with ChangeNotifier {
  
  final String? role_id;
  final String? fname;
  final String? lname;
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

  Candidate(  { 
    this.role_id,
    this.fname,
    this.lname,
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


  Future<void> addCandidate(Candidate Candidate, File imga, String role_id ,String selectedValue) async {
    
    final url = "http://192.168.100.202/nanirecruitment/client_app/addcandidate";
    try {
    // preparing the fil
     List<int> imageBytes = imga.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      //convert file image to Base64 encoding
    final response = await http.post(Uri.parse(url),
    body: json.encode({
    'role_id': role_id,
    'fname': Candidate.fname,
    'lname': Candidate.lname,
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
    'imageUrl': baseimage}),);
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

 
}
