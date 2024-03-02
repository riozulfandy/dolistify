import 'package:hive_flutter/hive_flutter.dart';

class ToDoData {
  var box = Hive.box('myBox');
  List todoList = [];

  void initialData() {
    todoList = [
      ["Your todo", false]
    ];
  }

  void loadData() {
    todoList = box.get('todoList');
  }

  void updateData() {
    box.put('todoList', todoList);
  }
}
