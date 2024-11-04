import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager/initial_screens/update_profile.dart';
import 'package:task_manager/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myappbar extends StatefulWidget implements PreferredSizeWidget {
  final bool autobar;
  Myappbar({super.key, required this.autobar});

  @override
  State<Myappbar> createState() => _MyappbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyappbarState extends State<Myappbar> {
  Map<String, String> userInfo = <String, String>{};
  String Appbar_Name = "";
  String Appbar_Email = "";
  String picurl = "";
  File appbarImage = File("");

  @override
  void initState() {
    super.initState();
    getProfileDetails();
    loadImageFromPrefs();
  }

  Future<void> getProfileDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url = Uri.parse("http://35.73.30.144:2005/api/v1/ProfileDetails");
    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': '$token'
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data['status'] == 'success') {
        setState(() {
          var profile = data['data'][0];
          userInfo['id'] = profile['_id'];
          userInfo['email'] = profile['email'];
          userInfo['firstName'] = profile['firstName'];
          userInfo['lastName'] = profile['lastName'];
          userInfo['mobile'] = profile['mobile'];
          userInfo['password'] = profile['password'];
          Appbar_Name = profile['firstName'] + " " + profile['lastName'];
          Appbar_Email = profile['email'];
        });
      }
    }
  }

  Future<void> loadImageFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uniqueKey = Appbar_Email.isNotEmpty ? Appbar_Email : "default";
    String? savedImagePath = prefs.getString('profile_pic_$uniqueKey');
    if (savedImagePath != null && savedImagePath.isNotEmpty) {
      setState(() {
        appbarImage = File(savedImagePath);
        picurl = savedImagePath;
      });
    } else {
      setState(() {
        appbarImage = File("");
      });
    }
  }

  Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      Appbar_Name = "";
      Appbar_Email = "";
    });
    userInfo.clear();
    Fluttertoast.showToast(
      msg: "Logged out successfully",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return AppBar(
      automaticallyImplyLeading: widget.autobar,
      backgroundColor: MythemeColor,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              final String? token = prefs.getString('token');
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile(token: token!),));
            },
            child:appbarImage.path.isNotEmpty? Hero(
                  tag: "pic",
                  child: CircleAvatar(
                    radius: 23,
                    backgroundImage: FileImage(appbarImage),
                  ),
                ): Hero(
                  tag: "pic",
                  child: CircleAvatar(
                    radius: 23,
                    child: Image.asset("assets/user.png"),
                  ),
                ),
          ),
          SizedBox(width: mdw * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Appbar_Name, style: Appbar_Username(mdw)),
                Text(Appbar_Email, style: Appbars_Email(mdw)),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ),
      ],
    );
  }
}



