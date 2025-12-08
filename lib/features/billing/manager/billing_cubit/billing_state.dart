abstract class BillingState {}

class BillingInitial extends BillingState {}

class BillingFilterChangedState extends BillingState {}

class BillingSortChangedState extends BillingState {}

class BillingSearchState extends BillingState {}

class BillingOverlayOpened extends BillingState {}

class BillingOverlayClosed extends BillingState {}
