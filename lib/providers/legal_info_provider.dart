// ignore_for_file: non_constant_identifier_names, prefer_const_declarations, dead_code, avoid_print, use_rethrow_when_possible, prefer_final_fields, unused_import, unused_local_variable

import 'dart:convert';
import 'dart:io';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nanirecruitment/models/http_exception.dart';

class DocumentsListModel with ChangeNotifier {
  final String id;
  final String file;

  DocumentsListModel({
    required this.id,
    required this.file,
  });
}

class LegalInfo with ChangeNotifier {
  final String? candidateid;
  final String? postcode;
  final String? have_license;
  final String? driver_licensetype;
  final String? member;
  final String? bodyname;
  final String? amountofcover;
  final String? policynumber;
  final String? expiry_date;
  final String? dbs_certificate_number;
  final File? imageUrl;

  LegalInfo({
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

  List<DocumentsListModel> _fils = [];

  List<DocumentsListModel> get fils {
    return [..._fils];
  }

  void addIDocument(String document_id, String filePath) {
    _fils.add(
      DocumentsListModel(
        id: document_id,
        file: filePath,
      ),
    );
    notifyListeners();
  }

  // this function will remove if there is  prrvious select if the user change the previous selecting
  Future<void> removeSingleDocument(String documentid) async {
    if (_fils.where((item) => item.id == documentid).isNotEmpty) {
      _fils.removeWhere((item) => item.id == documentid);
      print(documentid);
      print('remove day');
      return;
    }
    print('the the file list was added');
    print(documentid);
    print('length');
    print(_fils.length);

    notifyListeners();
  }

  Future<void> findByIdLegalInfo(String candidate_id) async {
    final url =
        "http://192.168.100.202/nanirecruitment/client_app/candidate_by_id";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({'candidate_id': candidate_id}),
      );
      // final response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        // print(extractedData['postcode']);
        final newinfodata = LegalInfo(
          candidateid: candidate_id,
          postcode: '7678',
          have_license: 'have_license',
          driver_licensetype: 'driver_licensetype',
          member: 'member',
          bodyname: 'bodyname',
          amountofcover: 'amountofcover',
          policynumber: 'policynumber',
          expiry_date: 'extractedData',
          dbs_certificate_number: 'extractedData',
          imageUrl: null,
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

  Future<void> updateLegalInfo(LegalInfo LegalInfo, String imga,
      String have_license, String member, String candidate_id) async {
    final url =
        "http://192.168.100.202/nanirecruitment/client_app/editecandidate";
    try {
      var jsonTags = _fils.map((e) {
        // preparing the fil
        List<int> imageBytes = File(e.file).readAsBytesSync();
        var basefile = base64Encode(imageBytes);

        //convert file image to Base64 encoding
        return {
          'document_id': e.id,
          'file': basefile,
        };
      }).toList(); //convert to map

    
   

      String stringFiles = json.encode(jsonTags);
      print(jsonTags);
      print(_fils.length);
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'candidate_id': candidate_id,
          'postcode': LegalInfo.postcode,
          'have_license': have_license,
          'driver_licensetype': LegalInfo.driver_licensetype,
          'member': member,
          'bodyname': LegalInfo.bodyname,
          'amountofcover': LegalInfo.amountofcover,
          'policynumber': LegalInfo.policynumber,
          'expiry_date': LegalInfo.expiry_date,
          'dbs_certificate_number': LegalInfo.dbs_certificate_number,
          'file': stringFiles
        }),
      );
      var message = jsonDecode(response.body);
      print(message);
      _fils.clear();
      return message;

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
