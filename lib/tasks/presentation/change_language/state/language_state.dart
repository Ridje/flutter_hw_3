import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_3/tasks/domain/localization_use_case.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/state/change_language.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/state/language.dart';
import 'package:injectable/injectable.dart';

class LanguageState {
  final Language selectedLanguage;

  const LanguageState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.english;
}

@Injectable()
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetLocalizationUseCase getLocaleUseCase;
  final SaveLocalizationUseCase saveLocaleUseCase;

  LanguageBloc(this.getLocaleUseCase, this.saveLocaleUseCase) : super(const LanguageState(selectedLanguage: null)) {
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
