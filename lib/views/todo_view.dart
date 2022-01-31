import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive_database/adapters/todo_adapter.dart';
import 'package:todo_hive_database/views/todo_add.dart';
import 'package:todo_hive_database/views/todo_update.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Todo Example"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddTodo()),
            );
          }, icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Todo>('todos').listenable(),
            builder: (context, Box<Todo> box, _) {
              if (box.values.isEmpty) {
                return Center(child: const Text("No Data Available"),);
              }
              return ListView.builder(
                itemCount: box.length,
                  itemBuilder: (context, index) {
                  Todo? todo = box.getAt(index);
                  return Dismissible(
                    key: Key('${index}'),
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.startToEnd) { delete(box, index);}
                      else {delete(box, index);}
                    },
                    child: ListTile(
                      title: Text(todo!.title),
                      subtitle: Text(todo.description),
                      trailing: IconButton(icon: Icon(Icons.edit),onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => UpdateTodo(indexData: index, data: Todo(title: todo.title, description: todo.description),)),
                        );
                      },),
                      onLongPress: () async {
                        await box.deleteAt(index);
                      },
                    ),
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            Text('Move to trash', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            Text('Move to trash', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  );
                  }
              );
            }
          ),
        ),
      ),
    );
  }
  delete (box, index) async {
    await box.deleteAt(index);
  }
}
