import 'package:flutter_bloc/flutter_bloc.dart';
import 'trip_cost_state.dart';

class TripCostCubit extends Cubit<TripCostState> {
  TripCostCubit({String? initialConsumption}) : super(TripCostInitial()) {
    // تعيين القيم الافتراضية
    _distance = '';
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

  void updateFuelPrice(String value) {
    _fuelPrice = value;
    _calculate();
  }

  void selectFuelType(int type, String price) {
    _selectedFuelType = type;
    _fuelPrice = price;
    _calculate();
  }

  void _calculate() {
    final distance = double.tryParse(_distance) ?? 0.0;
    final consumption = double.tryParse(_consumption) ?? 0.0;
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
