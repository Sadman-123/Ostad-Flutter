import 'package:flutter/material.dart';
import 'package:task_manager/components/status_change.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/style/style.dart';
import 'package:get/get.dart';
TaskController task=Get.find();
class TaskCards extends StatelessWidget{
  final String title;
  final String description;
  final String status;
  final Color label_bg;
  final String createdDate;
  final String id;
  const TaskCards({super.key, required this.title, required this.description, required this.status, required this.createdDate, required this.id, required this.label_bg});
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.sizeOf(context).width;
    var mdh=MediaQuery.sizeOf(context).height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(24)
      ),
      width: mdw*0.95,
      height: mdh*0.31,
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: mdw*0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$title",style: Task_Card_Title(mdw)),
                SizedBox(height: mdh*0.002,),
                Text("$description",style: Task_Card_Content(mdw),maxLines: 2),
                SizedBox(height: mdh*0.005,),
                Text("Date: ${createdDate.split("T")[0]}",style: Task_Card_Date(mdw),)
              ],
            ),
          ),
          SizedBox(height: mdh*0.02,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Badge(label: Text("$status",style: TextStyle(fontSize: mdw*0.04,fontFamily: "apple"),),padding: EdgeInsets.all(10),backgroundColor: label_bg,),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(onPressed: (){showStatusChangeSheet(context,mdw,mdh,status,id,);}, icon: Icon(Icons.edit,color: Color(0xFFabff4f),))
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(onPressed: (){
                            task.Delete_Task(id,status);
                            }, icon: Icon(Icons.delete,color: Color(0xFFf21b3f),))
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}