import 'package:assignment5/screens/blog_home_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class BlogCard extends StatefulWidget {
  final String task;
  final String title;
  final String picurl;
  final String idx;
  BlogCard({super.key, required this.task, required this.title, required this.picurl, required this.idx});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  Future<void> DeleteFromApi(String idx)
  async{
    var url=Uri.parse("https://tasker26.vercel.app/delete/$idx");
    var res=await http.delete(url);
    if(res.statusCode==200)
      {
        Navigator.of(context).pop();
      }
  }
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return GestureDetector(
      onLongPress: (){
        showCupertinoDialog(context: context, builder: (context) {
          return CupertinoAlertDialog(
            title: Text("What you Want to do?"),
            content: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(CupertinoIcons.pen,size: mdw*0.07,),
                  GestureDetector(
                      child: Icon(CupertinoIcons.delete,size: mdw*0.07,),
                    onTap: (){
                      showCupertinoDialog(context: context, builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("Delete"),
                          content: Text("Are you Sure you want to delete Blog ID ${widget.idx}"),
                          actions: [
                            CupertinoButton(child: Text('Confirm'), onPressed: (){
                              DeleteFromApi(widget.idx);
                            }),
                            CupertinoButton(child: Text("Close"), onPressed: (){
                              Navigator.of(context).pop();
                            })
                          ],
                        );
                      },);
                    },
                  )
                ],
              ),
            ),
            actions: [
              CupertinoButton(child: Text("Close"), onPressed: (){
                Navigator.of(context).pop();
              })
            ],
          );
        },);
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: CupertinoColors.separator),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Hero(
                tag: "${widget.idx}",
                child: Container(
                  height: mdw * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      alignment: Alignment.topLeft,
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.picurl),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            Text("${widget.title}", style: TextStyle(
                fontSize: mdw * 0.048,
                fontWeight: FontWeight.bold,
              ),overflow: TextOverflow.ellipsis,),
            SizedBox(height: 5),
            Text(widget.task, overflow: TextOverflow.ellipsis, maxLines: 2,
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => HomeDetails(
          idx: widget.idx,
          task: widget.task,
          title: widget.title,
          purl: widget.picurl.toString(),
        ),));
      },
    );
  }
}
