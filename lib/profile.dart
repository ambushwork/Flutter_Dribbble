import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dribbble/request.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<ProfilePage> {
  Profile profile;

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Center(
      child: Column(
        children: <Widget>[
          Image.network(profile?.avatar_url ?? ''),
          Text(
            'Profile name: ${profile?.name}',
            style: const TextStyle(fontSize: 36),
          ),
          Text(
            'Location: ${profile?.location}',
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future<String> response = requestUserProfile();
    response.then((response) {
      final parsed = jsonDecode(response);
      profile = Profile.fromJson(parsed);
      setState(() {});
    });
  }
}

class Profile {
  final int id;
  final String location;
  final String name;
  final String avatar_url;
  final String html_url;

  Profile({this.id, this.location, this.name, this.avatar_url, this.html_url});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        id: json['id'] as int,
        location: json['location'] as String,
        name: json['name'] as String,
        avatar_url: json['avatar_url'] as String,
        html_url: json['html_url'] as String);
  }
}
