import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/MenuPage.dart';

class MenuPageState extends State<MenuPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'English learning',
          style: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          Row(
              children: <Widget> [
                Text('12 ', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300)),
                Icon(Icons.stars_rounded, size: 32),
                Text(' '),
              ],
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text(
                'Game 1',
                style: GoogleFonts.quicksand(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                ),

              ),
              style: TextButton.styleFrom(
                primary: Colors.deepOrange,
                padding: EdgeInsets.all(16.0),
                //backgroundColor: Colors.grey,
                //onSurface: Colors.white,
              ),
              onPressed: (){
                print ('Game 1');
              },
            ),
            SizedBox(height: 25),
            TextButton(
              child: Text(
                'Game 2',
                style: GoogleFonts.quicksand(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                ),

              ),
              style: TextButton.styleFrom(
                primary: Colors.deepOrange,
                //backgroundColor: Colors.grey,
                //onSurface: Colors.white,
              ),
              onPressed: (){
                print ('Game 2');
              },
            ),
            SizedBox(height: 25),
            TextButton(
              child: Text(
                'Settings',
                style: GoogleFonts.quicksand(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                ),

              ),
              style: TextButton.styleFrom(
                primary: Colors.deepOrange,
                //backgroundColor: Colors.grey,
                //onSurface: Colors.white,
              ),
              onPressed: (){
                print ('Settings');
              },
            ),
          ],
        ),
      ),
    );
  }
}
