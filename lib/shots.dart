import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dribbble/request.dart';

class ShotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShotState();
  }
}

class ShotState extends State<ShotPage> {
  List<Shot> shots;
  ListView listView;

  @override
  Widget build(BuildContext context) {
    if (listView == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Center(child: listView);
  }

  @override
  void initState() {
    super.initState();
    Future<String> response = requestUserShots();
    response.then((response) {
      final parsed = jsonDecode(response);
      shots = parsed.map((model) => Shot.fromJson(model)).toList().cast<Shot>();
      listView = new ListView.builder(
          itemCount: shots.length,
          itemBuilder: (context, index) {
            return new ShotItem(shots[index].id, shots[index].title,
                shots[index].images, shots[index].description);
          });
      setState(() {});
    });
  }
}

class ShotItem extends StatelessWidget {
  final String title;
  final int id;
  final Images images;
  final String description;

  ShotItem(
    this.id,
    this.title,
    this.images,
    this.description,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.down,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          title,
          style: TextStyle(fontSize: 26),
        ),
        new Text(
          description ?? '',
          style: TextStyle(fontSize: 24, color: new Color(0xFF42A5F5)),
        ),
        Image.network(images.hidpi)
      ],
    );
  }
}

class Shot {
  final int id;
  final Images images;
  final List<String> tags;
  final String title;
  final String published_at;
  final String description;

  Shot(
      {this.id,
      this.images,
      this.tags,
      this.title,
      this.published_at,
      this.description});

  factory Shot.fromJson(Map<String, dynamic> json) {
    return Shot(
        id: json['id'] as int,
        images: Images.fromJson(json['images']),
        tags: json['tags'].cast<String>(),
        title: json['title'] as String,
        published_at: json['published_at'] as String,
        description: json['description'] as String);
  }
}

class Images {
  final String hidpi;
  final String normal;
  final String one_x;
  final String two_x;
  final String four_x;
  final String teaser;

  Images(
      {this.hidpi,
      this.normal,
      this.one_x,
      this.two_x,
      this.four_x,
      this.teaser});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
        hidpi: json['hidpi'] as String,
        normal: json['normal'] as String,
        one_x: json['one_x'] as String,
        two_x: json['two_x'] as String,
        four_x: json['four_x'] as String,
        teaser: json['teaser'] as String);
  }
}
