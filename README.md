# english_learning_app

A Flutter application to learing app.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Database Management
For now by default data is reset every time application is started. To preserve data across runs change
`true` to `false` in `await DataStorage.db.DBInit(true);` in `main.dart`.  
After that database state should be preserved accross runs. This should work out of the box in 
Andoid and iOS.  
Chrome browser debug instance which is started from Android Studio after pressing "Run" does not preserve any data.
In browser Hive DB data is stored in Indexed DB (in Mozilla accessible from: Web Developer -> Web Developer Tools
-> Storade -> Indexed DB). To preserve data across runs in a browser you must access server (e.g http://localhost:41385/#/)
 from another browser window than Debug window started by Android Studio. 
You must also set port on which application will be started to fixed value. You can do it by adding e.g. 
`--web-port=49430` to Additional run args in Tools -> Run Configurations. After that data should be preserved in the 
browser.

