import 'package:english_learning_app/db/Database.dart';
import 'package:intl/intl.dart';

class TotalPoints{
    final formatter = new NumberFormat("### ");
    int get(){
      return DataStorage.db.getTotalPoints();
    }

    void set(int points){
      DataStorage.db.setTotalPoints(points);
    }
}