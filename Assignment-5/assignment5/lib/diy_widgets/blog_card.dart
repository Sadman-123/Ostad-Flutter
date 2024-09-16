import 'package:assignment5/screens/blog_home_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class BlogCard extends StatefulWidget {
  final String task;
  final String title;
  final String picurl;
  final String idx;

  BlogCard({
    super.key,
    required this.task,
    required this.title,
    required this.picurl,
    required this.idx,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _newSelectedImage;

  Future<void> updateToApi(String idx) async {
    var url = Uri.parse("https://tasker26.vercel.app/update/$idx");
    var request = http.MultipartRequest('PUT', url);

    request.fields['title'] = _titleController.text;
    request.fields['task'] = _taskController.text;

    if (_newSelectedImage != null) {
      var pic = await http.MultipartFile.fromPath('pic', _newSelectedImage!.path);
      request.files.add(pic);
    }

    var res = await request.send();

    if (res.statusCode == 200) {
      Navigator.of(context).pop();
      // Optionally, you can also refresh the data here
    }
  }

  Future<void> _pickNewImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _newSelectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> deleteFromApi(String idx) async {
    var url = Uri.parse("https://tasker26.vercel.app/delete/$idx");
    var res = await http.delete(url);
    if (res.statusCode == 200) {
      Navigator.of(context).pop();
      // Optionally, you can also refresh the data here
    }
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;

    return GestureDetector(
      onLongPress: () {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("What do you want to do?"),
              content: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Icon(CupertinoIcons.pen, size: mdw * 0.07),
                      onTap: () {
                        _titleController.text = widget.title;
                        _taskController.text = widget.task;

                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text("Update Blog"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CupertinoTextField(
                                    controller: _titleController,
                                    placeholder: "Title",
                                  ),
                                  SizedBox(height: mdh * 0.017),
                                  CupertinoTextField(
                                    controller: _taskController,
                                    placeholder: "Post",
                                    maxLines: 3,
                                  ),
                                  SizedBox(height: mdh * 0.017),
                                  GestureDetector(
                                    onTap: _pickNewImage,
                                    child: Container(
                                      margin: EdgeInsets.only(top: mdh * 0.017),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(_newSelectedImage != null ? 'Image Selected' : 'Pick a new image'),
                                          Icon(CupertinoIcons.photo_on_rectangle),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (_newSelectedImage != null)
                                    Container(
                                      margin: EdgeInsets.only(top: mdh * 0.017),
                                      height: mdh * 0.2,
                                      width: mdw * 0.4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(_newSelectedImage!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              actions: [
                                CupertinoButton(
                                  child: Text("Update"),
                                  onPressed: () {
                                    updateToApi(widget.idx);
                                  },
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
                    GestureDetector(
                      child: Icon(CupertinoIcons.delete, size: mdw * 0.07),
                      onTap: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text("Delete"),
                              content: Text("Are you sure you want to delete Blog ID ${widget.idx}?"),
                              actions: [
                                CupertinoButton(
                                  child: Text('Confirm'),
                                  onPressed: () {
                                    deleteFromApi(widget.idx);
                                  },
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
                  ],
                ),
              ),
              actions: [
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
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: CupertinoColors.separator),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "${widget.idx}",
              child: Container(
                height: mdw * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    alignment: Alignment.topLeft,
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.picurl),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${widget.title}",
              style: TextStyle(
                fontSize: mdw * 0.048,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5),
            Text(
              widget.task,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => HomeDetails(
              idx: widget.idx,
              task: widget.task,
              title: widget.title,
              purl: widget.picurl.toString(),
            ),
          ),
        );
      },
    );
  }
}