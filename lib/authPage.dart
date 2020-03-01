import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dribbble/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

const platform = const MethodChannel('samples.flutter.dev/battery');

class AuthPage extends StatefulWidget {
  AuthPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isAuth = false;
  String _code;

  Future<String> getCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = prefs.getString('code_preference');
    setState(() {
      if (code != null) {
        isAuth = true;
        _code = code;
      }
    });
  }

  Future<void> _getSPCode() async {
    String code = '';
    try {
      code = await platform.invokeMethod('getAuthCode');
    } on PlatformException catch (e) {
      code = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {
      _code = code;
      log('_code: $_code');
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('auth code $_code'),
            RaisedButton(
              onPressed: _getSPCode,
              child: Text('get Code'),
            ),
            RaisedButton(
              onPressed: () =>
                  _code == null ? startDribbbleAuth() : getAccessToken(_code),
              child: Text(_code == null ? 'start Auth' : 'get access token'),
            )
          ],
        ),
      ),
    );
  }
}
