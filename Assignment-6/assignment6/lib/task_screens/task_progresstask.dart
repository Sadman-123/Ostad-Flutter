import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/style/style.dart';
import '../components/task_cards.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class TaskProgresstask extends StatefulWidget{
  @override
  State<TaskProgresstask> createState() => _TaskProgresstaskState();
}

class _TaskProgresstaskState extends State<TaskProgresstask> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_progress_data();
  }
  Future<void> _refreshData() async {

    setState(() {
      get_progress_data();
    });
    await Future.delayed(Duration(seconds: 1));
  }
  var lst=[];
  Future<void> get_progress_data() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url = Uri.parse(
        "http://35.73.30.144:2005/api/v1/listTaskByStatus/Progress");
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
      body: RefreshIndicator(child: ListView.builder(
        itemCount: lst.length,
        itemBuilder: (context, index) {
          return TaskCards(
            label_bg: Progress_Task_Label_Color,
            id: lst[index]['_id'] ?? '',
            Refresh: get_progress_data,
            title: lst[index]['title'] ?? 'No Title',
            description: lst[index]['description'] ?? 'No Description',
            createdDate: lst[index]['createdDate'] ?? 'Unknown Date',
            status: lst[index]['status'] ?? 'Unknown Status',
          );
        },
      ), onRefresh: _refreshData,color: MythemeColor,)
    );
  }
}