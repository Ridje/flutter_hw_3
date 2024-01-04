import 'dart:ui';

enum Language {
  english(
    languageCode: 'en',
    value: Locale('en'),
    text: 'English',
  ),
  kz(
    languageCode: 'kk',
    value: Locale('kk'),
    text: 'Қазақ',
  ),
  russian(
    languageCode: 'ru',
    value: Locale('ru'),
    text: 'Русский',
  );

  final String languageCode;
  final Locale value;
  final String text;

  const Language({required this.languageCode, required this.value, required this.text});

  factory Language.fromLanguageCode(String? languageCode) {
    return switch (languageCode) { 'kk' => Language.kz, 'ru' => Language.russian, _ => Language.english };
  }
}
