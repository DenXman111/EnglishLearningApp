import 'package:flutter/material.dart';

class Definition extends StatelessWidget {
  final String definitionText;

  Definition(this.definitionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        definitionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ), //Text
    ); //Contaier
  }
}