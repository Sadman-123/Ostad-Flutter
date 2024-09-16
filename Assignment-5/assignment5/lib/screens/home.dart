import 'package:assignment5/diy_widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  TextEditingController ct1=TextEditingController();
  TextEditingController ct2=TextEditingController();
  @override
  void initState() {
    super.initState();
    getDatas();
  }
  var arr = [];
  Future<void> getDatas() async {
    var url = Uri.parse("https://tasker26.vercel.app/api");
    var res = await http.get(url);
    var data = jsonDecode(res.body);
    setState(() {
      arr.addAll(data);
    });
  }
  Future<void> SendData() async {
    var dat={
      "title":ct1.text,
      "task":ct2.text
    };
    if(ct1.text.isEmpty || ct2.text.isEmpty)
      {
        final Stk=SnackBar(content: Text("Something went wrong"));
        ScaffoldMessenger.of(context).showSnackBar(Stk);
        return;
    }
    var url = Uri.parse("https://tasker26.vercel.app/upload");
    var res = await http.post(url,headers: {'Content-Type': 'application/json'},body: json.encode(dat));
    var data = jsonDecode(res.body);
    setState(() {
      ct1.clear();
      ct2.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.of(context).size.width;
    var mdh=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs"),
      ),
      body: GridView.builder(
        itemCount: arr.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.74,
        ),
        itemBuilder: (context, index) {
          var picUrl = arr[index]['picUrl'];
          return BlogCard(
            title: arr[index]['title'],
            task: arr[index]['task']!,
            picurl: picUrl != null && picUrl.isNotEmpty ? picUrl : '', // Handle null or empty picUrl
          );
        },
        padding: EdgeInsets.all(10),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text('Blog Add'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: ct1,
                      decoration: InputDecoration(
                        hintText: "Title"
                      ),
                    ),
                    SizedBox(height: mdh*0.024,),
                    TextField(
                      controller: ct2,
                      decoration: InputDecoration(
                          hintText: "Task"
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(onPressed: (){
                    SendData();
                  }, child: Text("Add to Blog")),
                  TextButton(
                    child: Text('close'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(FontAwesomeIcons.pen),
      ),
    );
  }
}
