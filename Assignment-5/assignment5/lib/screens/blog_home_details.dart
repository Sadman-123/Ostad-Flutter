import 'package:flutter/cupertino.dart';
class HomeDetails extends StatelessWidget{
  final String purl;
  final String title;
  final String task;

  const HomeDetails({super.key, required this.purl, required this.title, required this.task});

  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.of(context).size.width;
    var mdh=MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Blog Details"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
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
            Container(
              height: mdh*0.10,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$title",style: TextStyle(fontSize: mdw*0.09,fontWeight: FontWeight.bold),),
                    Icon(CupertinoIcons.share)
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
                      CupertinoButton.filled(child: Text("Click me"), onPressed: (){})
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