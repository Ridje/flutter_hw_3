import 'package:flutter/material.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/widget/change_language_dialog.dart';

class ChangeLanguageAction extends StatelessWidget {
  const ChangeLanguageAction({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {ChangeLanguageDialog.showLanguageBottomSheet(context)},
        child: const Text("Lang"));
  }
}
