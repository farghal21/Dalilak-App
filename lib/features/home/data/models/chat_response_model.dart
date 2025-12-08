import 'hotel_model.dart';

class ChatResponseModel {
  final String sessionId;
  final String signal;
  final String message;
  final List<HotelModel> hotels;

  ChatResponseModel({
    required this.sessionId,
    required this.signal,
    required this.message,
    required this.hotels,
  });

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      sessionId: json["sessionId"] ?? "",
      signal: json["signal"] ?? "",
      message: json["message"] ?? "",
      hotels: (json["hotels"] as List?)
              ?.map((e) => HotelModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
