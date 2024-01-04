import 'package:flutter_hw_3/tasks/data/repository/localization_repository.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/state/language.dart';

final localisationRepository = LocalisationRepository();

class SaveLocalizationUseCase {
    void call(Language? language) {
      localisationRepository.saveLanguage(language);
    }
}

class GetLocalizationUseCase {
  Language? call() {
    return localisationRepository.getLanguage();  
  }
}