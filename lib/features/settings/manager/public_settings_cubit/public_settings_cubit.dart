import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import 'public_settings_state.dart';

class PublicSettingsCubit extends Cubit<PublicSettingsState> {
  PublicSettingsCubit() : super(PublicSettingsInitial());

  static PublicSettingsCubit get(context) => BlocProvider.of(context);

  String selectedAppearance = AppStrings.dark;
  String selectedLanguage = AppStrings.arabic;
  String selectedCountry = AppStrings.egy;
  String selectedVoiceover = AppStrings.auto;
  String selectedCity = AppStrings.gada;
  List<String> appearanceItems = [AppStrings.light, AppStrings.dark];
  List<String> languageItems = [AppStrings.arabic, AppStrings.english];
  List<String> countryItems = [AppStrings.egy];
  List<String> voiceoverItems = [AppStrings.auto];
  List<String> cityItems = [AppStrings.gada];

  void changeAppearance(String value) {
    selectedAppearance = value;
    emit(PublicSettingsSelected());
  }

  void changeLanguage(String value) {
    selectedLanguage = value;
    emit(PublicSettingsSelected());
  }

  void changeCountry(String value) {
    selectedCountry = value;
    emit(PublicSettingsSelected());
  }

  void changeVoiceover(String value) {
    selectedVoiceover = value;
    emit(PublicSettingsSelected());
  }

  void changeCity(String value) {
    selectedCity = value;
    emit(PublicSettingsSelected());
  }
}
