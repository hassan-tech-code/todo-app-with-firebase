import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_class/core/widgets/custom_textfield.dart';
import 'package:todo_app_class/features/home_screen/view_model/task_view_model.dart';

class EditTask extends StatelessWidget {
  final String docId;

  const EditTask({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    final myTaskProviderAccesss = context.read<TaskProvider>();
    return AlertDialog(
      title: Text('Edit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            myHintText: 'Edit title',
            myController: myTaskProviderAccesss.titleController,
          ),
          CustomTextField(
            myHintText: 'Edit description',
            myController: myTaskProviderAccesss.descriptionController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            myTaskProviderAccesss.titleController.text = '';
            myTaskProviderAccesss.descriptionController.text = '';
            Navigator.pop(context);
          },
          child: Text('cancel'),
        ),
        TextButton(
          onPressed: () {
            myTaskProviderAccesss.editTask(docId);
            myTaskProviderAccesss.titleController.text = '';
            myTaskProviderAccesss.descriptionController.text = '';
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
