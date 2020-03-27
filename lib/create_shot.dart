import 'package:flutter/material.dart';

class CreateShotPage extends StatelessWidget {
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
                  onPressed: () {},
                  child: Text("Publish"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                ),
              )),
        ],
      ),
    );
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
