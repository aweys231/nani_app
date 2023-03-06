// ignore_for_file: non_constant_identifier_names, prefer_const_declarations, dead_code, avoid_print, use_rethrow_when_possible, prefer_final_fields, unused_import, unused_local_variable

import 'dart:convert';
import 'dart:io';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nanirecruitment/models/http_exception.dart';

class LegalInfo with ChangeNotifier {
  final String? candidateid;
  final String? postcode;
  final String? have_license;  
  final String? driver_licensetype;
  final String? member;
  final String? bodyname;
  final String? amountofcover	;
  final String? policynumber;
  final String?  expiry_date	;
  final String? dbs_certificate_number;
  final File? imageUrl;

  LegalInfo(  { 
    this.candidateid,
    this.postcode,
    this.have_license,
    this.driver_licensetype, 
    this.member,
    this.bodyname,
    this.amountofcover,
    this.policynumber,
    this.expiry_date,
    this.dbs_certificate_number,
    this.imageUrl,
    
  });
List<LegalInfo> _infodata = [];
List<LegalInfo> get infodata {
    return [..._infodata];
  }
  String? get candidate_id {
    return candidateid;
  }
 LegalInfo findById(String id) {
    return _infodata.firstWhere((info) => info.candidateid == id);
  }
 

  Future<void> findByIdLegalInfo(String candidate_id) async {
    final url = "http://192.168.100.202/nanirecruitment/client_app/candidate_by_id";
    try {
     final response = await http.post(Uri.parse(url),body: json.encode({'candidate_id': candidate_id }),);
      // final response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) ;
      if (response.statusCode == 200) {
        // print(extractedData['postcode']);
        final newinfodata = LegalInfo(
          candidateid:'64',
          postcode:'7678',
          have_license: 'have_license',
          driver_licensetype:'driver_licensetype',
          member: 'member',
          bodyname: 'bodyname',
          amountofcover: 'amountofcover',
          policynumber: 'policynumber',
          expiry_date: 'extractedData',
          dbs_certificate_number: 'extractedData',
          imageUrl:null,
    );
      _infodata.add(newinfodata);
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
 Future<void> updateLegalInfo(LegalInfo LegalInfo, String imga, String have_license ,String member,String candidate_id) async {
    
    final url = "http://192.168.100.202/nanirecruitment/client_app/editecandidate";
    try {
      
    // preparing the fil
     List<int> imageBytes = File(imga).readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      //convert file image to Base64 encoding
    final response = await http.post(Uri.parse(url),
    
    body: json.encode({
    'candidate_id':candidate_id,
    'postcode': LegalInfo.postcode,
    'have_license': have_license,
    'driver_licensetype': LegalInfo.driver_licensetype,
    'member': member,
    'bodyname': LegalInfo.bodyname,
    'amountofcover': LegalInfo.amountofcover,
    'policynumber': LegalInfo.policynumber,
    'expiry_date': LegalInfo.expiry_date,
    'dbs_certificate_number': LegalInfo.dbs_certificate_number,
    'file': baseimage
    }),);
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
