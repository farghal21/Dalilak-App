import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/message_model.dart';
import '../../data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;

  HomeCubit(this.repo) : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  final List<MessageModel> messages = [];
  final ScrollController scrollController = ScrollController();

  void sendUserMessage(String message) async {
    // user message
    messages.add(
      MessageModel(
        message: message,
        messageType: MessageType.text,
        sender: MessageSender.user,
      ),
    );
    emit(HomeMessagesUpdated());
    _scrollToBottom();

    // API CALL
    final result = await repo.sendMessage(message: message);

    result.fold(
      (error) {
        // لو فشل

        emit(HomeError(error: error));
      },
      (chatResponse) {
        // لو نجح
        messages.add(
          MessageModel(
            message: chatResponse.message,
            messageType: chatResponse.hotels.isEmpty
                ? MessageType.text
                : MessageType.hasData,
            hotels: chatResponse.hotels,
            sender: MessageSender.bot,
          ),
        );
        emit(HomeMessagesUpdated());
      },
    );

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
