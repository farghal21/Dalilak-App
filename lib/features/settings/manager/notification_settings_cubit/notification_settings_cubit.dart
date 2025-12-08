import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import 'notification_settings_state.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  NotificationSettingsCubit() : super(NotificationSettingsInitial());

  static NotificationSettingsCubit get(context) =>
      BlocProvider.of<NotificationSettingsCubit>(context);

  String selectedInternalNotification = AppStrings.enable;
  String selectedExternalNotification = AppStrings.cancel;

  List<String> notificationItems = [
    AppStrings.enable,
    AppStrings.cancel,
  ];

  void changeInternalNotification(String newValue) {
    selectedInternalNotification = newValue;
    emit(NotificationSettingsSelected());
  }

  void changeExternalNotification(String newValue) {
    selectedExternalNotification = newValue;
    emit(NotificationSettingsSelected());
  }
}
