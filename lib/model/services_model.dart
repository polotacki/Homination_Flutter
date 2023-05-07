class ServicesModel {
  List<String> gallery;
  String id;
  String title;
  String name;

  String desc;
  String provider;
  String categories;
  String providerImage;
  String price;
  String location;
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
      reviews: List<Review>.from(
          (json['reviews'] as List).map((review) => Review.fromJson(review))),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Review {
  String id;
  String image;
  String name;
  int rating;
  String comment;
  DateTime timestamps;

  Review({
    required this.id,
    required this.image,
    required this.name,
    required this.rating,
    required this.comment,
    required this.timestamps,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      image: json['image'],
      name: json['name'],
      rating: json['rating'],
      comment: json['comment'],
      timestamps: DateTime.parse(json['timestamps']),
    );
  }
}
