import 'package:flutter/material.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/style/style.dart';
import 'package:get/get.dart';
import '../components/myappbar.dart';
import '../components/mybutton.dart';
class TaskNewtaskAdd extends StatelessWidget{
  TaskController task=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.sizeOf(context).width;
    var mdh=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: Myappbar(autobar: true,),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            background_img("assets/background.svg"),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  height: mdh*0.75,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: mdw*0.79,
                                child: Column(
                                  children: [
                                    Text("Add New Task",style: H1text(mdw),),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                )
                            ),
                            SizedBox(height: mdh*0.035,),
                            TextFormField(
                              controller: task.subject,
                              decoration: InputDecoration(
                                  hintText: "Subject"
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            TextFormField(
                              controller: task.description,
                              maxLines: 10,
                              decoration: InputDecoration(
                                hintText: "Description",
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            Mybutton(onpressed: (){
                              task.insert_to_task();
                            },something: Icon(Icons.navigate_next),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}