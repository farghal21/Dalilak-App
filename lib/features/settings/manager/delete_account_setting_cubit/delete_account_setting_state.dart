abstract class DeleteAccountSettingState {}

class DeleteAccountSettingInitial extends DeleteAccountSettingState {}

class DeleteAccountSettingLoading extends DeleteAccountSettingState {}

class DeleteAccountSettingSuccess extends DeleteAccountSettingState {
  final String message;

  DeleteAccountSettingSuccess({required this.message});
}

class DeleteAccountSettingError extends DeleteAccountSettingState {
  final String errMessage;

  DeleteAccountSettingError({required this.errMessage});
}

class ChangePasswordVisibilityState extends DeleteAccountSettingState {}

class ChangeConfirmPasswordVisibilityState extends DeleteAccountSettingState {}
