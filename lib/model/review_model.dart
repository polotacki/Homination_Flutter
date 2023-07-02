class Review {
  String id;
  String clientName;
  String providerName;
  int rating;
  String comment;
  String image;
  String timestamps;
  int v;

  Review({
    required this.id,
    required this.clientName,
    required this.providerName,
    required this.rating,
    required this.comment,
    required this.image,
    required this.timestamps,
    required this.v,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      clientName: json['client_Name'],
      providerName: json['provider_Name'],
      rating: json['rating'],
      comment: json['comment'],
      image: json['image'],
      timestamps: json['timestamps'],
      v: json['__v'],
    );
  }
}