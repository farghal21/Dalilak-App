abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final String message;

  HistorySuccess(this.message);
}

class HistoryFailure extends HistoryState {
  final String error;

  HistoryFailure(this.error);
}

class HistoryFilter extends HistoryState {}
