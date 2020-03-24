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
  GridView gridView;

  @override
  Widget build(BuildContext context) {
    if (gridView == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Center(child: gridView);
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
            return new GestureDetector(
              onTap: () => tapEvent(context, shots[index]),
              child: new ShotItem(shots[index].id, shots[index].title,
                  shots[index].images, shots[index].description),
            );
          });

      gridView = new GridView.builder(
          itemCount: shots.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 6),
          itemBuilder: (context, index) {
            return new GestureDetector(
              onTap: () => tapEvent(context, shots[index]),
              child: new ShotItem(shots[index].id, shots[index].title,
                  shots[index].images, shots[index].description),
            );
          });

      setState(() {});
    });
  }

  tapEvent(BuildContext context, Shot shot) {
    showDialog(
        context: context,
        builder: (ctx) {
          return ShotDialogView(shot);
        });
  }
}

class ShotDialogView extends StatelessWidget {
  final Shot shot;

  ShotDialogView(this.shot);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.network(shot.images.hidpi),
          Text(
            'DONE',
            style: TextStyle(fontSize: 22),
          )
        ],
      ),
    );
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
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
        ),
        new Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        Image.network(images.normal)
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
