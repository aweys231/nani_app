import 'package:flutter/foundation.dart';

class HomeSliderModel with ChangeNotifier {
  final String id;
  final String imageUrl;

  HomeSliderModel({
    required this.id,
    required this.imageUrl,
  });

  factory HomeSliderModel.fromJson(Map<String, dynamic> json) {
    return HomeSliderModel(
      id: json['image_id'],
      imageUrl: json['image_name'],
    );
  }
}
