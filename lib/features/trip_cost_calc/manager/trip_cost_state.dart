class TripCostState {}

class TripCostInitial extends TripCostState {}

class TripCostUpdated extends TripCostState {
  final String distance;
  final String consumption;
  final String fuelPrice;
  final int selectedFuelType;
  final double totalCost;
  final double litersNeeded;

  TripCostUpdated({
    required this.distance,
    required this.consumption,
    required this.fuelPrice,
    required this.selectedFuelType,
    required this.totalCost,
    required this.litersNeeded,
  });
}
