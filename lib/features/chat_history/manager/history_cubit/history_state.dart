abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistorySearchState extends HistoryState {
  final List<Map<String, dynamic>> results;

  HistorySearchState({required this.results});
}
