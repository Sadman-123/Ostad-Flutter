import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/components/status_change.dart';
import 'package:task_manager/style/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class TaskCards extends StatefulWidget{
  final String title;
  final String description;
  final String status;
  final Color label_bg;
  final String createdDate;
  final String id;
  final VoidCallback Refresh;
  const TaskCards({super.key, required this.title, required this.description, required this.status, required this.createdDate, required this.id, required this.label_bg, required this.Refresh});

  @override
  State<TaskCards> createState() => _TaskCardsState();
}

class _TaskCardsState extends State<TaskCards> {
  Future<void> getSum_by_Status() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url = Uri.parse("http://35.73.30.144:2005/api/v1/taskStatusCount");
    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': token!,
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(data);
    }
  }
  Future<void>Delete_Task(String id,String status) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url=Uri.parse("http://35.73.30.144:2005/api/v1/deleteTask/$id");
    var res=await http.get(url,headers: {
      'Content-Type':'application/json',
      'token':'$token'
    });
    if(res.statusCode==200)
    {
      widget.Refresh();
      getSum_by_Status();
      Fluttertoast.showToast(
          msg: "Deleted",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFF20be73),
          textColor: Colors.white
      );
    }
  }
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
                Text("${widget.title}",style: Task_Card_Title(mdw)),
                SizedBox(height: mdh*0.002,),
                Text("${widget.description}",style: Task_Card_Content(mdw),maxLines: 2),
                SizedBox(height: mdh*0.005,),
                Text("Date: ${widget.createdDate.split("T")[0]}",style: Task_Card_Date(mdw),)
              ],
            ),
          ),
          SizedBox(height: mdh*0.02,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Badge(label: Text("${widget.status}",style: TextStyle(fontSize: mdw*0.04,fontFamily: "apple"),),padding: EdgeInsets.all(10),backgroundColor: widget.label_bg,),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(onPressed: (){showStatusChangeSheet(context,mdw,mdh,widget.status,widget.id,);}, icon: Icon(Icons.edit,color: Color(0xFFabff4f),))
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(onPressed: (){
                            Delete_Task(widget.id,widget.status);
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