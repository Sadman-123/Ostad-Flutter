import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../components/have_act_msg.dart';
import '../components/mybutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../style/style.dart';
class Registration extends StatefulWidget{
  @override
  State<Registration> createState() => _RegistrationState();
}
class _RegistrationState extends State<Registration> {
  TextEditingController email = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> registration(BuildContext context, TextEditingController email,
      TextEditingController first_name, TextEditingController last_name,
      TextEditingController password, TextEditingController mobile) async
  {
    if (email.text.isEmpty || first_name.text.isEmpty ||
        last_name.text.isEmpty || password.text.isEmpty ||
        mobile.text.isEmpty) {
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
        "firstName": first_name.text,
        "lastName": last_name.text,
        "mobile": mobile.text,
        "password": password.text
      };
      var url = Uri.parse("http://35.73.30.144:2005/api/v1/Registration");
      var res = await http.post(
          url, headers: {'Content-Type': 'application/json'},
          body: json.encode(dat));
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Account Created Successfully",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white
        );
        email.clear();
        first_name.clear();
        last_name.clear();
        mobile.clear();
        password.clear();
      } else {
        Fluttertoast.showToast(
            msg: "Sorry There Was a Problem",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white
        );
        email.clear();
        first_name.clear();
        last_name.clear();
        mobile.clear();
        password.clear();
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
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    Text("Join With Us",style: H1text(mdw),),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                )
                            ),
                            SizedBox(height: mdh*0.035,),
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                  hintText: "Email"
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            TextFormField(
                              controller: first_name,
                              decoration: InputDecoration(
                                  hintText: "First Name"
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            TextFormField(
                              controller: last_name,
                              decoration: InputDecoration(
                                  hintText: "Last Name"
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            TextFormField(
                              controller: mobile,
                              decoration: InputDecoration(
                                  hintText: "Mobile"
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            TextFormField(
                              controller: password,
                              decoration: InputDecoration(
                                  hintText: "Password"
                              ),
                            ),
                            SizedBox(height: mdh*0.035,),
                            Mybutton(onpressed: (){registration(context, email, first_name, last_name, password, mobile);},something: Icon(Icons.arrow_circle_right_outlined,color: Colors.white,))
                          ],
                        ),
                      ),
                      SizedBox(height: mdh*0.04,),
                      HaveActMsg()
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