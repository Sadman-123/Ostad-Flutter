import 'dart:convert';
import 'dart:io'; // Import for handling File
import 'package:assignment5/diy_widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart'; // Import for ImagePicker
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController ct1 = TextEditingController();
  TextEditingController ct2 = TextEditingController();
  File? _image; // Variable to store the selected image

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

  Future<void> sendData() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://tasker26.vercel.app/upload"),
    );

    // Adding text fields
    request.fields['title'] = ct1.text;
    request.fields['task'] = ct2.text;

    if (_image != null) {
      // Adding the image file if it exists
      request.files.add(await http.MultipartFile.fromPath('pic', _image!.path));
    }

    if (ct1.text.isEmpty || ct2.text.isEmpty) {
      final Stk = SnackBar(content: Text("Something went wrong"));
      ScaffoldMessenger.of(context).showSnackBar(Stk);
      return;
    }

    var res = await request.send();
    if (res.statusCode == 200) {
      setState(() {
        ct1.clear();
        ct2.clear();
        _image = null; // Clear the selected image
      });
    }
  }

  // Method to pick an image from the camera or gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path); // Store the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
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
                title: Text(
                  'Blog Add',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: ct1,
                      decoration: InputDecoration(hintText: "Title"),
                    ),
                    SizedBox(height: mdh * 0.024),
                    TextField(
                      controller: ct2,
                      decoration: InputDecoration(hintText: "Task"),
                    ),
                    SizedBox(height: mdh * 0.024),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: mdh * 0.08,
                          width: mdw * 0.15,
                          child: _image != null // Display the selected image
                              ? Image.file(_image!, fit: BoxFit.cover)
                              : Center(child: Text(""),),
                        ),
                        IconButton(
                          onPressed: _pickImage, // Pick an image when clicked
                          icon: Icon(
                            FontAwesomeIcons.camera,
                            size: mdw * 0.11,
                            color: Colors.black,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      sendData();
                      Navigator.of(context).pop();
                    },
                    child: Text("Add to Blog"),
                  ),
                  TextButton(
                    child: Text('Close'),
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
