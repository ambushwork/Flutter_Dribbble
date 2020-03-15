import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dribbble/profile.dart';
import 'package:flutter_dribbble/request.dart';
import 'package:flutter_dribbble/shots.dart';

import 'authPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  var isAuth = false;

  @override
  void initState() {
    super.initState();
    var accessToken = queryAccessToken();
    accessToken.then((token) {
      if (token != null) {
        log("Access Token: $accessToken");
        setState(() {
          isAuth = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      Tab(text: 'Shots'),
      Tab(text: 'Profile'),
    ];

    if (!isAuth) {
      return AuthPage(title: 'flutter_dribbble');
    }

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(children: [ShotPage(), ProfilePage()]),
      ),
    );
  }
}
