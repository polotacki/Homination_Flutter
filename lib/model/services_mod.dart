class Service {
  final String title;
  final String photo;
  final String provider;
  final String categories;
  final String price;
  final List<Reviews> reviews;
  final String desc;
  final List<String> gallery;
  final String location;

  Service({
    required this.title,
    required this.photo,
    required this.provider,
    required this.categories,
    required this.price,
    required this.reviews,
    required this.desc,
    required this.gallery,
    required this.location,
  });
}

class Reviews {
  final String name;
  final int rating;
  final String comment;
  final DateTime timestamps;
  final String image;

  Reviews({
    required this.name,
    required this.rating,
    required this.comment,
    required this.timestamps,
    required this.image,
  });
}
