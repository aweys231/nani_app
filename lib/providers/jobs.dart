// ignore_for_file: avoid_print, use_rethrow_when_possible, avoid_returning_null_for_void, avoid_web_libraries_in_flutter, unused_import, unnecessary_null_comparison, dead_code, unused_local_variable, camel_case_types, non_constant_identifier_names, prefer_const_declarations, prefer_final_fields
import 'dart:convert';
import 'dart:io';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/api_urls.dart';

class JobsModel with ChangeNotifier {
  final String id;
  final String name;
  final String jobtitile;
  final String description;
  final String imageUrl;

  JobsModel({
    required this.id,
    required this.name,
    required this.jobtitile,
    required this.description,
    required this.imageUrl,
  });

  factory JobsModel.fromJson(Map<String, dynamic> json) {
    return JobsModel(
      id: json['Id'],
      name: json['jobtitile'],
      jobtitile: json['jobrole'],
      description: json['description'],
      imageUrl: json['c_image'],
    );
  }
}

class VacuncyModel with ChangeNotifier {
  final String id;
  final String name;
  final String jobtitile;
  final String description;
  final String imageUrl;
  final String? jobrole_id;
  final String? jv_address;
  final String? contactname;
  final String? contactnumber;
  final String? post_code;
  final String? start_date;
  final String? end_date;
  final String? shift_type;
  final String? company_name;
  final String? businesunit;
  final int? minut;
  final String? km;
  double? fieldLatitude;
  double? fieldLogitude;
  final String? method_name;

  VacuncyModel(
      {required this.id,
      required this.name,
      required this.jobtitile,
      required this.description,
      required this.imageUrl,
      this.jobrole_id,
      this.jv_address,
      this.contactname,
      this.contactnumber,
      this.post_code,
      this.start_date,
      this.end_date,
      this.shift_type,
      this.company_name,
      this.businesunit,
      this.minut,
      this.km,
        this.method_name,
      this.fieldLatitude,
      this.fieldLogitude});

  // factory VacuncyModel.fromJson(Map<String, dynamic> json) {
  //   return VacuncyModel(
  //     id: json[0]['vacuncy_data']['jobvacancy_id'],
  //     name: json[0]['vacuncy_data']['jobtitile'],
  //     jobtitile: json[0]['vacuncy_data']['jobrole'],
  //     description: json[0]['vacuncy_data']['description'],
  //     imageUrl: json[0]['vacuncy_data']['c_image'],
  //   //   jobrole_id:json[0]['vacuncy_data']['jobrole_id'],
  //   //   jv_address: json[0]['vacuncy_data']['address'],
  //   //   contactname: json[0]['contactname'],
  //   //   contactnumber: json[0]['vacuncy_data']['contactname'],
  //   //   post_code: json[0]['vacuncy_data']['post_code'],
  //   //   start_date: json[0]['vacuncy_data']['sdate'],
  //   //   end_date: json[0]['vacuncy_data']['edate'],
  //   //   shift_type: json[0]['vacuncy_data']['shift_type'],
  //   //   company_name: json[0]['vacuncy_data']['company_name'],
  //   //   businesunit: json[0]['vacuncy_data']['businesunit'],
  //   //    minut: json[0]['minut'],
  //  km: json[0]['km'],
  //   );
  // }
}

class DocumentsModel with ChangeNotifier {
  final String id;
  final String name;

  DocumentsModel({
    required this.id,
    required this.name,
  });
}

class UpcomingModel with ChangeNotifier {
  final String availabilityid;
  final String daynumber;
  final String dayname;
  final String shiftname;
  final String title;
  final String companies_name;
  final String address;
  final String Candidate_name;
  final String Business_unit;
  UpcomingModel({
    required this.availabilityid,
    required this.daynumber,
    required this.dayname,
    required this.shiftname,
    required this.title,
    required this.companies_name,
    required this.address,
    required this.Candidate_name,
    required this.Business_unit

  });
}

class CompletedgModel with ChangeNotifier {
  final String availabilityid;
  final String daynumber;
  final String dayname;
  final String shiftname;
  final String title;
  final String companies_name;
  final String address;
  CompletedgModel({
    required this.availabilityid,
    required this.daynumber,
    required this.dayname,
    required this.shiftname,
    required this.title,
    required this.companies_name,
    required this.address,
  });
}

class Jobs_Section with ChangeNotifier {
  List<UpcomingModel> _upcoming = [];
  List<UpcomingModel> get upcoming {
    return [..._upcoming];
  }

  List<CompletedgModel> _compeleted = [];
  List<CompletedgModel> get compeleted {
    return [..._compeleted];
  }

  List<JobsModel> _jobs = [];
  List<JobsModel> get jobs {
    return [..._jobs];
  }

  JobsModel findById(String id) {
    return _jobs.firstWhere((prod) => prod.id == id);
  }

  List<DocumentsModel> _document = [];
  List<DocumentsModel> get document {
    return [..._document];
  }

  Future<List<DocumentsModel>> requirement_documents() async {
    var url = "${ApiUrls.BASE_URL}client_app/requirement_documents";
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      });

      if (response.statusCode == 200) {
        final List<DocumentsModel> loadedDocuments = [];
        final extractedData = json.decode(response.body);
        print('documrnts');
        // print(extractedData['result'][0]['Id'].toString());

        print('documrnts data');

        for (int j = 0; j <= extractedData['result'][j].length; j++) {
          loadedDocuments.add(
            DocumentsModel(
              id: extractedData['result'][j]['Id'],
              name: extractedData['result'][j]['name'],
            ),
          );
        }
        _document = loadedDocuments.toList();
        return _document;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load album');
      }

      notifyListeners();
    } catch (error) {
      print(error);
      print(_jobs);
      throw error;
    }
  }

  List<VacuncyModel> _vcuncyjobs = [];
  List<VacuncyModel> get vcuncyjobs {
    return [..._vcuncyjobs];
  }

  VacuncyModel findVacuncyById(String id) {
    return _vcuncyjobs.firstWhere((vcuncy) => vcuncy.id == id);
  }

  Future timeSheetChecking( String candidate_id, String jobvacancy_id, String creation_date) async {
    var url = "${ApiUrls.BASE_URL}client_app/timeSheetChecking";
    final response = await http.post(Uri.parse(url),
        body: json.encode(
          {
            'candidate_id': candidate_id,
            'creation_date': creation_date,
            'jobvacancy_id': jobvacancy_id
          },
        ),
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        });
 print(response.body);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
      print('data');
      return responseData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load check in');
    }
  }

  Future get_check_qrcode(String candidate_id, String qrcode) async {
    var url = "${ApiUrls.BASE_URL}client_app/get_check_qrcode";
    final response = await http.post(Uri.parse(url),
        body: json.encode(
          {
            'candidate_id': candidate_id,
            'qrcode': qrcode,
          },
        ),
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
      return responseData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load check in');
    }
  }

  Future<List<JobsModel>> fetchAndSetAllJobs(String jobIdd) async {
    var url = "${ApiUrls.BASE_URL}client_app/job_cate_id";
    try {
//       final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json',
// 'Access-Control-Allow-Origin': '*'});
      final response = await http.post(Uri.parse(url),
          body: json.encode(
            {
              'jobIdd': jobIdd,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          });
      // final response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
      if (response.statusCode == 200) {
        return _jobs = [
          for (final alljobs in jsonDecode(response.body))
            JobsModel.fromJson(alljobs),
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
      print(_jobs);
      throw error;
    }
  }

  Future<List<VacuncyModel>> fetchAndSetVacuncy(
      String role_id, String candidate_id) async {
    var url = "${ApiUrls.BASE_URL}client_app/chek_job_vacancy";
    try {
//       final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json',
// 'Access-Control-Allow-Origin': '*'});
      final response = await http.post(Uri.parse(url),
          body: json.encode(
            {
              'role_id': role_id,
              'candidate_id': candidate_id,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          });
      // final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<VacuncyModel> loadedvacuncy = [];
        final extractedData = json.decode(response.body);
        for (int i = 0; i < extractedData.length; i++) {
          loadedvacuncy.add(
            VacuncyModel(
              id: extractedData[i]['vacuncy_data']['jobvacancy_id'],
              name: extractedData[i]['vacuncy_data']['jobtitile'],
              jobtitile: extractedData[i]['vacuncy_data']['jobrole'],
              description: extractedData[i]['vacuncy_data']['description'],
              imageUrl: extractedData[i]['vacuncy_data']['c_image'],
              jobrole_id: extractedData[i]['vacuncy_data']['jobrole_id'],
              jv_address: extractedData[i]['vacuncy_data']['address'],
              method_name: extractedData[i]['vacuncy_data']['method_name'],

              //   contactname: extractedData[i]['contactname'],
              contactnumber: extractedData[i]['vacuncy_data']['contactname'],
              //   post_code: extractedData[i]['vacuncy_data']['post_code'],
              start_date: extractedData[i]['vacuncy_data']['sdate'],
              end_date: extractedData[i]['vacuncy_data']['edate'],
              shift_type: extractedData[i]['vacuncy_data']['shift_name'],
              company_name: extractedData[i]['vacuncy_data']['company_name'],
              //   businesunit: extractedData[i]['vacuncy_data']['businesunit'],
              minut: extractedData[i]['minut'],
              km: extractedData[i]['km'].toString(),
              fieldLatitude:
                  double.parse(extractedData[i]['vacuncy_data']['latitude']),
              fieldLogitude:
                  double.parse(extractedData[i]['vacuncy_data']['longitude']),
            ),
          );
          print(extractedData[i]['vacuncy_data']['company_name']);
        }
        _vcuncyjobs = loadedvacuncy.toList();
        return _vcuncyjobs;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load album');
      }

      notifyListeners();
    } catch (error) {
      print(error);
      print(_jobs);
      throw error;
    }
  }

  Future<void> vacuncy_booking(String candidate_id, String vacuncy_id) async {
    final url = "${ApiUrls.BASE_URL}client_app/vacuncy_booking";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'candidate_id': candidate_id,
          'vacuncy_id': vacuncy_id,
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

  Future attandance_registration(
      String candidate_id, String vacuncy_id, String time, String day, File imga) async {
    // Preparing the file
    List<int> imageBytes = imga.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);

    final url = "${ApiUrls.BASE_URL}client_app/attandance_registration";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'candidate_id': candidate_id,
          'vacuncy_id': vacuncy_id,
          'timeinout': time,
          'day': day,
          'timesheetUrl': baseimage,
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

  Future<List<UpcomingModel>> fetchAndSetVacuncyUpcoming(
      String candidate_id) async {
    var url = "${ApiUrls.BASE_URL}client_app/fill_upcoming";
    try {
//       final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json',
// 'Access-Control-Allow-Origin': '*'});
      final response = await http.post(Uri.parse(url),
          body: json.encode(
            {
              'candidate_id': candidate_id,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          });
      // final response = await http.get(Uri.parse(url));
      _upcoming.clear();
      if (response.statusCode == 200) {
        final List<UpcomingModel> loadedupcoming = [];
        final extractedData = json.decode(response.body);
        for (int i = 0; i < extractedData.length; i++) {
          loadedupcoming.add(UpcomingModel(
              availabilityid: extractedData[i]['availability_id'],
              daynumber: extractedData[i]['day'],
              dayname: extractedData[i]['day_name'],
              shiftname: extractedData[i]['name'],
              title: extractedData[i]['title'],
              Candidate_name: extractedData[i]['canidate_name'],
              companies_name: extractedData[i]['companies_name'],
              Business_unit: extractedData[i]['businesunit'],
              address: extractedData[i]['address']));

          print(extractedData[i]['day_name']);
        }
        _upcoming = loadedupcoming.toList();
        return _upcoming;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load album');
      }

      notifyListeners();
    } catch (error) {
      print(error);
      print(_jobs);
      throw error;
    }
  }

  Future<List<CompletedgModel>> fetchAndSetVacuncyCompleted(
      String candidate_id) async {
    var url =
        "${ApiUrls.BASE_URL}client_app/fill_compeleted";
    try {
//       final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json',
// 'Access-Control-Allow-Origin': '*'});
      final response = await http.post(Uri.parse(url),
          body: json.encode(
            {
              'candidate_id': candidate_id,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          });
      // final response = await http.get(Uri.parse(url));
      _compeleted.clear();
      if (response.statusCode == 200) {
        final List<CompletedgModel> loadedcompleted = [];
        final extractedData = json.decode(response.body);
        for (int i = 0; i < extractedData.length; i++) {
          loadedcompleted.add(CompletedgModel(
              availabilityid: extractedData[i]['availability_id'],
              daynumber: extractedData[i]['day'],
              dayname: extractedData[i]['day_name'],
              shiftname: extractedData[i]['name'],
              title: extractedData[i]['title'],
              companies_name: extractedData[i]['companies_name'],
              address: extractedData[i]['address']));
          print(extractedData[i]['day_name']);
        }
        _compeleted = loadedcompleted.toList();
        return _compeleted;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load album');
      }

      notifyListeners();
    } catch (error) {
      print(error);
      print(_jobs);
      throw error;
    }
  }

  Future shift_cancelation(String availability_id, String reason, String cand_id) async {
    final url =
        "${ApiUrls.BASE_URL}client_app/shift_cancelation";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'availability_id': availability_id,
          'reason': reason,
          'cand_id': cand_id,
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
}
