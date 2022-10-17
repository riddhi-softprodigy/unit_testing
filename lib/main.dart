import 'package:audioPlayer/unitTesting/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:audioPlayer/controller/miniPlayerController.dart';
// import 'dart:audioPlayer';

import 'package:audioPlayer/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      NeumorphicTheme(
        theme: NeumorphicThemeData(
          intensity: 0.8,
          baseColor: Colors.white,
          accentColor: Colors.black,
          lightSource: LightSource.topLeft,
        ),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MusicPlayerDataProvider(),
        ),
      ],
      child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter audioPlayer Demo',
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          home: LoginScreen()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(child: Container()),
    );
  }
}
