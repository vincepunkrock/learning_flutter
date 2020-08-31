import 'package:flutter/material.dart';
import 'MyComponent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green[900]),
      home:
        Scaffold(
          body: MyComponent()
        )
    );
  }
}

