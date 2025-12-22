class SendMessageResponseModel {
  final bool success;
  final String message;
  final SendMessageData? data;
  final dynamic errors;

  SendMessageResponseModel({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory SendMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return SendMessageResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          json['data'] != null ? SendMessageData.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }
}

class SendMessageData {
  final bool success;
  final String message;
  final List<CarModel> cars;

  SendMessageData({
    required this.success,
    required this.message,
    required this.cars,
  });

  factory SendMessageData.fromJson(Map<String, dynamic> json) {
    return SendMessageData(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      cars: (json['cars'] as List<dynamic>? ?? [])
          .map((e) => CarModel.fromJson(e))
          .toList(),
    );
  }
}

class CarModel {
  final int id;
  final String name;
  final String price;
  final double rating;
  final List<String> images;
  final CarSpecs specs;
  final String? ratingText;
  final double score;

  CarModel({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.images,
    required this.specs,
    this.ratingText,
    required this.score,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      images: List<String>.from(json['images'] ?? []),
      specs: CarSpecs.fromJson(json['specs'] ?? {}),
      ratingText: json['rating_text'],
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class CarSpecs {
  final String? maxSpeed;
  final String? height;
  final String? fuelConsumption;
  final String? groundClearance;
  final String? gears;
  final String? warrantyYears;
  final String? warrantyKm;
  final String? engineCapacity;
  final String? seats;
  final String? fuelTypeGrade;
  final String? assemblyCountry;
  final String? originCountry;
  final String? turbo;
  final String? horsepower;
  final String? batteryCapacity;
  final String? fuelTankCapacity;
  final String? trunkCapacity;
  final String? bodyType;
  final String? length;
  final String? cylinders;
  final String? width;
  final String? torque;
  final String? wheelbase;
  final String? acceleration;
  final String? batteryRange;
  final String? transmission;
  final String? driveType;
  final String? fuelType;

  CarSpecs({
    this.maxSpeed,
    this.height,
    this.fuelConsumption,
    this.groundClearance,
    this.gears,
    this.warrantyYears,
    this.warrantyKm,
    this.engineCapacity,
    this.seats,
    this.fuelTypeGrade,
    this.assemblyCountry,
    this.originCountry,
    this.turbo,
    this.horsepower,
    this.batteryCapacity,
    this.fuelTankCapacity,
    this.trunkCapacity,
    this.bodyType,
    this.length,
    this.cylinders,
    this.width,
    this.torque,
    this.wheelbase,
    this.acceleration,
    this.batteryRange,
    this.transmission,
    this.driveType,
    this.fuelType,
  });

  factory CarSpecs.fromJson(Map<String, dynamic> json) {
    return CarSpecs(
      maxSpeed: json['max_speed'],
      height: json['height'],
      fuelConsumption: json['fuel_consumption'],
      groundClearance: json['ground_clearance'],
      gears: json['gears'],
      warrantyYears: json['warranty_years'],
      warrantyKm: json['warranty_km'],
      engineCapacity: json['engine_capacity'],
      seats: json['seats'],
      fuelTypeGrade: json['fuel_type_grade'],
      assemblyCountry: json['assembly_country'],
      originCountry: json['origin_country'],
      turbo: json['turbo'],
      horsepower: json['horsepower'],
      batteryCapacity: json['battery_capacity'],
      fuelTankCapacity: json['fuel_tank_capacity'],
      trunkCapacity: json['trunk_capacity'],
      bodyType: json['body_type'],
      length: json['length'],
      cylinders: json['cylinders'],
      width: json['width'],
      torque: json['torque'],
      wheelbase: json['wheelbase'],
      acceleration: json['acceleration'],
      batteryRange: json['battery_range'],
      transmission: json['transmission'],
      driveType: json['drive_type'],
      fuelType: json['fuel_type'],
    );
  }
}
