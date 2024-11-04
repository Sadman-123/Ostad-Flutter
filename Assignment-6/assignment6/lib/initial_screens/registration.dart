import 'package:flutter/material.dart';
import 'package:task_manager/controller/user_controller.dart';
import '../components/have_act_msg.dart';
import '../components/mybutton.dart';
import 'package:get/get.dart';
import '../style/style.dart';
class Registration extends StatelessWidget{
  UserController user=Get.find();
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
                              controller: user.email,
                              decoration: InputDecoration(
                                  hintText: "Email"
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            TextFormField(
                              controller: user.first_name,
                              decoration: InputDecoration(
                                  hintText: "First Name"
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            TextFormField(
                              controller: user.last_name,
                              decoration: InputDecoration(
                                  hintText: "Last Name"
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            TextFormField(
                              controller: user.mobile,
                              decoration: InputDecoration(
                                  hintText: "Mobile"
                              ),
                            ),
                            SizedBox(height: mdh*0.012,),
                            TextFormField(
                              controller: user.password,
                              decoration: InputDecoration(
                                  hintText: "Password"
                              ),
                            ),
                            SizedBox(height: mdh*0.035,),
                            Mybutton(onpressed: (){user.registration(context, user.email, user.first_name, user.last_name, user.password, user.mobile);},something: Icon(Icons.arrow_circle_right_outlined,color: Colors.white,))
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