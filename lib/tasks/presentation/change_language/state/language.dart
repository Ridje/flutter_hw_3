import 'dart:ui';

enum Language {
  english(
    value: Locale('en'),
    text: 'English',
  ),
  kz(
    value: Locale('kk'),
    text: 'Қазақ',
  ),
  russian(
    value: Locale('ru'),
    text: 'Русский',
  );



  final Locale value;
  final String text;

  const Language({required this.value, required this.text});
}
