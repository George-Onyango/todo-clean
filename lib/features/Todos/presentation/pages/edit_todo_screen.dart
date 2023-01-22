import 'package:flutter/material.dart';
import 'package:todo/features/Todos/data/models/todo.dart';

import '../bloc/bloc_exports.dart';

class EditTodoScreen extends StatelessWidget {
  final Todos oldTodo;
  const EditTodoScreen({
    Key? key,
    required this.oldTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTodo.title);
    TextEditingController descriptionController =
        TextEditingController(text: oldTodo.description);
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Edit Todo',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                  label: Text("Title"), border: OutlineInputBorder()),
            ),
          ),
          TextField(
            controller: descriptionController,
            autofocus: true,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
                label: Text("Description"), border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var editedTodo = Todos(
                        id: oldTodo.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        date: DateTime.now().toString());
                    context
                        .read<TodoBloc>()
                        .add(EditTodo(newTodo: editedTodo, oldTodo: oldTodo));
                    Navigator.pop(context);
                  },
                  child: const Text('Save')),
            ],
          ),
        ],
      ),
    );
  }
}