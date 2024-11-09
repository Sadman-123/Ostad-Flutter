import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../components/diy_toast.dart';
class TaskController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getSum_by_Status();
    get_new_data();
    get_completed_data();
    get_progress_data();
    get_cancelled_data();
  }
  @override
  void onClose() {
    subject.dispose();
    description.dispose();
    super.onClose();
  }
  RxString cancelcount = "00".obs;
  RxString completecount = "00".obs;
  RxString progresscount = "00".obs;
  RxString new_tascount = "00".obs;
  RxList<dynamic> New_Tasks = [].obs;
  RxList<dynamic> Completed_Tasks = [].obs;
  RxList<dynamic> Progress_Tasks = [].obs;
  RxList<dynamic> Cancelled_Tasks = [].obs;
  TextEditingController subject = TextEditingController();
  TextEditingController description = TextEditingController();
  var selectedIndex = 0.obs;
  void changeIndex(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        get_new_data();
        break;
      case 1:
        get_completed_data();
        break;
      case 2:
        get_progress_data();
        break;
      case 3:
        get_cancelled_data();
        break;
    }
    getSum_by_Status();
  }
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
            new_tascount.value = item['sum'].toString();
            break;
          case 'Completed':
            completecount.value = item['sum'].toString();
            break;
          case 'Progress':
            progresscount.value = item['sum'].toString();
            break;
          case 'Cancelled':
            cancelcount.value = item['sum'].toString();
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
        New_Tasks.assignAll(data['data']);
      } else {
        print('Unexpected data structure: ${res.body}');
      }
    } else {
      print('Failed to fetch tasks: ${res.statusCode}');
      print('Response body: ${res.body}');
    }
  }
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
        Completed_Tasks.assignAll(data['data']);
      } else {
        print('Unexpected data structure: ${res.body}');
      }
    } else {
      print('Failed to fetch tasks: ${res.statusCode}');
      print('Response body: ${res.body}');
    }
  }
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
        Progress_Tasks.assignAll(data['data']);
      } else {
        print('Unexpected data structure: ${res.body}');
      }
    } else {
      print('Failed to fetch tasks: ${res.statusCode}');
      print('Response body: ${res.body}');
    }
  }
  Future<void> get_cancelled_data() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url = Uri.parse(
        "http://35.73.30.144:2005/api/v1/listTaskByStatus/Cancelled");
    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': token!
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data['data'] != null && data['data'] is List) {
        Cancelled_Tasks.assignAll(data['data']);
      } else {
        print('Unexpected data structure: ${res.body}');
      }
    } else {
      print('Failed to fetch tasks: ${res.statusCode}');
      print('Response body: ${res.body}');
    }
  }
  Future<void> insert_to_task() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (subject.text.isEmpty || description.text.isEmpty) {
      JossToast(msg: "Fill Every Blanks",isGood: false);
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
        JossToast(msg: "Task Added Successfully",isGood: true);
        subject.clear();
        description.clear();
        getSum_by_Status();
        get_new_data();
      }
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
      if(status=="New"){
        get_new_data();
      }
      else if(status=="Completed"){
        get_completed_data();
      }
      else if(status=="Progress"){
        get_progress_data();
      }
      else{
        get_cancelled_data();
      }
      getSum_by_Status();
      JossToast(msg: "Deleted",isGood: true);
    }
  }
  Future<void>update_STATUS(String id,String current,String type)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url=Uri.parse("http://35.73.30.144:2005/api/v1/updateTaskStatus/$id/$type");
    var res=await http.get(url,headers: {
      'Content-Type':'application/json',
      'token':'$token'
    });
    if(res.statusCode==200)
    {
      if(current=="New"){
        get_new_data();
        getSum_by_Status();
      }
      else if(current=="Completed"){
        get_completed_data();
        getSum_by_Status();
      }
      else if(current=="Progress"){
        get_progress_data();
        getSum_by_Status();
      }
      else{
        get_cancelled_data();
        getSum_by_Status();
      }
      JossToast(msg: "Status Changed",isGood: true);
    }
  }
  void clearAllTasks() {
    New_Tasks.clear();
    Completed_Tasks.clear();
    Progress_Tasks.clear();
    Cancelled_Tasks.clear();
    new_tascount.value = "00";
    completecount.value = "00";
    progresscount.value = "00";
    cancelcount.value = "00";
  }
}