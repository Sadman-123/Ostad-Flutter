import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/task_controller.dart';
import '../style/style.dart';
import '../components/task_cards.dart';
class TaskCancelledtask extends StatelessWidget{
  TaskController task=Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Obx(() {
        print(task.Cancelled_Tasks);
        return ListView.builder(
          itemCount: task.Cancelled_Tasks.length,
          itemBuilder: (context, index) {
            return TaskCards(
              label_bg: Cancelled_Task_Label_Color,
              id: task.Cancelled_Tasks[index]['_id'] ?? '',
              title: task.Cancelled_Tasks[index]['title'] ?? 'No Title',
              description: task.Cancelled_Tasks[index]['description'] ?? 'No Description',
              createdDate: task.Cancelled_Tasks[index]['createdDate'] ?? 'Unknown Date',
              status: task.Cancelled_Tasks[index]['status'] ?? 'Unknown Status',
            );
          },
        );
      }),
    );
  }
}