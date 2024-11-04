import 'package:flutter/material.dart';
class HaveActMsg extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/login');
          },
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