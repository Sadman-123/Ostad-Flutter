import 'package:assignment5/diy_widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  TextEditingController ct1 = TextEditingController();
  TextEditingController ct2 = TextEditingController();
  File? _selectedImage;
  String _imageName = "Add Photos";
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    getfromApi();
  }
  var arr = [];
  Future<void> getfromApi() async {
    var url = Uri.parse("https://tasker26.vercel.app/api");
    var res = await http.get(url);
    setState(() {
      arr.addAll(jsonDecode(res.body));
    });
  }
  Future<void> Add_to_Api() async {
    var url = Uri.parse("https://tasker26.vercel.app/upload");
    var request = http.MultipartRequest('POST', url);
    request.fields['title'] = ct1.text;
    request.fields['task'] = ct2.text;
    if (_selectedImage != null) {
      var pic = await http.MultipartFile.fromPath('pic', _selectedImage!.path);
      request.files.add(pic);
    }
    var res = await request.send();
    if (res.statusCode == 200) {
      ct1.clear();
      ct2.clear();
      setState(() {
        _selectedImage = null;
        _imageName = "Add Photos";
      });
      Navigator.of(context).pop();
    }
  }
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _imageName = pickedFile.name;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Blogs"),
      ),
      child: SafeArea(
        child: arr.isEmpty
            ? Center(
          child: CupertinoActivityIndicator(radius: 25),
        )
            : Column(
          children: [
            Expanded(
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
                    idx: arr[index]['_id'],
                    title: arr[index]['title'],
                    task: arr[index]['task'],
                    picurl: arr[index]['picUrl'],
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.all(10),
              child: CupertinoButton.filled(
                child: Text("Make post"),
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text("Add to Post"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: mdh * 0.017),
                            CupertinoTextField(
                              controller: ct1,
                              placeholder: "Title",
                            ),
                            SizedBox(height: mdh * 0.017),
                            CupertinoTextField(
                              controller: ct2,
                              placeholder: "Post",
                              maxLines: 3,
                            ),
                            SizedBox(height: mdh * 0.017),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(_imageName),
                                  GestureDetector(
                                    child: Icon(CupertinoIcons
                                        .photo_on_rectangle),
                                    onTap: _pickImage,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          CupertinoButton(
                            child: Text("Make Post"),
                            onPressed: Add_to_Api,
                          ),
                          CupertinoButton(
                            child: Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
