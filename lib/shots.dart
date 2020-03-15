import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dribbble/request.dart';

class ShotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShotState();
  }
}

class ShotState extends State<ShotPage> {
  List<Shot> shots;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[Image.network(shots[0]?.images?.normal ?? '')],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future<String> response = requestUserShots();
    response.then((response) {
      final parsed = jsonDecode(response);
      shots = parsed.map((model) => Shot.fromJson(model)).toList().cast<Shot>();
      setState(() {});
    });
  }
}

class Shot {
  final int id;
  final Images images;
  final List<String> tags;
  final String title;
  final String published_at;

  Shot({this.id, this.images, this.tags, this.title, this.published_at});

  factory Shot.fromJson(Map<String, dynamic> json) {
    return Shot(
        id: json['id'] as int,
        images: Images.fromJson(json['images']),
        tags: json['tags'].cast<String>(),
        title: json['title'] as String,
        published_at: json['published_at'] as String);
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
