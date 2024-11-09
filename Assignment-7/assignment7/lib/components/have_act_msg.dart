import 'package:flutter/material.dart';
import '../initial_screens/login.dart';
import 'package:get/get.dart';
class HaveActMsg extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: (){Get.to(()=>Login());},
        child: RichText(
          text: TextSpan(
              style: TextStyle(color: Colors.black,fontFamily: "apple"),
              children: [
                TextSpan(text: "Have account?"),
                TextSpan(text: "  "),
                TextSpan(text: "Sign in",style: TextStyle(color: Color(0xFF29bf12)))
              ]
          ),
        ),
      ),
    );
  }
}