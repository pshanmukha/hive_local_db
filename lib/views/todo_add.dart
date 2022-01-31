import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive_database/adapters/todo_adapter.dart';

class AddTodo extends StatefulWidget {

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String ? title, description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Add Title'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Add description'),
            ),
            ElevatedButton(onPressed: submitData, child: Text('Submit'))
          ],
        ),
      ),
    );
  }

  submitData() async {
    if (_formkey.currentState!.validate()) {
      Box<Todo> todoBox = Hive.box<Todo>('todos');
      todoBox.add(Todo(title: _titleController.text, description: _descriptionController.text));
      Navigator.of(context).pop();
    }
  }
}
