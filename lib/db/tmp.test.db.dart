import 'package:flutter/material.dart';
import 'package:english_learning_app/db/GameModel.dart';
import 'package:english_learning_app/db/Database.dart';
import 'dart:math' as math;

/*
    Based on: https://github.com/Rahiche/sqlite_demo
*/
void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // data for testing
  List<Game> testClients = [
    Game(id: 1, title: "Raouf", storageType: "Rahiche", description: "description2"),
    Game(id: 2, title: "Zaki", storageType: "oun", description: "description1"),
    Game(id: 3, title: "oussama", storageType: "ali", description: "description3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter SQLite")),
      body: FutureBuilder<List<Game>>(
        future: DBProvider.db.getAllGames(),
        builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Game item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.description), //Text(item.storageType),
                    leading: Text(item.id.toString()),
                    trailing: Checkbox(
                      value: true,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Game rnd = testClients[math.Random().nextInt(testClients.length)];
          await DBProvider.db.newGame(rnd);
          setState(() {});
        },
      ),
    );
  }
}
