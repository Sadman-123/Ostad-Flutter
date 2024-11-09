import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';
class Mybutton extends StatelessWidget{
  final VoidCallback onpressed;
  final Widget something;
  const Mybutton({super.key, required this.onpressed, required this.something});
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.sizeOf(context).width;
    var mdh=MediaQuery.sizeOf(context).height;
    return GestureDetector(
      child: Container(
        height: mdh*0.057,
        width: double.infinity,
        decoration: BoxDecoration(
          color: MythemeColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: something,
      ),
      onTap: (){onpressed();},
    );
  }
}