import 'package:assignment5/diy_widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
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
  @override
  Widget build(BuildContext context) {
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
        onPressed: () {},
        child: Icon(FontAwesomeIcons.pen),
      ),
    );
  }
}
