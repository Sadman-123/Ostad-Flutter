import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
Widget Desktop_View()
{
  return Scaffold(
    body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                "assets/logo.svg",
                width: 30,
                height: 34,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text("Home",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w500),),
                  SizedBox(width: 20,),
                  Text("Favourites",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w500),)
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Text("FLUTTER WEB.",style: TextStyle(fontSize: 65,fontWeight: FontWeight.w900),),
                    Text("THE BASICS",style: TextStyle(fontSize: 65,fontWeight: FontWeight.w900))
                  ],
                ),
                Container(
                    width: 650,
                    child: Text("Discover the fundamentals of building web applications with Flutter. This guide covers essential concepts, from setting up your development environment to creating responsive layouts and integrating web-specific features. Perfect for developers looking to expand their Flutter skills to web development.",textAlign: TextAlign.center,style: TextStyle(fontSize: 21,color: Colors.black87),)
                ),
              ],
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.greenAccent.shade400),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  minimumSize: MaterialStateProperty.all(Size(300, 55)),
                ),
                onPressed: (){},
                child: Text("READ MORE",style: TextStyle(fontSize: 19),)
            )
          ],
        )
      ],
    ),
  );
}