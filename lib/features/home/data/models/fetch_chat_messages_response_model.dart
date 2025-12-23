import 'send_chat_messages_response_model.dart';

class FetchChatMessagesResponseModel {
  final bool success;
  final String message;
  final FetchChatMessagesData? data;
  final dynamic errors;

  FetchChatMessagesResponseModel({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory FetchChatMessagesResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchChatMessagesResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? FetchChatMessagesData.fromJson(json['data'])
          : null,
      errors: json['errors'],
    );
  }
}

class FetchChatMessagesData {
  final String sessionId;
  final List<ChatMessageModel> messages;

  FetchChatMessagesData({
    required this.sessionId,
    required this.messages,
  });

  factory FetchChatMessagesData.fromJson(Map<String, dynamic> json) {
    return FetchChatMessagesData(
      sessionId: json['sessionId'] ?? '',
      messages: (json['messages'] as List<dynamic>? ?? [])
          .map((e) => ChatMessageModel.fromJson(e))
          .toList(),
    );
  }
}

class ChatMessageModel {
  final String id;
  final String sender; // user | ai
  final String message;
  final MessageData? data;
  final DateTime createdAt;

  ChatMessageModel({
    required this.id,
    required this.sender,
    required this.message,
    this.data,
    required this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      sender: json['sender'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? MessageData.fromJson(json['data']) : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  /// helper مفيد في UI
  bool get isUser => sender == 'user';
  bool get isAi => sender == 'ai';
}

class MessageData {
  final List<CarModel> cars;

  MessageData({
    required this.cars,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      cars: (json['cars'] as List<dynamic>? ?? [])
          .map((e) => CarModel.fromJson(e))
          .toList(),
    );
  }

  bool get hasCars => cars.isNotEmpty;
}
