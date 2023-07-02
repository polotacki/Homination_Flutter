import 'package:homaination_mobile/model/review_model.dart';

import 'geo_location_model.dart';

class ServicesModel {
  GeoLocation geolocation;
  List<String> gallery;
  String id;
  String title;

  String desc;
  String provider;
  String categories;
  String subcategories;
  String providerImage;
  int price;
  String location;
  List<Review> reviews;
  DateTime createdAt;
  DateTime updatedAt;

  ServicesModel({
    required this.geolocation,
    required this.gallery,
    required this.id,
    required this.title,
    required this.desc,
    required this.provider,
    required this.categories,
    required this.subcategories,
    required this.providerImage,
    required this.price,
    required this.location,
    required this.reviews,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      geolocation: GeoLocation.fromJson(json['geolocation']),
      gallery: List<String>.from(json['gallery']),
      id: json['_id'],
      title: json['title'],
      desc: json['desc'],
      provider: json['provider'],
      categories: json['categories'],
    subcategories: json['subcategories'],
      providerImage: json['providerImage'],
      price: json['price'],
      location: json['location'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']), reviews: [],
    );
  }
}
