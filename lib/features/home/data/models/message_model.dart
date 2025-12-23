import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';

class MessageModel {
  final String message;
  final MessageType messageType;
  final MessageSender sender;
  final List<CarModel>? cars;

  MessageModel({
    required this.message,
    required this.messageType,
    required this.sender,
    this.cars,
  });
}

extension MessageTypeExtension on MessageModel {
  BorderRadiusDirectional get borderRadius {
    switch (sender) {
      case MessageSender.user:
        return BorderRadiusDirectional.only(
          topStart: Radius.circular(MyResponsive.radius(value: 12)),
          topEnd: Radius.circular(MyResponsive.radius(value: 0)),
          bottomStart: Radius.circular(MyResponsive.radius(value: 12)),
          bottomEnd: Radius.circular(MyResponsive.radius(value: 12)),
        );

      case MessageSender.bot:
        return BorderRadiusDirectional.only(
          topStart: Radius.circular(MyResponsive.radius(value: 0)),
          topEnd: Radius.circular(MyResponsive.radius(value: 12)),
          bottomStart: Radius.circular(MyResponsive.radius(value: 12)),
          bottomEnd: Radius.circular(MyResponsive.radius(value: 12)),
        );
    }
  }
}

enum MessageType {
  text,
  hasData,
  loading,
  error,
}

enum MessageSender {
  user,
  bot,
}
