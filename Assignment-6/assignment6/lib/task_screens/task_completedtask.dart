import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/task_cards.dart';
import '../style/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class TaskCompletedtask extends StatefulWidget{
  @override
  State<TaskCompletedtask> createState() => _TaskCompletedtaskState();
}
class _TaskCompletedtaskState extends State<TaskCompletedtask> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_completed_data();
  }
  var lst=[];
  Future<void> get_completed_data() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url = Uri.parse(
        "http://35.73.30.144:2005/api/v1/listTaskByStatus/Completed");
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
    return Scaffold(
      body: ListView.builder(
          itemCount: task.Completed_Tasks.length,
          itemBuilder: (context, index) {
            return TaskCards(
              label_bg: Completed_Task_Label_Color,
              id: lst[index]['_id'] ?? '',
              title: lst[index]['title'] ?? 'No Title',
              description: lst[index]['description'] ?? 'No Description',
              createdDate: lst[index]['createdDate'] ?? 'Unknown Date',
              status: lst[index]['status'] ?? 'Unknown Status',
            );
          },
      ),
    );
  }
}