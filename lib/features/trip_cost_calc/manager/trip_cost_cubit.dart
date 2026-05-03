import 'package:flutter_bloc/flutter_bloc.dart';
import 'trip_cost_state.dart';

class TripCostCubit extends Cubit<TripCostState> {
  TripCostCubit({String? initialConsumption}) : super(TripCostInitial()) {
    // تعيين القيم الافتراضية
    _distance = '0';
    _consumption = initialConsumption ?? '8.5';
    _fuelPrice = '13.75';
    _selectedFuelType = 92;

    _calculate();
  }

  String _distance = '';
  String _consumption = '8.5';
  String _fuelPrice = '13.75';
  int _selectedFuelType = 92;

  void updateDistance(String value) {
    _distance = value;
    _calculate();
  }

  void updateConsumption(String value) {
    _consumption = value;
    _calculate();
  }

  // ✅ التعديل هنا: دالة تحديث السعر اليدوي
  void updateFuelPrice(String value) {
    _fuelPrice = value;

    // 👇 السطر ده هو الحل: بنخلي النوع 0 عشان نفصل السعر عن زراير 92 و 95
    _selectedFuelType = 0;

    _calculate();
  }

  // دالة اختيار نوع البنزين من الزراير
  void selectFuelType(int type, String price) {
    _selectedFuelType = type;
    _fuelPrice = price; // بنحدث السعر بناء على الزرار
    _calculate();
  }

  void _calculate() {
    final distance = double.tryParse(_distance) ?? 0.0;
    final consumption = double.tryParse(_consumption) ?? 0.0;

    // هنا بنستخدم _fuelPrice اللي اتحدثت سواء من الكتابة اليدوية أو من الزرار
    final price = double.tryParse(_fuelPrice) ?? 0.0;

    final litersNeeded = (distance / 100) * consumption;
    final totalCost = litersNeeded * price;

    emit(TripCostUpdated(
      distance: _distance,
      consumption: _consumption,
      fuelPrice: _fuelPrice,
      selectedFuelType: _selectedFuelType,
      totalCost: totalCost,
      litersNeeded: litersNeeded,
    ));
  }
}
