import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/Data/database.dart';
import '../util/dialog_box.dart';
import 'package:flutter/material.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');
  final _controller = TextEditingController();
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if(_mybox.get("TODOLIST") == Null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index){
     setState(() {
       db.toDoList[index][1] = ! db.toDoList[index][1];
     });
     db.updateDataBase();
  }
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      }
    );
    db.updateDataBase();
  }
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('TO DO',
        style: TextStyle(
          fontWeight: FontWeight.w500
        ),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.yellow,
      ),
      floatingActionButton: 
      FloatingActionButton(
        shape: const CircleBorder(eccentricity: 0),
        backgroundColor: Colors.yellow[400],
        onPressed: createNewTask,
      child: 
      const Icon(
        Icons.add
      ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value,index),
            deleteFunction: (p0) => deleteTask(index),
          );
        },
        
      ),
    );
  }
}