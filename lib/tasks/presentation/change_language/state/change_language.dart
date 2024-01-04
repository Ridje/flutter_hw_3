import 'package:flutter_hw_3/tasks/presentation/change_language/state/language.dart';

abstract class LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final Language? newLanguage;

  ChangeLanguageEvent({required this.newLanguage});
}

class InitLanguageEvent extends LanguageEvent {}
