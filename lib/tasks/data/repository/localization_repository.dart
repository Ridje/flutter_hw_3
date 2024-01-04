import 'package:flutter_hw_3/tasks/presentation/change_language/state/language.dart';
import 'package:hive/hive.dart';

const localizationBox = 'localization_box';
const _localizationKey = "localization_key";

class LocalisationRepository {
  final Box<String?> _myBox = Hive.box(localizationBox);

  Language? getLanguage() {
    var result = _myBox.get(_localizationKey);
    return Language.fromLanguageCode(result);
  }

  void saveLanguage(Language? language) {
    _myBox.put(_localizationKey, language?.languageCode);
  }
}