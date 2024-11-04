import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/mybutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../style/style.dart';
class Login extends StatefulWidget{
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  Map<String, String> userInfo = <String, String>{};
  String Appbar_Name = "";
  String Appbar_Email = "";
  String picurl = "";
  File  appbarImage = File("");
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
  Future<void> login(BuildContext context, TextEditingController email,
      TextEditingController password) async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (email.text.isEmpty || password.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Fill Every Box",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red.shade500,
          textColor: Colors.white
      );
      return;
    } else {
      var dat = {
        "email": email.text,
        "password": password.text
      };
      var url = Uri.parse("http://35.73.30.144:2005/api/v1/Login");
      try {
        var res = await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(dat),
        );
        if (res.statusCode == 200) {
          var data = jsonDecode(res.body);
          if (data['token'] != null) {
            var token = data['token'];
            await prefs.setString("token", token);
            email.clear();
            password.clear();
            Navigator.pushNamed(context, '/home');
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Token",
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white
            );
          }
        } else {
          Fluttertoast.showToast(
              msg: "Something Went Wrong",
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: "$e",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white
        );
      }
    }
  }

  Widget build(BuildContext context) {
    var mdw=MediaQuery.sizeOf(context).width;
    var mdh=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            background_img('assets/background.svg'),
            Center(
              child: Container(
                height: mdh*0.55,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Get Started With",style: H1text(mdw),),
                          SizedBox(height: mdh*0.035,),
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                hintText: "Email"
                            ),
                          ),
                          SizedBox(height: mdh*0.012,),
                          TextFormField(
                            controller: pass,
                            decoration: InputDecoration(
                                hintText: "Password"
                            ),
                          ),
                          SizedBox(height: mdh*0.012,),
                          Mybutton(onpressed: (){login(context, email, pass);},something: Icon(Icons.navigate_next),)
                        ],
                      ),
                    ),
                    SizedBox(height: mdh*0.04,),
                    Container(
                      child: Column(
                        children: [
                          GestureDetector(child: Text("Forgot Password?"),onTap: (){
                            Navigator.pushNamed(context, '/EmailVerify');
                            },),
                          SizedBox(height: mdh*0.014,),
                          GestureDetector(
                            onTap: (){
                             Navigator.pushNamed(context, '/register');
                            },
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black,fontFamily: "apple"),
                                  children: [
                                    TextSpan(text: "Don't have account?"),
                                    TextSpan(text: "  "),
                                    TextSpan(text: "Sign up",style: TextStyle(color: Colors.greenAccent,fontFamily: "apple"))
                                  ]
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}