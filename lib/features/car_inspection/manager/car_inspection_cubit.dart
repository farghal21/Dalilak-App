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
  static const String _storageKey = 'car_inspection_data';

  // قائمة بنود الفحص مع النصائح
  final List<InspectionItem> _inspectionItems = [];

  void _initializeInspectionItems() async {
    // محاولة تحميل البيانات المحفوظة
    final savedData = await _loadSavedData();

    if (savedData != null && savedData.isNotEmpty) {
      // استخدام البيانات المحفوظة
      _inspectionItems.addAll(savedData);
    } else {
      // إنشاء البيانات الافتراضية من AppStrings
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
      ]);
    }

    _emitUpdatedState();
  }

  // تحميل البيانات المحفوظة من SharedPreferences
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
      // في حالة حدوث خطأ، نرجع null ونستخدم البيانات الافتراضية
      print('Error loading saved data: $e');
    }
    return null;
  }

  // حفظ البيانات في SharedPreferences
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> jsonList =
          _inspectionItems.map((item) => item.toJson()).toList();
      final String jsonString = json.encode(jsonList);
      await prefs.setString(_storageKey, jsonString);
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
      _saveData(); // حفظ البيانات بعد كل تغيير
    }
  }

  // حساب النسبة المئوية وإرسال الحالة المحدثة
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

  // إعادة تعيين جميع البنود
  void resetAll() {
    for (int i = 0; i < _inspectionItems.length; i++) {
      _inspectionItems[i] = _inspectionItems[i].copyWith(isChecked: false);
    }
    _emitUpdatedState();
    _saveData(); // حفظ البيانات بعد الإعادة
  }

  // مسح البيانات المحفوظة (اختياري - للتطوير أو إعادة التعيين الكاملة)
  Future<void> clearSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
    } catch (e) {
      print('Error clearing saved data: $e');
    }
  }
}
