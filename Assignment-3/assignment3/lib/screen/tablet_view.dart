import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget Tablet_View() {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/logo.svg",
                  width: 30,
                  height: 34,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Home",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w500),),
                    SizedBox(width: 20,),
                    Text("Messages",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w500),)
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 30,),
          Column(
            children: [
              SizedBox(height: 20,),
              Column(
                children: [
                  Text("FLUTTER WEB.",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900),),
                  Text("THE BASICS",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900))
                ],
              ),
              Container(
                  width: 450,
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
        ],
      ),
    );
  }
