import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nanirecruitment/models/http_exception.dart';
import '../services/api_urls.dart';

class NationalityModel with ChangeNotifier {
  final String id;
  final String name;

  NationalityModel({
    required this.id,
    required this.name,
  });

// Other methods and toString...
}

class Candidate with ChangeNotifier {
  // Candidate model fields
  final String? role_id;
  final String? fname;
  final String? mname;
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

  // Constructor
  Candidate({
    this.role_id,
    this.fname,
    this.lname,
    this.mname,
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

  Future<http.Response> addCandidate(Candidate candidate, File imga) async {
    final url = "${ApiUrls.BASE_URL}client_app/addcandidate";
    try {
      // Preparing the file
      List<int> imageBytes = imga.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'role_id': candidate.role_id,
          'fname': candidate.fname,
          'mname': candidate.mname,
          'lname': candidate.lname,
          'national': candidate.national,
          'gender': candidate.gender,
          'location': candidate.location,
          'mobile': candidate.mobile,
          'title': candidate.title,
          'email': candidate.email,
          'Languages': candidate.Languages,
          'nokname': candidate.nokname,
          'nokaddress': candidate.nokaddress,
          'nokmobile': candidate.nokmobile,
          'user_name': candidate.user_name,
          'passwd': candidate.passwd,
          'imageUrl': baseimage,
        }),
      );

      return response;
    } catch (error) {
      print(error);
      throw HttpException('Failed to add candidate');
    }
  }

  Future<List<NationalityModel>> fetchAndSetNationality() async {
    var url = "${ApiUrls.BASE_URL}client_app/fill_nationality";
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      });

      if (response.statusCode == 200) {
        final List<NationalityModel> loadedNationality = [];
        final extractedData = json.decode(response.body);

        for (int i = 0; i < extractedData.length; i++) {
          loadedNationality.add(
            NationalityModel(
              id: extractedData[i]['num_code'],
              name: extractedData[i]['nationality'],
            ),
          );
        }
        _nationality = loadedNationality.toList();
        return _nationality;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw HttpException('Failed to load nationality');
      }
    } catch (error) {
      print(error);
      throw HttpException('Failed to fetch nationality');
    }
  }

  void fetchAndSetnatinality() {}
}
