import 'package:flutter_bloc/flutter_bloc.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  static HistoryCubit get(context) => BlocProvider.of(context);

  // -------------------- Data --------------------
  final List<Map<String, dynamic>> historyData = [
    {
      "name": "مشاكل الفتيس",
      "lastInteraction": 1, // يوم
    },
    {
      "name": "سعر تغيير طقم دبرياج",
      "lastInteraction": 3,
    },
    {
      "name": "افضل عربية في فئتها",
      "lastInteraction": 7,
    },
    {
      "name": "صرف بنزين عالي",
      "lastInteraction": 2,
    },
    {
      "name": "مقارنة كيا ضد هوندا",
      "lastInteraction": 5,
    },
    {
      "name": "علامات تلف البوجيهات",
      "lastInteraction": 10,
    },
    {
      "name": "ايه احسن زيت للموتور",
      "lastInteraction": 14,
    },
  ];

  void historySearch(String query) {
    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      emit(HistorySearchState(results: historyData));
      return;
    }

    final results = historyData.where((item) {
      return item["name"].toString().toLowerCase().contains(q);
    }).toList();

    emit(HistorySearchState(results: results));
  }
}
