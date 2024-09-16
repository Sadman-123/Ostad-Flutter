import 'package:assignment5/screens/blog_home_details.dart';
import 'package:flutter/cupertino.dart';

class BlogCard extends StatelessWidget {
  final String task;
  final String title;
  final String? picurl;

  const BlogCard({super.key, required this.task, required this.title, this.picurl});

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: CupertinoColors.separator),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (picurl != null && picurl!.isNotEmpty)
              Hero(
                tag: "pic",
                child: Container(
                  height: mdw * 0.35, // Adjust height for the image container
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      alignment: Alignment.topLeft,
                      fit: BoxFit.cover,
                      image: NetworkImage(picurl!),
                    ),
                  ),
                ),
              ),
            if (picurl != null && picurl!.isNotEmpty)
              SizedBox(height: 10),
            Text("$title", style: TextStyle(
                fontSize: mdw * 0.048,
                fontWeight: FontWeight.bold,
              ),overflow: TextOverflow.ellipsis,),
            SizedBox(height: 5),
            Text(task, overflow: TextOverflow.ellipsis, maxLines: 2,
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => HomeDetails(
          task: task,
          title: title,
          purl: picurl.toString(),
        ),));
      },
    );
  }
}
