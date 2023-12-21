import 'package:flutter/material.dart';

class AddSaveTaskButton extends StatelessWidget {
  final Function(BuildContext) onButtonPressed;
  final String title;

  const AddSaveTaskButton(
      {super.key, required this.onButtonPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {onButtonPressed}, child: Text(title));
  }
}
