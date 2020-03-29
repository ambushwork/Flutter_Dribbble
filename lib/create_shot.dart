import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

class CreateShotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateShotState();
  }
}

class CreateShotState extends State<CreateShotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a shot"),
      ),
      body: new Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          new Column(
            children: <Widget>[
              MyInputField(
                inputHint: "Add a title here",
              ),
              GestureDetector(
                onTap: requestPermission,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: DottedBorder(
                    color: Colors.grey,
                    strokeWidth: 2,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/ic_upload.png",
                            height: 36,
                            width: 36,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyInputField(
                title: "Description",
                inputHint: "Add an optional description",
              ),
              MyInputField(
                title: "Tags",
                inputHint: "Seperate tags with commas or spaces",
              ),
            ],
          ),
          SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.all(16),
                child: FloatingActionButton(
                  onPressed: () {
                    showToast();
                  },
                  child: Text("Publish"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                ),
              )),
        ],
      ),
    );
  }

  requestPermission() async {
    var status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      getImage();
    }
  }

  showToast() {
    Toast.show("onPressed", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
}

class MyInputField extends StatelessWidget {
  String title;
  String inputHint;

  MyInputField({this.title, this.inputHint});

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          padding: EdgeInsets.all(8),
          child: Text(
            title ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        new Container(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(hintText: inputHint ?? ''),
            ))
      ],
    );
  }
}
