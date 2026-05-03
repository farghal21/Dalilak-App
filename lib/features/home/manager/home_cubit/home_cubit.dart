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

  void init() {
    if (sessionId != null) {
      fetchOldMessages();
    }
  }

  Future<void> fetchOldMessages() async {
    emit(HomeLoading());

    final result = await repo.fetchChatMessages(sessionId: sessionId!);

    result.fold(
      (error) {
        if (!isClosed) emit(HomeError(error: error));
      },
      (response) {
        var model = response.messages;
        sessionId = response.sessionId;

        for (var message in model) {
          messages.add(
            MessageModel(
              message: message.message,
              // حماية ضد الـ Null في البيانات القادمة من السيرفر
              messageType:
                  (message.data == null || (message.data?.cars.isEmpty ?? true))
                      ? MessageType.text
                      : MessageType.hasData,
              sender: message.sender == 'user'
                  ? MessageSender.user
                  : MessageSender.bot,
              cars: message.data?.cars ?? [],
            ),
          );
        }

        if (!isClosed) emit(HomeMessagesUpdated());
        _scrollToBottom();
      },
    );
  }

  Future<void> sendUserMessage(String messageText) async {
    // 1️⃣ حماية: لو النص فاضي متعملش حاجة
    if (messageText.trim().isEmpty) return;

    // 2️⃣ لو أول رسالة وشات جديد
    if (sessionId == null) {
      final startResult = await repo.startChat();
      bool isStarted = false;

      startResult.fold(
        (error) {
          if (!isClosed) emit(HomeError(error: error));
          isStarted = false;
        },
        (startResponse) {
          sessionId = startResponse;
          isStarted = true;
        },
      );
      // لو مقدرش يبدأ الجلسة (sessionId بقى null)، نوقف هنا عشان ميعملش كراش
      if (!isStarted || sessionId == null) return;
    }

    // 3️⃣ إضافة رسالة المستخدم للـ UI
    messages.add(
      MessageModel(
        message: messageText,
        messageType: MessageType.text,
        sender: MessageSender.user,
      ),
    );
    if (!isClosed) emit(HomeMessagesUpdated());
    _scrollToBottom();

    // إضافة فقاعة الـ Loading
    final loadingMessage = MessageModel(
      message: '',
      messageType: MessageType.loading,
      sender: MessageSender.bot,
    );
    messages.add(loadingMessage);
    if (!isClosed) emit(HomeMessagesUpdated());
    _scrollToBottom();

    // 4️⃣ إرسال الرسالة للسيرفر (استخدام sessionId! آمن هنا بسبب التحقق فوق)
    final result = await repo.sendMessage(
      sessionId: sessionId!,
      message: messageText,
      userId: userId,
    );

    // إزالة فقاعة الـ Loading قبل معالجة النتيجة
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
        if (!isClosed) emit(HomeMessagesUpdated());
      },
      (chatResponse) {
        messages.add(
          MessageModel(
            message: chatResponse.message,
            // استخدام حماية الـ Null-aware لضمان عدم حدوث TypeError
            messageType: chatResponse.cars.isEmpty
                ? MessageType.text
                : MessageType.hasData,
            sender: MessageSender.bot,
            cars: chatResponse.cars,
          ),
        );
        if (!isClosed) emit(HomeMessagesUpdated());
      },
    );

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }
}
