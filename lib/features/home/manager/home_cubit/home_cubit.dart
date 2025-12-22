import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/message_model.dart';
import '../../data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;
  String? sessionId;
  int userId;

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeCubit(this.repo, {this.sessionId, required this.userId})
      : super(HomeInitial());

  final List<MessageModel> messages = [];
  final ScrollController scrollController = ScrollController();

  // ---------------- INIT ----------------
  // void init() {
  //   if (sessionId != null) {
  //     fetchOldMessages();
  //   }
  // }

  // ---------------- OLD CHAT ----------------
  // Future<void> fetchOldMessages() async {
  //   emit(HomeLoading());
  //
  //   final result = await repo.fetchMessages(sessionId!);
  //
  //   result.fold(
  //     (error) {
  //       emit(HomeError(error: error));
  //     },
  //     (oldMessages) {
  //       messages
  //         ..clear()
  //         ..addAll(oldMessages);
  //
  //       emit(HomeMessagesUpdated());
  //       _scrollToBottom();
  //     },
  //   );
  // }

  // ---------------- SEND MESSAGE ----------------
  Future<void> sendUserMessage(String message) async {
    // 1️⃣ لو أول رسالة وشات جديد
    if (sessionId == null) {
      final startResult = await repo.startChat();

      startResult.fold(
        (error) {
          emit(HomeError(error: error));
          return;
        },
        (startResponse) {
          sessionId = startResponse;
        },
      );
    }

    // 2️⃣ رسالة المستخدم
    messages.add(
      MessageModel(
        message: message,
        messageType: MessageType.text,
        sender: MessageSender.user,
      ),
    );
    emit(HomeMessagesUpdated());
    _scrollToBottom();

    // Loading bubble
    final loadingMessage = MessageModel(
      message: '',
      messageType: MessageType.loading,
      sender: MessageSender.bot,
    );
    messages.add(loadingMessage);
    emit(HomeMessagesUpdated());
    _scrollToBottom();

    // 3️⃣ إرسال الرسالة
    final result = await repo.sendMessage(
      sessionId: sessionId!,
      message: message,
      userId: userId,
    );

    // شيل الـ loading
    messages.remove(loadingMessage);

    result.fold(
          (error) {
        messages.add(
          MessageModel(
            message: error,
            messageType: MessageType.error,
            sender: MessageSender.bot,
          ),
        );
        emit(HomeMessagesUpdated());
      },
          (chatResponse) {
        messages.add(
          MessageModel(
            message: chatResponse.message,
            messageType: chatResponse.cars.isEmpty
                ? MessageType.text
                : MessageType.hasData,
            sender: MessageSender.bot,
            cars: chatResponse.cars,
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
