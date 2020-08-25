import 'package:flutter/material.dart';
import 'package:flutter_animation_circle/animationparametrs.dart';
import 'animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CircleAnimation(
          firstWidget: Container(
            color: Colors.amber,
          ),
          secondWidget: Container(
            color: Colors.black,
          ),
          movingTheButton: movingTheButton,
        ));
  }
}
