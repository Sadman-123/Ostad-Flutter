import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/task_screens/task_newtask_add.dart';
import '../components/task_cards.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../style/style.dart';
class TaskNewtask extends StatefulWidget{
  @override
  State<TaskNewtask> createState() => _TaskNewtaskState();
}

class _TaskNewtaskState extends State<TaskNewtask> {
  String cancelcount = "00";
  String completecount = "00";
  String progresscount = "00";
  String new_tascount = "00";
  @override
  void initState() {
    super.initState();
    getSum_by_Status();
    get_new_data();
  }
  Future<void> _refreshData() async {
    setState(() {
      getSum_by_Status();
      get_new_data();
    });
    await Future.delayed(Duration(seconds: 1));
  }
  var lst=[];
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
      for (var item in data['data']) {
        switch (item['_id']) {
          case 'New':
            setState(() {
              new_tascount = item['sum'].toString();
            });
            break;
          case 'Completed':
            setState(() {
              completecount = item['sum'].toString();
            });
            break;
          case 'Progress':
            setState(() {
              progresscount = item['sum'].toString();
            });
            break;
          case 'Cancelled':
            setState(() {
              cancelcount = item['sum'].toString();
            });
            break;
        }
      }
    }
  }
  Future<void> get_new_data() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url = Uri.parse(
        "http://35.73.30.144:2005/api/v1/listTaskByStatus/New");
    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': token!
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data['data'] != null && data['data'] is List) {
        setState(() {
          lst=data['data'];
        });
      } else {
        print('Unexpected data structure: ${res.body}');
      }
    } else {
      print('Failed to fetch tasks: ${res.statusCode}');
      print('Response body: ${res.body}');
    }
  }
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.sizeOf(context).width;
    var mdh=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: RefreshIndicator(child: Column(
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
                      Text("${cancelcount}",style: Sum_Tile_Num(mdw),),
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
                      Text("${completecount}",style: Sum_Tile_Num(mdw)),
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
                      Text("${progresscount}",style: Sum_Tile_Num(mdw)),
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
                      Text("${new_tascount}",style: Sum_Tile_Num(mdw),),
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
              child: ListView.builder(
                itemCount: lst.length,
                itemBuilder: (context, index) {
                  return TaskCards(
                    label_bg: New_Task_Label_Color,
                    id: lst[index]['_id'] ?? '',
                    title: lst[index]['title'] ?? 'No Title',
                    description: lst[index]['description'] ?? 'No Description',
                    createdDate: lst[index]['createdDate'] ?? 'Unknown Date',
                    status: lst[index]['status'] ?? 'Unknown Status',
                  );
                },
              ),
            ),
          )
        ],
      ), onRefresh: _refreshData,color: MythemeColor,),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskNewtaskAdd(),));
      },child: Icon(Icons.add),),
    );
  }
}