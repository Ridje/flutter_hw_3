import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_3/tasks/domain/warmup_app_use_case.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/state/change_language.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/state/language_state.dart';
import 'package:flutter_hw_3/tasks/presentation/change_language/widget/change_language_action.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task_event.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task_state.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/widget/task_add_save_button.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/widget/task_list.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/widget/task_name_text_field.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/widget/task_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hw_3/tasks/service/glob_var.dart';

main() async {
  configureDependencies();
  await getIt<WarmupAppUseCase>().call();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LanguageBloc>()..add(InitLanguageEvent()),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Tasks tracker application',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            locale: state.selectedLanguage.value,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static final _formKey = GlobalKey<FormState>();

  void _handleButtonPress(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final taskBloc = context.read<TasksBloc>();

      if (taskBloc.state.edit == null) {
        taskBloc.add(AddTask());
      } else {
        taskBloc.add(SaveTask());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TasksBloc>()..add(LoadTasks()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(AppLocalizations.of(context)!.myTasks),
          actions: const [ChangeLanguageAction()],
        ),
        body: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) => PopScope(
            canPop: state.edit == null && state.showLoader == false,
            onPopInvoked: (didPop) {
              if (!didPop && state.edit != null) {
                context.read<TasksBloc>().add(CancelledEditTask());
              }
            },
            child: Stack(children: [
              Form(
                key: _formKey, 
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TasksTitle(),
                      const SizedBox(height: 18),
                      TaskNameTextField(onEditingCompleted: _handleButtonPress, formKey: _formKey),
                      const SizedBox(height: 18),
                      AddSaveTaskButton(
                          onButtonPressed: _handleButtonPress,
                          title: state.edit == null ? AppLocalizations.of(context)!.addTask : AppLocalizations.of(context)!.updateTask),
                      const SizedBox(height: 18),
                      const Expanded(child: TaskList()),
                    ],
                  ),
                ),
              ),
              state.showLoader ? const LoaderTransparent(colorValue: Colors.transparent) : Container()
            ]),
          ),
        ),
      ),
    );
  }
}

class LoaderTransparent extends StatelessWidget {
  final Color colorValue;
  const LoaderTransparent({super.key, required this.colorValue});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black38,
        child: const Center(
            child: SizedBox(
                height: 60.0,
                width: 60.0,
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue), strokeWidth: 5.0))));
  }
}
