import 'package:dalilak_app/features/chat_history/data/models/get_chat_history_response_model.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoadSuccess extends HistoryState {
  final List<Sessions> history;
  HistoryLoadSuccess({required this.history});
}

class HistoryAction extends HistoryState {
  final String message;
  HistoryAction({required this.message});
}

class HistoryError extends HistoryState {
  final String error;
  HistoryError({required this.error});
}
