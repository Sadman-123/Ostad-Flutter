import 'package:flutter/material.dart';
Widget Shirt_Card(List<dynamic>arr,int index)
{
  return  Container(
    margin: EdgeInsets.all(10),
    height: 130,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.amber
    ),
    child: Row(
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("${arr[index]['shirt_pic']}"),
              ),
              color: Colors.pink,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
              )
          ),
        ),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${arr[index]['shirt_name']}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_outlined))
                    ],
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'color: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                              ),
                            ),
                            TextSpan(
                              text: '${arr[index]['shirt_color']}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.5,
                                fontWeight: FontWeight.bold, // Bold the text
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Size: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                              ),
                            ),
                            TextSpan(
                              text: '${arr[index]['shirt_size']}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.5,
                                fontWeight: FontWeight.bold, // Bold the text
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text("+",style: TextStyle(fontSize: 20),),
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                            ),
                            Text("0",style: TextStyle(fontSize: 32),),
                            Container(
                              child: Text("-",style: TextStyle(fontSize: 20),),
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                            ),
                          ],
                        ),
                        height: 50,
                        width: 150,
                      ),
                      Container(
                        margin: EdgeInsets.only(right:7),
                        child: Text("${arr[index]['shirt_price']}\$",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                      )
                    ],
                  )
                ],
              )
          ),
        )
      ],
    ),
  );
}