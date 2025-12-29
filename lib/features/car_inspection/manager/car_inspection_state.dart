import '../data/models/inspection_item.dart';

abstract class CarInspectionState {}

class CarInspectionInitial extends CarInspectionState {}

class CarInspectionUpdated extends CarInspectionState {
  final List<InspectionItem> inspectionItems;
  final int checkedCount;
  final int totalCount;
  final double percentage;

  CarInspectionUpdated({
    required this.inspectionItems,
    required this.checkedCount,
    required this.totalCount,
    required this.percentage,
  });
}
