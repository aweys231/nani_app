// ignore_for_file: unnecessary_null_comparison, use_rethrow_when_possible, prefer_const_constructors, prefer_const_declarations, non_constant_identifier_names, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  String? _candidate_id;
  String? _role_id;
  Timer? _authTimer;
  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  String? get candidate_id {
    return _candidate_id;
  }

  String? get role_id {
    return _role_id;
  }

  Future<void> _authenticate(String email, String password) async {
    final url = 'http://192.168.100.202/nanirecruitment/client_app/loging';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'user_name': email,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData['message']);
      print('hell');
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      _token = responseData['token'];
      _role_id = responseData['role_id'];
      _candidate_id = responseData['candidate_id'];
      _userId = responseData['user_id'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: responseData['expiresIn'],
        ),
      );

      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'candidate_id': _candidate_id,
          'userId': _userId,
          'role_id': _role_id,
          'expiryDate': _expiryDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String? email, String? password) async {
    // return _authenticate(email!, password!, 'verifyPassword');
    return _authenticate(email!, password!);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json
        .decode(prefs.getString('userData').toString()) as Map<String, Object>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'].toString());

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'].toString();
    _candidate_id = extractedUserData['candidate_id'].toString();
    _userId = extractedUserData['userId'].toString();
    _role_id = extractedUserData['role_id'].toString();
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _role_id = null;
    _candidate_id = null;
    _expiryDate = null;
    print(_authTimer);
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
    // _authTimer = Timer(Duration(seconds: 30), logout);
  }
}
