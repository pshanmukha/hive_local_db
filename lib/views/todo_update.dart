import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive_database/adapters/todo_adapter.dart';

class UpdateTodo extends StatefulWidget {
  int? indexData ;
  Todo? data ;
  UpdateTodo({required this.indexData,required this.data});
  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {

  final _formkey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  String ? title, description;

  @override
  void initState() {
    // TODO: implement initState
   _titleController = TextEditingController(text: widget.data!.title);
   _descriptionController = TextEditingController(text: widget.data!.description);
    super.initState();
  }
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
              decoration: InputDecoration(hintText: 'Update Title'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Update description'),
            ),
            ElevatedButton(onPressed: () => updateData(widget.indexData), child: Text('Update'))
          ],
        ),
      ),
    );
  }

  updateData(index) async {
    if (_formkey.currentState!.validate()) {
      Box<Todo> todoBox = Hive.box<Todo>('todos');
      todoBox.putAt(index, Todo(title: _titleController.text, description: _descriptionController.text));
      Navigator.of(context).pop();
    }
  }
}
