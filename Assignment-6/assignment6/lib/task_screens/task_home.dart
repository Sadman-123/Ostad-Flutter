import 'package:flutter/material.dart';
import 'package:task_manager/task_screens/task_cancelledtask.dart';
import 'package:task_manager/task_screens/task_completedtask.dart';
import 'package:task_manager/task_screens/task_newtask.dart';
import 'package:task_manager/task_screens/task_progresstask.dart';
import '../components/myappbar.dart';
class TaskHome extends StatefulWidget {
  @override
  State<TaskHome> createState() => _TaskHomeState();
}
class _TaskHomeState extends State<TaskHome> {
  int ind=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Myappbar(autobar: false),
      body: IndexedStack(
        index: ind,
        children: [
          TaskNewtask(),
          TaskCompletedtask(),
          TaskCancelledtask(),
          TaskProgresstask(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            ind=value;
          });
        },
        selectedIndex: ind,
        destinations: [
          NavigationDestination(icon: Icon(Icons.new_label_rounded), label: "New Task"),
          NavigationDestination(icon: Icon(Icons.check), label: "Completed"),
          NavigationDestination(icon: Icon(Icons.cancel), label: "Cancelled"),
          NavigationDestination(icon: Icon(Icons.timelapse_outlined), label: "Progress"),
        ],
      ),
    );
  }
}
