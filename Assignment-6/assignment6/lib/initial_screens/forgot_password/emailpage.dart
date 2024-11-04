import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/components/have_act_msg.dart';
import 'package:task_manager/style/style.dart';
import 'package:http/http.dart' as http;
import '../../components/mybutton.dart';
class Emailpage extends StatefulWidget{
  @override
  State<Emailpage> createState() => _EmailpageState();
}
class _EmailpageState extends State<Emailpage> {
  TextEditingController recovery_email=TextEditingController();
  Future<void> send_otp() async {
    try {
      var url = Uri.parse("http://35.73.30.144:2005/api/v1/RecoverVerifyEmail/${recovery_email.text.toString()}");
      print("Sending OTP to: ${recovery_email.text}");
      var res = await http.get(url, headers: {'Content-Type': 'application/json'});
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "OTP Sent Successfully",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFF20be73),
          textColor: Colors.white,
        );
        Navigator.pushNamed(context, '/OtpVerify');
      } else {
        Fluttertoast.showToast(
          msg: "Something Went Wrong: ${res.body}",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
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
                height: mdh*0.45,
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
                                  Text("Your Email Address",style: H1text(mdw)),
                                  Text("A 6 digit verification pin will send to your email address",style: H4text(mdw),),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              )
                          ),

                          SizedBox(height: mdh*0.035,),
                          TextFormField(
                            controller: recovery_email,
                            decoration: InputDecoration(
                                hintText: "Email"
                            ),
                          ),
                          SizedBox(height: mdh*0.012,),
                          SizedBox(height: mdh*0.012,),
                          Mybutton(onpressed: (){send_otp();},something: Icon(Icons.navigate_next),)
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