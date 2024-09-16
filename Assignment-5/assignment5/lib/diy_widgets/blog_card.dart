import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final String task;
  final String? picurl; // Nullable picurl
  const BlogCard({super.key, required this.task, this.picurl});
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.black26),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (picurl != null && picurl!.isNotEmpty)
            Container(
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
          // Spacing between image and text
          if (picurl != null && picurl!.isNotEmpty)
            SizedBox(height: 10),
          // Title and task text
          Text(
            "Title",
            style: TextStyle(
              fontSize: mdw * 0.048,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            task,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
