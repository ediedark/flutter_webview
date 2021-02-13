import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview/page/home.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'Flutter Fab Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Home(),
    );
  }
}

