import 'package:flutter/material.dart';
class BlogCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.of(context).size.width;
    var mdh=MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.black26)
      ),
      height: mdh*0.25,
      width: mdw*0.44,
      child: Column(
        children: [
          Container(
            height: mdh*0.125,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSo_wu6lES40GwjTJqrkwkCpCGoodxTRyq2Q&s")
              )
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Title",style: TextStyle(fontSize: mdw*0.048,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    child: Text("A paragraph is defined as “a group of sentences or a single sentence that forms a unit” (Lunsford and Connors 116). Length and appearance do not determine whether a section in a paper is a paragraph. For instance, in some styles of writing, particularly journalistic styles, a paragraph can be just one sentence long.",overflow: TextOverflow.ellipsis,maxLines: 2,),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}