import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksTitle extends StatelessWidget {
  const TasksTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.tasks, style: Theme.of(context).textTheme.headlineSmall);
  }
}
