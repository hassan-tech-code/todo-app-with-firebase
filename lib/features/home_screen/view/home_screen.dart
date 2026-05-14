import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_class/core/widgets/text_widgets.dart';
import 'package:todo_app_class/features/drawer/view/drawer.dart';
import 'package:todo_app_class/features/home_screen/view/add_task_button.dart';
import 'package:todo_app_class/features/home_screen/view/edit_task.dart';
import 'package:todo_app_class/features/home_screen/view_model/task_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('todo')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .snapshots(includeMetadataChanges: true),
      builder: (context, snapshot) {
        //var rawTimeStamp=snapshot.data.docs
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Todo App Home'),
              actions: [AddTaskButton(), SizedBox(width: 14)],
            ),
            body: Center(child: Text('No tasks found')),
          );
        }
        return Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: const Text('Todo App Home'),
            actions: [AddTaskButton(), SizedBox(width: 14)],
          ),
          body: ListView.builder(
            itemCount: snapshot.data!.docs.length,

            itemBuilder: (context, index) {
              final myTaskData = snapshot.data!.docs[index];
              String myTaskDate = myTaskData['timestamp'] != null
                  ? DateFormat(
                      'MMMM d, h:mm a',
                    ).format((myTaskData['timestamp'] as Timestamp).toDate())
                  : 'Getting date and time....';
              return Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),

                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 7,

                  leading: IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      context.read<TaskProvider>().toggleTask(
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index]['is_completed'],
                      );
                    },
                    icon: Icon(
                      snapshot.data!.docs[index]['is_completed']
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  isThreeLine: true,
                  title: MediumText(text: myTaskData['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallText(
                        text: myTaskData['description'],
                        myFontSize: 14,
                      ),
                      SizedBox(height: 2),
                      SmallText(
                        text: myTaskDate.toString(),
                        myFontSize: 12,
                        myTextColor: Colors.grey,
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 0, minHeight: 0),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                          onTap: () {
                            context.read<TaskProvider>().loadTaskData(
                              snapshot.data!.docs[index]['title'],
                              snapshot.data!.docs[index]['description'],
                            );
                            showDialog(
                              context: context,
                              builder: (context) => EditTask(
                                docId: snapshot.data!.docs[index].id,
                              ),
                            );
                          },
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          onTap: () => context.read<TaskProvider>().deleteTask(
                            snapshot.data!.docs[index].id,
                          ),
                          child: Text('Delete'),
                        ),
                      ];
                    },
                  ),
                ),
              );
            },
          ),
          // floatingActionButton: AddTaskButton(),
        );
      },
    );
  }
}
