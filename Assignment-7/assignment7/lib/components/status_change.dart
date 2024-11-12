import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/task_controller.dart';
import '../style/style.dart';
TaskController task=Get.find();
void showStatusChangeSheet(BuildContext context, double mdw,double mdh,String status,String id) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Status Change",
                style: Task_Card_Title(mdw),
              ),
            ),
             Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(child: status_changer_button(mdw, mdh, status=="New"?"assets/checked.png":"assets/new.png", status=="New"?"Completed":"New"),onTap: (){
                  task.update_STATUS(id,status, status=="New"?"Completed":"New").then((_)async{

                  });
                },),
                GestureDetector(child: status_changer_button(mdw, mdh, "assets/work-in-progress.png", "Progress"),onTap: (){
                  task.update_STATUS(id, status,"Progress");
                },),
                GestureDetector(child: status_changer_button(mdw, mdh, "assets/prohibition.png", "Cancelled"),onTap: (){
                  task.update_STATUS(id,status, "Cancelled");
                },),
              ],
            )
          ],
        ),
      );
    },
  );
}
Widget status_changer_button(double mdw,double mdh,String picurl,String txt)
{
  return Container(
    decoration: BoxDecoration(
        color: Color(0xFFdee2e6),
        borderRadius: BorderRadius.circular(24)
    ),
    height: mdh*0.125,
    width: mdw*0.25,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("$picurl",width: mdw*0.12,),
        SizedBox(height: mdh*0.005,),
        Text("$txt",style: Sum_Tile_Title(mdw),)
      ],
    ),
  );
}