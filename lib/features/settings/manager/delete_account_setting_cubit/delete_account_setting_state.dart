abstract class DeleteAccountSettingState {}

class DeleteAccountSettingInitial extends DeleteAccountSettingState {}

class DeleteAccountSettingLoading extends DeleteAccountSettingState {}

class DeleteAccountSettingSuccess extends DeleteAccountSettingState {}

class DeleteAccountSettingFailure extends DeleteAccountSettingState {
  final String errorMessage;

  DeleteAccountSettingFailure(this.errorMessage);
}

class DeleteAccountSettingVisibilityToggled extends DeleteAccountSettingState {}
