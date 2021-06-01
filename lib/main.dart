import 'package:flutter/material.dart';
import 'package:mobile_dev_code_challenge/Home.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Color(0xFFC3BEF0),
          shadowColor: Colors.red,
        ),
        scaffoldBackgroundColor: Color(0xFFDEFCF9),
        accentColor: Color(0xFFCADEFC),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Proxima-Nova',
      ),
      initialRoute: '/',
      routes: {},
      home: Home(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
