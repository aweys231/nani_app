// ignore_for_file: avoid_print, use_rethrow_when_possible, avoid_returning_null_for_void, avoid_web_libraries_in_flutter, unused_import, unnecessary_null_comparison, dead_code, unused_local_variable, camel_case_types
import 'dart:convert';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/api_urls.dart';

// import 'package:nanirecruitment/models/Category_model.dart';
class CategoryModel with ChangeNotifier {
  final String id;
  final String name;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['Id'],
      name: json['title'],
      imageUrl: json['c_image'],
    );
  }
}
class Category_Section with ChangeNotifier {
  // ignore: prefer_final_fields
  List<CategoryModel> _categories = [
  ];
  List<CategoryModel> get categories {
    return [..._categories];
  }

  Future<List<CategoryModel>> fetchAndSetAllCategory() async {
    // var url = 'https://myshop-e5cf5-default-rtdb.firebaseio.com/products.json';
    var url = "${ApiUrls.BASE_URL}client_app/category";
    try {
      final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json',
'Access-Control-Allow-Origin': '*'});
      // final response = await http.get(Uri.parse(url));
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        return _categories = [
          for (final categories in jsonDecode(response.body))
            CategoryModel.fromJson(categories),
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
      throw error;
    }
  }
}
