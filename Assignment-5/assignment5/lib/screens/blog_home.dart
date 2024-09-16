import 'package:assignment5/diy_widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Home extends StatefulWidget
{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfromApi();
  }
  var arr=[];
  Future<void>getfromApi()
  async{
    var url=Uri.parse("https://tasker26.vercel.app/api");
    var res=await http.get(url);
    setState(() {
      arr.addAll(jsonDecode(res.body));
    });
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Blogs"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(child: Container(
              child: GridView.builder(
                itemCount: arr.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return BlogCard(
                      title: arr[index]['title'],
                      task: arr[index]['task'],
                      picurl: arr[index]['picUrl'],
                    );
                  },)
            )),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.all(10),
                child: CupertinoButton.filled(child: Text("Click me"), onPressed: (){})
            )
          ],
        ),
      ),
    );
  }
}