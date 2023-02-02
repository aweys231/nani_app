// ignore_for_file: avoid_print, use_rethrow_when_possible, avoid_returning_null_for_void, avoid_web_libraries_in_flutter, unused_import, unnecessary_null_comparison, dead_code, unused_local_variable, camel_case_types, non_constant_identifier_names
import 'dart:convert';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JobsModel with ChangeNotifier {
  final String id;
  final String name;
  final String jobtitile;
  final String description;
  final String imageUrl;
  // final String jv_id;
  // final String jv_address;
  // final String? contactname;
  // final String? contactnumber;
  // final String? post_code;
  // final String? start_date;
  // final String? end_date;
  // final String? shift_type;
  // final String? company_name;

  JobsModel({
    required this.id,
    required this.name,
    required this.jobtitile,
    required this.description,
    required this.imageUrl,
    // required this.jv_id,
    // required this.jv_address,
    // this.contactname,
    // this.contactnumber,
    // this.post_code,
    // this.start_date,
    // this.end_date,
    // this.shift_type,
    // this.company_name,
  });

  factory JobsModel.fromJson(Map<String, dynamic> json) {
    return JobsModel(
      id: json['Id'],
      name: json['jobtitile'],
      jobtitile: json['jobrole'],
      description: json['description'],
      imageUrl: json['c_image'],
      // jv_id:json['jv_id'],
      // jv_address: json['jv_address'],
      // contactname: json['contactname'],
      // contactnumber: json['contactnumber'],
      // post_code: json['post_code'],
      // start_date: json['start_date'],
      // end_date: json['end_date'],
      // shift_type: json['shift_type'],
      // company_name: json['company_name']
    );
  }
}

class Jobs_Section with ChangeNotifier {
  // ignore: prefer_final_fields
  List<JobsModel> _jobs = [];
  List<JobsModel> get jobs {
    return [..._jobs];
  }

  JobsModel findById(String id) {
    return _jobs.firstWhere((prod) => prod.id == id);
  }

  Future<List<JobsModel>> fetchAndSetAllJobs(String jobIdd) async {
    // _jobs.clear();
    // var url = 'https://myshop-e5cf5-default-rtdb.firebaseio.com/products.json';
    var url = "http://192.168.100.202/nanirecruitment/client_app/job_cate_id";
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
}
