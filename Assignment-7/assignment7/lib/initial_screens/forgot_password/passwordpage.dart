import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/components/have_act_msg.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:task_manager/style/style.dart';
import '../../components/mybutton.dart';
class Passwordpage extends StatelessWidget{
  UserController user=Get.find();
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
                            controller: user.recovery_pass,
                            decoration: InputDecoration(
                                hintText: "Password"
                            ),
                          ),
                          SizedBox(height: mdh*0.012,),
                          TextFormField(
                            controller: user.recovery_pass_confirm,
                            decoration: InputDecoration(
                                hintText: "Confirm Password"
                            ),
                          ),
                          SizedBox(height: mdh*0.012,),
                          Mybutton(onpressed: (){user.recover_password();},something: Center(child: Text("Confirm",style: TextStyle(color: Colors.white),),),)
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