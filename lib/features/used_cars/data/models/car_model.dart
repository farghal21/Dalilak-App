/// Used Car Model - Matches backend API response structure
/// Based on official backend documentation
class CarModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String city;
  final String buyerPhoneNumber;
  final int createdAtYear;
  final List<String> images;

  CarModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.city,
    required this.buyerPhoneNumber,
    required this.createdAtYear,
    required this.images,
  });

  /// Factory constructor for creating CarModel from JSON
  /// Handles null safety and type conversion safely
  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: _parsePrice(json['price']),
      description: json['description']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      buyerPhoneNumber: json['buyerPhoneNumber']?.toString() ?? '',
      createdAtYear: _parseInt(json['createdAtYear']) ?? DateTime.now().year,
      images: _parseImagesList(json['images']),
    );
  }

  /// Helper method to safely parse price to double
  static double _parsePrice(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  /// Helper method to safely parse integer values
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }

  /// Helper method to safely parse images list and convert relative paths to full URLs
  /// Prepends baseUrl to any image path that doesn't start with 'http'
  static List<String> _parseImagesList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      // Base URL from API (remove trailing 'api/' to get domain)
      const baseUrl = 'https://jrkmal-001-site1.jtempurl.com';

      return value.where((item) => item != null).map((item) {
        final imagePath = item.toString();
        // If path already starts with http, return as is
        if (imagePath.startsWith('http')) {
          return imagePath;
        }
        // Otherwise, prepend baseUrl
        // Remove leading slash if exists to avoid double slashes
        final cleanPath =
            imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
        return '$baseUrl/$cleanPath';
      }).toList();
    }
    return [];
  }

  /// Convert CarModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'city': city,
      'buyerPhoneNumber': buyerPhoneNumber,
      'createdAtYear': createdAtYear,
      'images': images,
    };
  }

  /// Create a copy of CarModel with updated fields
  CarModel copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? city,
    String? buyerPhoneNumber,
    int? createdAtYear,
    List<String>? images,
  }) {
    return CarModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      city: city ?? this.city,
      buyerPhoneNumber: buyerPhoneNumber ?? this.buyerPhoneNumber,
      createdAtYear: createdAtYear ?? this.createdAtYear,
      images: images ?? this.images,
    );
  }
}
