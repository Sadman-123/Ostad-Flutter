import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
Widget Mobile_View()
{
  return Scaffold(
   appBar: AppBar(
     actions: [
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: SvgPicture.asset(
           "assets/logo.svg",
           width: 30,
           height: 34,
         ),
       ),
     ],
   ),
    drawer: Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.blue,
            child: Center(child: Text("Flutter Web",style: TextStyle(fontSize: 30,color: Colors.white),)),
          ),
          ListTile(
            leading: Icon(Icons.home,color: Colors.black,),
            title: Text("Home",style: TextStyle(color: Colors.black),),
          ),
          ListTile(
            leading: Icon(Icons.message,color: Colors.black,),
            title: Text("Messages",style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    ),
    body: Center(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Column(
            children: [
              Text("FLUTTER WEB.",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900),),
              Text("THE BASICS",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900))
            ],
          ),
          Container(
              width: 300,
              child: Text("Discover the fundamentals of building web applications with Flutter. This guide covers essential concepts, from setting up your development environment to creating responsive layouts and integrating web-specific features. Perfect for developers looking to expand their Flutter skills to web development.",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: Colors.black87),)
          ),
          SizedBox(height: 15,),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              minimumSize: MaterialStateProperty.all(Size(260, 50)),
            ),
              onPressed: (){},
              child: Text("READ MORE")
          )
        ],
      ),
    ),
  );
}