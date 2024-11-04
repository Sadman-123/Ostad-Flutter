import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/task_screens/task_cancelledtask.dart';
import 'package:task_manager/task_screens/task_completedtask.dart';
import 'package:task_manager/task_screens/task_newtask.dart';
import 'package:task_manager/task_screens/task_progresstask.dart';
import '../components/myappbar.dart';
import '../controller/task_controller.dart';
class TaskHome extends StatefulWidget {
  @override
  State<TaskHome> createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Myappbar(autobar: false),
      body: Obx(() => IndexedStack(
        index: taskController.selectedIndex.value,
        children: [
          TaskNewtask(),
          TaskCompletedtask(),
          TaskCancelledtask(),
          TaskProgresstask(),
        ],
      )),
      bottomNavigationBar: Obx(() => NavigationBar(
        onDestinationSelected: (value) {
          taskController.changeIndex(value);
        },
        selectedIndex: taskController.selectedIndex.value,
        destinations: [
          NavigationDestination(icon: Icon(Icons.new_label_rounded), label: "New Task"),
          NavigationDestination(icon: Icon(Icons.check), label: "Completed"),
          NavigationDestination(icon: Icon(Icons.cancel), label: "Cancelled"),
          NavigationDestination(icon: Icon(Icons.timelapse_outlined), label: "Progress"),
        ],
      )),
    );
  }
}
