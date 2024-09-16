import 'package:assignment5/screens/blog_home.dart';
import 'package:flutter/cupertino.dart';
class HomeDetails extends StatelessWidget{
  final String purl;
  final String title;
  final String task;
  final String time;
  final String idx;
  const HomeDetails({super.key, required this.purl, required this.title, required this.task, required this.idx, required this.time});
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.of(context).size.width;
    var mdh=MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Blog Details",style: TextStyle(fontSize: mdw*0.056,fontFamily: "apple",fontWeight: FontWeight.bold),),
        trailing: Icon(CupertinoIcons.share,color: CupertinoColors.activeBlue,),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: "$idx",
              child: Container(
                height: mdh*0.3,
                decoration: BoxDecoration(
                  color: CupertinoColors.activeOrange,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("$purl")
                  )
                ),
                width: double.infinity,
              ),
            ),
            Container(
              height: mdh*0.10,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$title",style: TextStyle(fontSize: mdw*0.09,fontWeight: FontWeight.bold,fontFamily: "apple",),),
                   Text("$time",overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                          child: Text("$task",style: TextStyle(fontSize: mdw*0.05),)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}