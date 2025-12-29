import 'package:dalilak_app/features/chat_history/data/models/get_chat_history_response_model.dart';
import 'package:dalilak_app/features/chat_history/data/repos/chat_history_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this.repo) : super(HistoryInitial());
  static HistoryCubit get(context) => BlocProvider.of(context);

  final ChatHistoryRepo repo;

  final List<Sessions> _allHistory = [];

  // ---------- Fetch ----------
  Future<void> fetchChatHistory() async {
    emit(HistoryLoading());

    final result = await repo.fetchChatHistory();
    result.fold(
      (error) {
        if (!isClosed) emit(HistoryError(error: error));
      },
      (data) {
        _allHistory
          ..clear()
          ..addAll(data);

        if (!isClosed)
          emit(HistoryLoadSuccess(history: List.from(_allHistory)));
      },
    );
  }

  // ---------- Search (local) ----------
  void historySearch(String query) {
    if (query.isEmpty) {
      if (!isClosed) emit(HistoryLoadSuccess(history: List.from(_allHistory)));
      return;
    }

    final filtered = _allHistory
        .where(
          (s) => s.name!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    if (!isClosed) emit(HistoryLoadSuccess(history: filtered));
  }

  // ---------- Rename (API) ----------
  Future<void> renameSession({
    required String newName,
    required String sessionId,
  }) async {
    emit(HistoryLoading());

    final result = await repo.renameSession(
      newName: newName,
      sessionId: sessionId,
    );

    result.fold(
      (error) {
        if (!isClosed) emit(HistoryError(error: error));
      },
      (message) {
        if (!isClosed) emit(HistoryAction(message: message));
        fetchChatHistory();
      },
    );
  }

  // ---------- Delete (API) ----------
  Future<void> deleteSession(String sessionId) async {
    emit(HistoryLoading());

    final result = await repo.removeSession(sessionId: sessionId);
    result.fold(
      (error) {
        if (!isClosed) emit(HistoryError(error: error));
      },
      (message) {
        if (!isClosed) emit(HistoryAction(message: message));
        fetchChatHistory();
      },
    );
  }
}
