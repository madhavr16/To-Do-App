import 'package:hive_flutter/adapters.dart';

class ToDoDataBase {
  List<dynamic> toDoList = [];
 
 final _mybox = Hive.box('mybox');

 void createInitialData(){
  toDoList = [
    ['Do Exercise', false],
    ['Make New Apps', false]
  ];
 }

 void loadData(){
   var data = _mybox.get("TODOLIST");
   if (data != null) {
     toDoList = data;
   } else {
     toDoList = [];
   }
 }

 void updateDataBase(){
   _mybox.put("TODOLIST", toDoList);
 }
}