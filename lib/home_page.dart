import 'package:flutter/material.dart';
import 'package:flutter_dribbble/request.dart';

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
        body: TabBarView(
          children: myTabs.map((Tab tab) {
            final String label = tab.text.toLowerCase();
            return Center(
              child: Text(
                'This is the $label tab',
                style: const TextStyle(fontSize: 36),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
