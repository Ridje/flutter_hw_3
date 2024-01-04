import 'package:flutter_hw_3/tasks/data/repository/localization_repository.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/state/language.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SaveLocalizationUseCase {
  final LocalisationRepository localisationRepository;

  SaveLocalizationUseCase(this.localisationRepository);

  void call(Language? language) {
    localisationRepository.saveLanguage(language);
  }
}

@Injectable()
class GetLocalizationUseCase {
  final LocalisationRepository localisationRepository;

  GetLocalizationUseCase(this.localisationRepository);

  Language? call() {
    return localisationRepository.getLanguage();
  }
}
