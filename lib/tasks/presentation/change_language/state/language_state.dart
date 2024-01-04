import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_3/tasks/domain/localization_use_case.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/state/change_language.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/state/language.dart';

class LanguageState {
  final Language selectedLanguage;

  const LanguageState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.english;
}

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final getLocaleUseCase = GetLocalizationUseCase();
  final saveLocaleUseCase = SaveLocalizationUseCase();

  LanguageBloc() : super(const LanguageState(selectedLanguage: null)) {
    on<InitLanguageEvent>((event, emit) {
      emit(initLanguage());
    });
    on<ChangeLanguageEvent>((event, emit) {
      emit(onLanguageChanged(event.newLanguage));
    });
  }

  LanguageState onLanguageChanged(Language? newLanguage) {
    saveLocaleUseCase(newLanguage);
    return LanguageState(selectedLanguage: newLanguage);
  }

  LanguageState initLanguage() {
    return LanguageState(selectedLanguage: getLocaleUseCase());
  }
}
