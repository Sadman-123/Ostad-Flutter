import 'package:assignment4/custom_widgets/shirt_card.dart';
import 'package:flutter/material.dart';
void main()
{
  runApp(Main());
}
class Main extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}
class App extends StatefulWidget
{
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int sum=0;
  int ct1=0;
  int ct2=0;
  int ct3=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bag",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w800,color: Colors.black),),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                Container(
            margin: EdgeInsets.all(10),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black26,width: 0.2)
            ),
            child: Row(
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/pullover.png"),
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
                              Text("Pullover",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
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
                                      text: 'Black',
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
                                      text: 'XL',
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
                                    GestureDetector(
                                      child: Container(
                                        child: Text("+",style: TextStyle(fontSize: 20),),
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          ct1++;
                                          sum=sum+51;
                                        });
                                      },
                                    ),
                                    Text("$ct1",style: TextStyle(fontSize: 32),),
                                    GestureDetector(
                                      child: Container(
                                        child: Text("-",style: TextStyle(fontSize: 20),),
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          if(ct1==0){
                                            showDialog<void>(
                                              context: context,
                                              builder: (BuildContext
                                              dialogContext) {
                                                return AlertDialog(
                                                  title: Text('Warning'),
                                                  content: Text(
                                                      'Oops! You can\'t decrease the value any further.'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                          'close'),
                                                      onPressed: () {
                                                        Navigator.of(
                                                            dialogContext)
                                                            .pop(); // Dismiss alert dialog
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            return;
                                          }
                                          ct1--;
                                          sum=sum-51;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                height: 50,
                                width: 150,
                              ),
                              Container(
                                margin: EdgeInsets.only(right:7),
                                child: Text("51\$",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                )
              ],
            ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black26,width: 0.2)
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/tshirt.png"),
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
                                    Text("T-Shirt",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
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
                                            text: 'Gray',
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
                                            text: 'L',
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
                                          GestureDetector(
                                            child: Container(
                                              child: Text("+",style: TextStyle(fontSize: 20),),
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(50)
                                              ),
                                            ),
                                            onTap: (){
                                              setState(() {
                                                ct2++;
                                                sum=sum+30;
                                              });
                                            },
                                          ),
                                          Text("$ct2",style: TextStyle(fontSize: 32),),
                                          GestureDetector(
                                            child: Container(
                                              child: Text("-",style: TextStyle(fontSize: 20),),
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(50)
                                              ),
                                            ),
                                            onTap: (){
                                              setState(() {
                                                if(ct2==0){
                                                  showDialog<void>(
                                                    context: context,
                                                    builder: (BuildContext
                                                    dialogContext) {
                                                      return AlertDialog(
                                                        title: Text('Warning'),
                                                        content: Text(
                                                            'Oops! You can\'t decrease the value any further.'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text(
                                                                'close'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                  dialogContext)
                                                                  .pop(); // Dismiss alert dialog
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                  return;
                                                }
                                                ct2--;
                                                sum=sum-30;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      height: 50,
                                      width: 150,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right:7),
                                      child: Text("30\$",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black26,width: 0.2)
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/sport.png"),
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
                                    Text("Sport Dress",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
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
                                            text: 'Black',
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
                                            text: 'L',
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
                                          GestureDetector(
                                            child: Container(
                                              child: Text("+",style: TextStyle(fontSize: 20),),
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(50)
                                              ),
                                            ),
                                            onTap: (){
                                              setState(() {
                                                ct3++;
                                                sum=sum+43;
                                              });
                                            },
                                          ),
                                          Text("$ct3",style: TextStyle(fontSize: 32),),
                                          GestureDetector(
                                            child: Container(
                                              child: Text("-",style: TextStyle(fontSize: 20),),
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(50)
                                              ),
                                            ),
                                            onTap: (){
                                              setState(() {
                                                if(ct3==0){
                                                  showDialog<void>(
                                                    context: context,
                                                    builder: (BuildContext
                                                    dialogContext) {
                                                      return AlertDialog(
                                                        title: Text('Warning'),
                                                        content: Text(
                                                            'Oops! You can\'t decrease the value any further.'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text(
                                                                'close'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                  dialogContext)
                                                                  .pop(); // Dismiss alert dialog
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                  return;
                                                }
                                                ct3--;
                                                sum=sum-43;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      height: 50,
                                      width: 150,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right:7),
                                      child: Text("43\$",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
               Container(
                 margin: EdgeInsets.all(10),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Total Amount:",style: TextStyle(fontSize: 22),),
                     Text("$sum\$",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),)
                   ],
                 ),
               ),
                GestureDetector(
                  onTap: (){
                    var stk=SnackBar(
                      content: Text("Congratulations!"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(stk);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(28)
                    ),
                    child: Text("CHECK OUT",style: TextStyle(fontSize: 22,color: Colors.white),),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}