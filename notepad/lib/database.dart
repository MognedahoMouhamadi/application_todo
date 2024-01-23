

import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {

  List TodoList = [];

  //ref box
  final _mybox = Hive.box('mybox');

  void createInitialData() {
    TodoList =[
      ["faire une appli", false],
      ["faire des courses", false],
      ["faire du sport",false],
    ];

  }

  void loadData() {

TodoList = _mybox.get("TODOLIST");

  }

  void updateDataBase(){

    _mybox.put("TODOLIST", TodoList);

  }

}