import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_manager/style/style.dart';
import '../components/myappbar.dart';
import '../components/mybutton.dart';
class TaskNewtaskAdd extends StatefulWidget{
  @override
  State<TaskNewtaskAdd> createState() => _TaskNewtaskAddState();
}
class _TaskNewtaskAddState extends State<TaskNewtaskAdd> {
  TextEditingController subject=TextEditingController();
  TextEditingController description=TextEditingController();
  Future<void> insert_to_task() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (subject.text.isEmpty || description.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Fill Every Box",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red.shade500,
          textColor: Colors.white
      );
      return;
    }
    else {
      var dat = {
        "title": subject.text,
        "description": description.text,
        "status": "New"
      };
      var url = Uri.parse("http://35.73.30.144:2005/api/v1/createTask");
      var res = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'token': '$token'
      }, body: json.encode(dat));
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Task Added Successfully",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color(0xFF20be73),
            textColor: Colors.white
        );
        subject.clear();
        description.clear();
      }
    }
  }
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
                              controller: subject,
                              decoration: InputDecoration(
                                  hintText: "Subject"
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            TextFormField(
                              controller: description,
                              maxLines: 10,
                              decoration: InputDecoration(
                                hintText: "Description",
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            Mybutton(onpressed: (){
                              insert_to_task();
                            },something: Icon(Icons.navigate_next),
                            )
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