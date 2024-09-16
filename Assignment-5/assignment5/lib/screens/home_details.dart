import 'package:flutter/material.dart';
class HomeDetails extends StatelessWidget{
  final String title;
  final String task;
  final String purl;

  HomeDetails({super.key, required this.title, required this.task, required this.purl});
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.favorite_border),),
      body: Column(
        children: [
          Hero(
            tag: "pic",
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("$purl")
                )
              ),
              height: mdh*0.3,
              width: double.infinity,
            ),
          ),
          Container(
            height: mdh*0.12,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$title",style: TextStyle(fontSize: mdw*0.12,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                  Text("1.2K",style: TextStyle(fontSize: mdw*0.07),)
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: mdh*0.3,
            child: Text("$task",style: TextStyle(fontSize: mdw*0.062),),
          )
        ],
      ),
    );
  }
}