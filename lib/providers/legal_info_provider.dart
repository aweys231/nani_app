// ignore_for_file: non_constant_identifier_names, prefer_const_declarations, dead_code, avoid_print, use_rethrow_when_possible, prefer_final_fields, unused_import, unused_local_variable, no_leading_underscores_for_local_identifiers, unused_element, unnecessary_null_comparison, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:io';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nanirecruitment/models/http_exception.dart';

import '../services/api_urls.dart';

class DocumentsListModel with ChangeNotifier {
  final String candidateid;
  final String id;
  final String file;

  DocumentsListModel({
    required this.candidateid,
    required this.id,
    required this.file,
  });

  Map<String, dynamic> toMap() {
    return {
      'candidateid':candidateid,
      'document_id': id,
      'file': file,
    };
  }

  static dynamic getListMap(List<dynamic> documents) {
    if (documents == null) {
      return null;
    }
    List<Map<String, dynamic>> list = [];
    documents.forEach((element) {
      list.add(element.toMap());
    });
    return list;
  }

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

  void addIDocument(String document_id, String filePath, String candidateid) {
     // preparing the fil
        List<int> imageBytes = File(filePath).readAsBytesSync();
        var basefile = base64Encode(imageBytes);
      //   //convert file image to Base64 encoding
    _fils.add(
      DocumentsListModel(
        candidateid: candidateid,
        id: document_id,
        file: basefile,
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
        "${ApiUrls.BASE_URL}client_app/candidate_by_id";
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

  Future<String> updateLegalInfo(LegalInfo LegalInfo, String imga,
      String have_license, String member, String candidate_id) async {
    final url =
        "${ApiUrls.BASE_URL}client_app/editecandidate";
    try {
    
var documents = DocumentsListModel.getListMap(_fils);
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
          'file': documents
        }),
      );
      var message = jsonDecode(response.body);
      // var message = response.body;
      print(message);
      _fils.clear();
      return message['messages'].toString();

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
