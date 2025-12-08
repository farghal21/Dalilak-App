class HotelModel {
  final String name;
  final String? rating;
  final String? price;
  final List<String> features;
  final String? image;

  HotelModel({
    required this.name,
    this.rating,
    this.price,
    required this.features,
    this.image,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      name: json["name"] ?? "",
      rating: json["rating"]?.toString(),
      price: json["price"],
      features:
          (json["features"] as List?)?.map((f) => f.toString()).toList() ?? [],
      image: json["image"],
    );
  }
}
