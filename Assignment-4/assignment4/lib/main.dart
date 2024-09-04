import 'package:assignment4/custom_widgets/shirt_card.dart';
import 'package:flutter/material.dart';
void main()
{
  runApp(Main());
}
class Main extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}
class App extends StatelessWidget
{
  var shirt_info=[
    {
      "shirt_pic":"assets/pullover.png",
      "shirt_name":"Pullover",
      "shirt_color":"black",
      "shirt_size":"L",
      "shirt_price":"51"
    },
    {
      "shirt_pic":"assets/tshirt.png",
      "shirt_name":"T-Shirt",
      "shirt_color":"Gray",
      "shirt_size":"L",
      "shirt_price":"30"
    },
    {
      "shirt_pic":"assets/sport.png",
      "shirt_name":"Sport Dress",
      "shirt_color":"Black",
      "shirt_size":"M",
      "shirt_price":"43"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bag",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w800,color: Colors.black),),
      ),
      body: ListView.builder(
        itemCount: shirt_info.length,
        itemBuilder: (context, index) {
          return Shirt_Card(shirt_info, index);
        },
      ),
    );
  }
}