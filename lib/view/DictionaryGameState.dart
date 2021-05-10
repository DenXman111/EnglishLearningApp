import 'dart:async';
import 'dart:convert';

import 'package:english_learning_app/viewmodel/DictionaryGame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../viewmodel/DictionaryGame.dart';

class DictionaryGameState extends State<DictionaryGame> {
  final String _url = "https://owlbot.info/api/v4/dictionary/";
  final String _token = "df27c4ddec1a5ff491357e84d9833c7350a2a6d7";

  TextEditingController _editingController = TextEditingController();

  Timer _typingTimer;
  StreamController _streamController;
  Stream _stream;

  _search() async{
    if (_editingController.text == null || _editingController.text.length == 0){
      _streamController.add(null);
      return;
    }
    _streamController.add("waiting");
    http.Response response = await http.get(Uri.parse(_url + _editingController.text.trim()), headers: {"Authorization": "Token " + _token});
    _streamController.add(json.decode(response.body));
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Dictionary',
          style: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12, bottom: 8, top: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextFormField(
                    onChanged: (String text) {
                      if (_typingTimer?.isActive ?? false) _typingTimer.cancel();
                      _typingTimer = Timer(const Duration(milliseconds: 1000), () {
                        _search();
                      });
                    },
                    controller: _editingController,
                    decoration: InputDecoration(
                      hintText: "Type a word...",
                      contentPadding: const EdgeInsets.only(left: 24),
                      border: InputBorder.none,
                    ),
                  ),
                )
              ),

              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  _search();
                },
              )
            ],
          )
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: StreamBuilder(
          stream: _stream,
          builder: (BuildContext ctx, AsyncSnapshot snapshot){
            if (snapshot.data == null){
              return Center(child: Text(""));
            }

            if (snapshot.data == "waiting"){
              return Center(child: CircularProgressIndicator(),);
            }

            if (snapshot.data.length <= 1){
              return Center(child: Text("Word not found"));
            }

            return ListView.builder(
              itemCount: snapshot.data["definitions"].length,
              itemBuilder: (BuildContext context, int index) {
                return ListBody(
                  children: <Widget> [
                    Container(
                      color: Colors.grey[300],
                      child: ListTile(
                        leading: snapshot.data["definitions"][index]["image_url"] == null
                            ? null
                            : CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data["definitions"][index]["image_url"]),
                              ),
                        title: Text(_editingController.text.trim() + "(" + snapshot.data["definitions"][index]["type"] + ")")
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snapshot.data["definitions"][index]["definition"]),
                    )
                  ],
                );
              });
          },
        ),
      )
    );
  }
}
