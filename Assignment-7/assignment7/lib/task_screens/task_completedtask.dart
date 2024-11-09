import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/task_cards.dart';
import '../controller/task_controller.dart';
import '../style/style.dart';
class TaskCompletedtask extends StatelessWidget{
  TaskController task=Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Obx(() {
        print(task.Completed_Tasks);
        return ListView.builder(
          itemCount: task.Completed_Tasks.length,
          itemBuilder: (context, index) {
            return TaskCards(
              label_bg: Completed_Task_Label_Color,
              id: task.Completed_Tasks[index]['_id'] ?? '',
              title: task.Completed_Tasks[index]['title'] ?? 'No Title',
              description: task.Completed_Tasks[index]['description'] ?? 'No Description',
              createdDate: task.Completed_Tasks[index]['createdDate'] ?? 'Unknown Date',
              status: task.Completed_Tasks[index]['status'] ?? 'Unknown Status',
            );
          },
        );
      }),
    );
  }
}