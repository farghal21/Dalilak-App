import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import 'hisroty_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial()) {
    applyFilter();
  }

  static HistoryCubit get(context) => BlocProvider.of(context);

  String selectedFilter = AppStrings.online;

  final List<int> selectedItems = [];

  List<Map<String, dynamic>> filteredItems = [];

  final List<Map<String, dynamic>> allFaz3aItems = [
    {"name": "محمد. د", "status": AppStrings.online},
    {"name": "محمد. د", "status": AppStrings.online},
    {"name": "محمد. د", "status": AppStrings.online},
    {"name": "محمد. د", "status": AppStrings.online},
    {"name": "أحمد. م", "status": AppStrings.offline},
    {"name": "أحمد. م", "status": AppStrings.offline},
    {"name": "أحمد. م", "status": AppStrings.offline},
    {"name": "سارة. ك", "status": AppStrings.online},
    {"name": "نور", "status": AppStrings.favorite},
    {"name": "نور", "status": AppStrings.favorite},
    {"name": "نور", "status": AppStrings.favorite},
    {"name": "علي", "status": AppStrings.offline},
  ];

  final filters = [
    {
      'title': AppStrings.online,
      'icon': AppAssets.onlineIcon,
      'color': Color(0xFF182759)
    },
    {
      'title': AppStrings.offline,
      'icon': AppAssets.offlineIcon,
      'color': Color(0xFF3B3B70)
    },
    {
      'title': AppStrings.favorite,
      'icon': AppAssets.favoriteIcon,
      'color': Color(0xFF9C27B0)
    },
  ];

  void applyFilter() {
    if (selectedFilter == AppStrings.online) {
      filteredItems =
          allFaz3aItems.where((e) => e["status"] == AppStrings.online).toList();
    } else if (selectedFilter == AppStrings.offline) {
      filteredItems = allFaz3aItems
          .where((e) => e["status"] == AppStrings.offline)
          .toList();
    } else if (selectedFilter == AppStrings.favorite) {
      filteredItems = allFaz3aItems
          .where((e) => e["status"] == AppStrings.favorite)
          .toList();
    } else {
      filteredItems = List.from(allFaz3aItems);
    }
    emit(HistoryFilter());
  }

  void askFaz3a() {
    emit(HistoryLoading());
    Future.delayed(const Duration(seconds: 2), () {
      emit(HistorySuccess("تم إرسال طلبك بنجاح"));
    });
  }

  void toggleSelectedItem(int index) {
    if (selectedItems.contains(index)) {
      selectedItems.remove(index);
    } else {
      selectedItems.add(index);
    }
    emit(HistoryFilter());
  }

  void changeFilter(String value) {
    selectedFilter = value;
    applyFilter();
  }
}
