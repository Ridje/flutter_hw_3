import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/state/change_language.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/state/language.dart';

class LanguageState {
  final Language selectedLanguage;

  const LanguageState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.english;
}

class LanguageBloc extends Bloc<ChangeLanguage, LanguageState> {
  LanguageBloc() : super(const LanguageState(selectedLanguage: null)) {
    on<ChangeLanguage>((event, emit) {
      emit(LanguageState(selectedLanguage: event.newLanguage));
    });
  }
}
