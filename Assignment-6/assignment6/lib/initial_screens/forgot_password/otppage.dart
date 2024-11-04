import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';
import 'package:task_manager/components/have_act_msg.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:task_manager/style/style.dart';
import '../../components/mybutton.dart';
class Otppage extends StatelessWidget{
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
                                  Text("PIN Verification",style: H1text(mdw)),
                                  Text("A 6 digit verification pin will send to your email address",style: H4text(mdw),),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              )
                          ),

                          SizedBox(height: mdh*0.035,),
                          Wrap(
                            spacing: 8.0,
                            children: [
                              Pinput(
                                length: 6,
                                keyboardType: TextInputType.number,
                                pinAnimationType: PinAnimationType.scale,
                                defaultPinTheme: pin_code_theme(),
                                onChanged: (pin){
                                  user.get_otp(pin);
                                },
                              )
                            ],
                          ),
                          SizedBox(height: mdh*0.012,),
                          SizedBox(height: mdh*0.012,),
                          Mybutton(onpressed: (){user.check_otp();},something: Center(child: Text("Verify",style: TextStyle(color: Colors.white),)),)
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