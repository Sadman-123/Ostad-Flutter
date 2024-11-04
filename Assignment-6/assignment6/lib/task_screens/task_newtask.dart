import 'package:flutter/material.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:get/get.dart';
import 'package:task_manager/task_screens/task_newtask_add.dart';
import '../components/task_cards.dart';
import '../style/style.dart';
class TaskNewtask extends StatelessWidget{
  TaskController task=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.sizeOf(context).width;
    var mdh=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: 10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Obx(()=> Text("${task.cancelcount}",style: Sum_Tile_Num(mdw)),),
                      Text("Cancelled",style: Sum_Tile_Title(mdw),)
                    ],
                  ),
                  padding: EdgeInsets.all(5),
                  width: mdw*0.210,
                  decoration: BoxDecoration(
                      color: Color(0xFFdee2e6),
                      borderRadius: BorderRadius.circular(5)
                  ),

                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(()=>Text("${task.completecount}",style: Sum_Tile_Num(mdw)),),
                      Text("Completed",style: Sum_Tile_Title(mdw))
                    ],
                  ),
                  padding: EdgeInsets.all(5),
                  width: mdw*0.23,
                  decoration: BoxDecoration(
                      color: Color(0xFFdee2e6),
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(()=>Text("${task.progresscount}",style: Sum_Tile_Num(mdw)),),
                      Text("Progress",style: Sum_Tile_Title(mdw))
                    ],
                  ),
                  padding: EdgeInsets.all(5),
                  width: mdw*0.210,
                  decoration: BoxDecoration(
                      color: Color(0xFFdee2e6),
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(()=>Text("${task.new_tascount}",style: Sum_Tile_Num(mdw)),),
                      Text("New Task",style: Sum_Tile_Title(mdw))
                    ],
                  ),
                  padding: EdgeInsets.all(5),
                  width: mdw*0.210,
                  decoration: BoxDecoration(
                      color: Color(0xFFdee2e6),
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: mdh*0.015,),
          Expanded(
            child: Container(
              child: Obx(() {
                print(task.New_Tasks);
                return ListView.builder(
                  itemCount: task.New_Tasks.length,
                  itemBuilder: (context, index) {
                    return TaskCards(
                      label_bg: New_Task_Label_Color,
                      id: task.New_Tasks[index]['_id'] ?? '',
                      title: task.New_Tasks[index]['title'] ?? 'No Title',
                      description: task.New_Tasks[index]['description'] ?? 'No Description',
                      createdDate: task.New_Tasks[index]['createdDate'] ?? 'Unknown Date',
                      status: task.New_Tasks[index]['status'] ?? 'Unknown Status',
                    );
                  },
                );
              }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskNewtaskAdd(),));
      },child: Icon(Icons.add),),
    );
  }
}