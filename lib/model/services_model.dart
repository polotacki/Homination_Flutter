import 'package:homaination_mobile/model/review_model.dart';

class ServicesModel {
  List<String> gallery;
  String id;
  String title;
  String name;

  String desc;
  String provider;
  String categories;
  String providerImage;
  int price;
  String location;
  bool isFavorite ;
  List<Review> reviews;
  DateTime createdAt;
  DateTime updatedAt;

  ServicesModel({
    required this.gallery,
    required this.id,
    required this.name,
    required this.title,
    required this.desc,
    required this.provider,
    required this.categories,
    required this.providerImage,
    required this.price,
    required this.location,
    required this.isFavorite,
    required this.reviews,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      gallery: List<String>.from(json['gallery']),
      id: json['_id'],
      name: json['name']??'',
      title: json['title'],
      desc: json['desc'],
      provider: json['provider'],
      categories: json['categories'],
      providerImage: json['providerImage'],
      price: json['price'],
      location: json['location'],
      isFavorite: json['isFavorite'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']), reviews: [],
    );
  }
}
