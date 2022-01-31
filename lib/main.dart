import 'package:flutter/material.dart';
import 'package:todo_hive_database/adapters/todo_adapter.dart';
import 'package:todo_hive_database/views/todo_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Initialize hive
  await Hive.initFlutter();
  //register type adapter
  Hive.registerAdapter(TodoAdapter());
  // Open the peopleBox
  await Hive.openBox<Todo>('todos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Todo Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoView(),
    );
  }
}

