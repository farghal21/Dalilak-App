import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/app_strings.dart';
import '../data/models/inspection_item.dart';
import 'car_inspection_state.dart';

class CarInspectionCubit extends Cubit<CarInspectionState> {
  CarInspectionCubit() : super(CarInspectionInitial()) {
    _initializeInspectionItems();
  }

  // مفتاح الحفظ في SharedPreferences
  static const String _storageKey = 'car_inspection_data_v2';

  // قائمة بنود الفحص
  final List<InspectionItem> _inspectionItems = [];

  void _initializeInspectionItems() async {
    final savedData = await _loadSavedData();

    if (savedData != null && savedData.isNotEmpty) {
      // لو فيه داتا محفوظة نستخدمها
      _inspectionItems.addAll(savedData);
    } else {
      // الداتا الافتراضية من AppStrings
      _inspectionItems.addAll([
        InspectionItem(
          title: AppStrings.inspectionItem1Title,
          hint: AppStrings.inspectionItem1Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem2Title,
          hint: AppStrings.inspectionItem2Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem3Title,
          hint: AppStrings.inspectionItem3Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem4Title,
          hint: AppStrings.inspectionItem4Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem5Title,
          hint: AppStrings.inspectionItem5Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem6Title,
          hint: AppStrings.inspectionItem6Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem7Title,
          hint: AppStrings.inspectionItem7Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem8Title,
          hint: AppStrings.inspectionItem8Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem9Title,
          hint: AppStrings.inspectionItem9Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem10Title,
          hint: AppStrings.inspectionItem10Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem11Title,
          hint: AppStrings.inspectionItem11Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem12Title,
          hint: AppStrings.inspectionItem12Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem13Title,
          hint: AppStrings.inspectionItem13Hint,
        ),
        InspectionItem(
          title: AppStrings.inspectionItem14Title,
          hint: AppStrings.inspectionItem14Hint,
        ),
      ]);
    }

    _emitUpdatedState();
  }

  // تحميل البيانات المحفوظة
  Future<List<InspectionItem>?> _loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(_storageKey);

      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList
            .map(
                (item) => InspectionItem.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Error loading saved data: $e');
    }
    return null;
  }

  // حفظ البيانات
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _inspectionItems.map((item) => item.toJson()).toList();
      await prefs.setString(_storageKey, json.encode(jsonList));
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  // تبديل حالة البند
  void toggleItem(int index) {
    if (index >= 0 && index < _inspectionItems.length) {
      _inspectionItems[index] = _inspectionItems[index].copyWith(
        isChecked: !_inspectionItems[index].isChecked,
      );
      _emitUpdatedState();
      _saveData();
    }
  }

  // إرسال الحالة المحدثة
  void _emitUpdatedState() {
    final checkedCount =
        _inspectionItems.where((item) => item.isChecked).length;
    final totalCount = _inspectionItems.length;
    final percentage = totalCount > 0 ? (checkedCount / totalCount) * 100 : 0.0;

    emit(CarInspectionUpdated(
      inspectionItems: List.from(_inspectionItems),
      checkedCount: checkedCount,
      totalCount: totalCount,
      percentage: percentage,
    ));
  }

  // إعادة تعيين الكل
  void resetAll() {
    for (int i = 0; i < _inspectionItems.length; i++) {
      _inspectionItems[i] = _inspectionItems[i].copyWith(isChecked: false);
    }
    _emitUpdatedState();
    _saveData();
  }

  // مسح الداتا المحفوظة (للتطوير)
  Future<void> clearSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
    } catch (e) {
      print('Error clearing saved data: $e');
    }
  }
}
