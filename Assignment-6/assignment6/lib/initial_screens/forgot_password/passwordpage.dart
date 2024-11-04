import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/components/have_act_msg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_manager/style/style.dart';
import '../../components/mybutton.dart';
class Passwordpage extends StatefulWidget{
  @override
  State<Passwordpage> createState() => _PasswordpageState();
}

class _PasswordpageState extends State<Passwordpage> {
  TextEditingController recovery_pass=TextEditingController();
  TextEditingController recovery_pass_confirm=TextEditingController();
  String recovery_otp = "";
  String recovery_email = "";
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?; // Cast as Map
    recovery_email = args?['email'] ?? "";
    recovery_otp=args?['otp'] ?? "";
  }
  Future<void> recover_password() async {
    try {
      if (recovery_pass.text.isEmpty || recovery_pass_confirm.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Both fields are required",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        return;
      } else if (recovery_pass.text != recovery_pass_confirm.text) {
        Fluttertoast.showToast(
          msg: "Passwords do not match",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      } else {
        var data = {
          "email": recovery_email,
          "OTP": recovery_otp,
          "password": recovery_pass_confirm.text,
        };

        var url = Uri.parse("http://35.73.30.144:2005/api/v1/RecoverResetPassword");
        var res = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        );

        if (res.statusCode == 200) {
          Fluttertoast.showToast(
            msg: "Password Reset Successfully",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color(0xFF20be73),
            textColor: Colors.white,
          );
          recovery_pass.clear();
          recovery_pass_confirm.clear();
          Navigator.pushNamed(context, '/login');
        } else {
          Fluttertoast.showToast(
            msg: "Something went wrong. Please try again.",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: "An error occurred: $e",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }
  @override
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
                height: mdh*0.56,
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
                                  Text("Set Password",style: H1text(mdw),),
                                  Text("Minimum Password Length  should be 8 characters with letter and number combinations",style: H4text(mdw),),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              )
                          ),

                          SizedBox(height: mdh*0.035,),
                          TextFormField(
                            controller: recovery_pass,
                            decoration: InputDecoration(
                                hintText: "Password"
                            ),
                          ),
                          SizedBox(height: mdh*0.012,),
                          TextFormField(
                            controller: recovery_pass_confirm,
                            decoration: InputDecoration(
                                hintText: "Confirm Password"
                            ),
                          ),
                          SizedBox(height: mdh*0.012,),
                          Mybutton(onpressed: (){recover_password();},something: Center(child: Text("Confirm",style: TextStyle(color: Colors.white),),),)
                        ],
                      ),
                    ),
                    SizedBox(height: mdh*0.04,),
                    HaveActMsg()
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