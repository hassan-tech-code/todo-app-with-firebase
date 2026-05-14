import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_class/core/widgets/custom_textfield.dart';
import 'package:todo_app_class/features/home_screen/view_model/task_view_model.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: AlertDialog(
              title: Text('Add Todo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    myHintText: 'Add task title',
                    myController: context.read<TaskProvider>().titleController,
                  ),
                  CustomTextField(
                    myHintText: 'Add task description',
                    myController: context
                        .read<TaskProvider>()
                        .descriptionController,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Cancel logic here
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Add task logic here
                    context.read<TaskProvider>().addTask();
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
      icon: Icon(Icons.add),
    );
  }
}
