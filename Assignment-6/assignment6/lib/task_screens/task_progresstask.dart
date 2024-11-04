import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/style/style.dart';
import '../components/task_cards.dart';
class TaskProgresstask extends StatelessWidget{
  TaskController task=Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Obx(() {
        print(task.Progress_Tasks);
        return ListView.builder(
          itemCount: task.Progress_Tasks.length,
          itemBuilder: (context, index) {
            return TaskCards(
              label_bg: Progress_Task_Label_Color,
              id: task.Progress_Tasks[index]['_id'] ?? '',
              title: task.Progress_Tasks[index]['title'] ?? 'No Title',
              description: task.Progress_Tasks[index]['description'] ?? 'No Description',
              createdDate: task.Progress_Tasks[index]['createdDate'] ?? 'Unknown Date',
              status: task.Progress_Tasks[index]['status'] ?? 'Unknown Status',
            );
          },
        );
      }),
    );
  }
}