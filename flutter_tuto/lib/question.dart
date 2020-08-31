import 'package:flutter/material.dart';

class Question extends StatelessWidget {

  final String questionText;
  final Function clickHandler;

  Question(this.questionText, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child:
        RaisedButton(
          onPressed: this.clickHandler,
          child: Text(
              questionText,
              style: TextStyle(fontSize:28, backgroundColor: Colors.red),
          )
      )
    );
  }



}