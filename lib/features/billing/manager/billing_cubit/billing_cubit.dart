import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_strings.dart';
import 'billing_state.dart';

class BillingCubit extends Cubit<BillingState> {
  BillingCubit() : super(BillingInitial()) {
    // Initialize with all bills on startup
    _applyFiltersAndSort();
  }

  static BillingCubit get(context) => BlocProvider.of(context);

  // -------------------- UI Control --------------------
  bool isFilterExpanded = false;
  bool isSortExpanded = false;

  OverlayEntry? overlayEntry;
  final GlobalKey filterButtonKey = GlobalKey();
  final GlobalKey sortButtonKey = GlobalKey();

  // -------------------- Data --------------------
  final List<Map<String, dynamic>> billsData = [
    {
      'billNumber': '1234567890',
      'billName': 'Electricity Bill',
      'billDate': '2024-06-15',
      'billAmount': 150.00,
      'billStatus': 'Paid',
      'billType': 'book',
    },
    {
      'billNumber': '9876543210',
      'billName': 'Water Bill',
      'billDate': '2024-05-10',
      'billAmount': 45.50,
      'billStatus': 'Unpaid',
      'billType': 'service',
    },
    {
      'billNumber': '4567891230',
      'billName': 'Internet Bill',
      'billDate': '2024-04-25',
      'billAmount': 80.00,
      'billStatus': 'Pending',
      'billType': 'subscription',
    },
    {
      'billNumber': '7418529630',
      'billName': 'Gas Bill',
      'billDate': '2024-03-12',
      'billAmount': 65.20,
      'billStatus': 'Paid',
      'billType': 'service',
    },
    {
      'billNumber': '8529637410',
      'billName': 'Phone Bill',
      'billDate': '2024-07-01',
      'billAmount': 120.00,
      'billStatus': 'Unpaid',
      'billType': 'subscription',
    },
    {
      'billNumber': '3692581470',
      'billName': 'Gym Membership',
      'billDate': '2024-02-18',
      'billAmount': 50.00,
      'billStatus': 'Paid',
      'billType': 'lifestyle',
    },
    {
      'billNumber': '2581473690',
      'billName': 'Insurance Payment',
      'billDate': '2024-08-05',
      'billAmount': 300.00,
      'billStatus': 'Pending',
      'billType': 'finance',
    },
    {
      'billNumber': '1472583690',
      'billName': 'Streaming Service',
      'billDate': '2024-09-20',
      'billAmount': 12.99,
      'billStatus': 'Paid',
      'billType': 'entertainment',
    },
    {
      'billNumber': '9517538520',
      'billName': 'Credit Card Bill',
      'billDate': '2024-06-28',
      'billAmount': 450.00,
      'billStatus': 'Unpaid',
      'billType': 'finance',
    },
    {
      'billNumber': '7539514560',
      'billName': 'Online Course',
      'billDate': '2024-01-11',
      'billAmount': 1200.00,
      'billStatus': 'Paid',
      'billType': 'education',
    },
  ];

  // Filtered and sorted bills to display
  List<Map<String, dynamic>> displayedBills = [];

  // Search query
  String searchQuery = '';

  List<String> selectedFilters = [];
  String selectedSort = AppStrings.byNewest;

  final List<String> filterOptions = [
    AppStrings.lowerThan1000,
    AppStrings.higherThan1000,
    AppStrings.lastMonth,
    AppStrings.last3Months,
    AppStrings.lastYear,
    AppStrings.all,
    AppStrings.completed,
    AppStrings.notCompleted,
    AppStrings.book,
    AppStrings.buy,
  ];

  final List<String> sortOptions = [
    AppStrings.byNewest,
    AppStrings.byOldest,
    AppStrings.byHighestCost,
    AppStrings.byLowestCost,
  ];

  // -------------------- Overlay Logic --------------------

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
    isFilterExpanded = false;
    isSortExpanded = false;
    emit(BillingOverlayClosed());
  }

  void showFilterOverlay(BuildContext context, Widget overlayWidget) {
    if (isFilterExpanded) return removeOverlay();

    removeOverlay();
    isFilterExpanded = true;
    isSortExpanded = false;
    overlayEntry = OverlayEntry(builder: (_) => overlayWidget);
    Overlay.of(context).insert(overlayEntry!);
    emit(BillingOverlayOpened());
  }

  void showSortOverlay(BuildContext context, Widget overlayWidget) {
    if (isSortExpanded) return removeOverlay();

    removeOverlay();
    isSortExpanded = true;
    isFilterExpanded = false;
    overlayEntry = OverlayEntry(builder: (_) => overlayWidget);
    Overlay.of(context).insert(overlayEntry!);
    emit(BillingOverlayOpened());
  }

  // -------------------- Filter Selection --------------------
  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    _applyFiltersAndSort();
    emit(BillingFilterChangedState());
  }

  void toggleSort(String sort) {
    selectedSort = sort;
    removeOverlay();
    _applyFiltersAndSort();
    emit(BillingSortChangedState());
  }

  void removeFilter(String filter) {
    selectedFilters.remove(filter);
    _applyFiltersAndSort();
    emit(BillingFilterChangedState());
  }

  // -------------------- Search Logic --------------------
  void searchInBilling(String query) {
    searchQuery = query.toLowerCase().trim();
    _applyFiltersAndSort();
    emit(BillingSearchState());
  }

  // -------------------- Core Filter & Sort Logic --------------------
  void _applyFiltersAndSort() {
    // Start with all bills
    List<Map<String, dynamic>> result = List.from(billsData);

    // 1. Apply Search
    if (searchQuery.isNotEmpty) {
      result = result.where((bill) {
        return bill['billName']
                .toString()
                .toLowerCase()
                .contains(searchQuery) ||
            bill['billNumber'].toString().toLowerCase().contains(searchQuery) ||
            bill['billStatus'].toString().toLowerCase().contains(searchQuery) ||
            bill['billType'].toString().toLowerCase().contains(searchQuery);
      }).toList();
    }

    // 2. Apply Filters
    if (selectedFilters.isNotEmpty) {
      result = result.where((bill) => _matchesFilters(bill)).toList();
    }

    // 3. Apply Sort
    _sortBills(result);

    displayedBills = result;
  }

  bool _matchesFilters(Map<String, dynamic> bill) {
    for (String filter in selectedFilters) {
      // Amount filters
      if (filter == AppStrings.lowerThan1000) {
        if (bill['billAmount'] >= 1000) return false;
      } else if (filter == AppStrings.higherThan1000) {
        if (bill['billAmount'] < 1000) return false;
      }
      // Date filters
      else if (filter == AppStrings.lastMonth) {
        if (!_isWithinLastMonths(bill['billDate'], 1)) return false;
      } else if (filter == AppStrings.last3Months) {
        if (!_isWithinLastMonths(bill['billDate'], 3)) return false;
      } else if (filter == AppStrings.lastYear) {
        if (!_isWithinLastMonths(bill['billDate'], 12)) return false;
      }
      // Status filters
      else if (filter == AppStrings.completed) {
        if (bill['billStatus'] != 'Paid') return false;
      } else if (filter == AppStrings.notCompleted) {
        if (bill['billStatus'] == 'Paid') return false;
      }
      // Type filters
      else if (filter == AppStrings.book) {
        if (bill['billType'] != 'book') return false;
      } else if (filter == AppStrings.buy) {
        if (bill['billType'] != 'buy') return false;
      }
      // "All" filter - no restriction
      else if (filter == AppStrings.all) {
        continue;
      }
    }
    return true;
  }

  bool _isWithinLastMonths(String dateString, int months) {
    try {
      DateTime billDate = DateTime.parse(dateString);
      DateTime now = DateTime.now();
      DateTime cutoffDate = DateTime(now.year, now.month - months, now.day);
      return billDate.isAfter(cutoffDate);
    } catch (e) {
      return false;
    }
  }

  void _sortBills(List<Map<String, dynamic>> bills) {
    if (selectedSort == AppStrings.byNewest) {
      bills.sort((a, b) => DateTime.parse(b['billDate'])
          .compareTo(DateTime.parse(a['billDate'])));
    } else if (selectedSort == AppStrings.byOldest) {
      bills.sort((a, b) => DateTime.parse(a['billDate'])
          .compareTo(DateTime.parse(b['billDate'])));
    } else if (selectedSort == AppStrings.byHighestCost) {
      bills.sort(
          (a, b) => (b['billAmount'] as num).compareTo(a['billAmount'] as num));
    } else if (selectedSort == AppStrings.byLowestCost) {
      bills.sort(
          (a, b) => (a['billAmount'] as num).compareTo(b['billAmount'] as num));
    }
  }

  // -------------------- Helper Methods --------------------

  /// Get total amount for displayed bills
  double getTotalAmount() {
    return displayedBills.fold(
        0.0, (sum, bill) => sum + (bill['billAmount'] as num));
  }

  /// Get count of bills by status
  int getBillsCountByStatus(String status) {
    return displayedBills.where((bill) => bill['billStatus'] == status).length;
  }

  /// Clear all filters and search
  void clearAllFilters() {
    selectedFilters.clear();
    searchQuery = '';
    _applyFiltersAndSort();
    emit(BillingFilterChangedState());
  }

  @override
  Future<void> close() {
    removeOverlay();
    return super.close();
  }
}
