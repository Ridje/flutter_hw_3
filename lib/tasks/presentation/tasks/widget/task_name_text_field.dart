import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task_event.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskNameTextField extends StatefulWidget {
  final Function(BuildContext) onEditingCompleted;
  final GlobalKey<FormState> formKey;
  const TaskNameTextField({
    super.key,
    required this.onEditingCompleted,
    required this.formKey,
  });

  @override
  State<StatefulWidget> createState() {
    return _TaskNameTextFieldState();
  }
}

class _TaskNameTextFieldState extends State<TaskNameTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state.input != _controller.text) {
          _controller.text = state.input;
        }
      },
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.taskNameIsEmpty;
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: AppLocalizations.of(context)!.taskName,
        ),
        onChanged: (value) => {context.read<TasksBloc>().add(InputChangedTask(newInput: value))},
        controller: _controller,
        onEditingComplete: () => {widget.onEditingCompleted(context)},
      ),
    );
  }
}
