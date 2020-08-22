import 'package:flutter/material.dart';
import 'homePage.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget{
  _MyAppState createState() =>_MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 2),
        (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>homePage()));
        }
    );
  }



  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Image(image: AssetImage("assets/logo2.jpg")
        )
      ),
    );
  }

}




