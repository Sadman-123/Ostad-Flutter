import 'package:flutter/material.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:task_manager/initial_screens/forgot_password/emailpage.dart';
import 'package:task_manager/initial_screens/registration.dart';
import '../components/mybutton.dart';
import 'package:get/get.dart';
import '../style/style.dart';
class Login extends StatelessWidget{
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
                            controller: user.email,
                            decoration: InputDecoration(
                                hintText: "Email"
                            ),
                          ),
                          SizedBox(height: mdh*0.012,),
                          TextFormField(
                            controller: user.password,
                            decoration: InputDecoration(
                                hintText: "Password"
                            ),
                          ),
                          SizedBox(height: mdh*0.012,),
                          Mybutton(onpressed: (){user.login(context, user.email, user.password);},something: Icon(Icons.navigate_next),)
                        ],
                      ),
                    ),
                    SizedBox(height: mdh*0.04,),
                    Container(
                      child: Column(
                        children: [
                          GestureDetector(child: Text("Forgot Password?"),onTap: (){Get.to(()=>Emailpage());},),
                          SizedBox(height: mdh*0.014,),
                          GestureDetector(
                            onTap: (){
                             Get.to(()=>Registration());
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