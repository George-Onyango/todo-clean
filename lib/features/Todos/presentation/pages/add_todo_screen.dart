import 'package:flutter/material.dart';
import 'package:todo/features/Todos/data/models/todo.dart';
import 'package:todo/features/Todos/presentation/bloc/bloc_exports.dart';

import '../../data/repositories/guid_gen.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Add Todo',
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
                    var todo = Todos(
                        id: GUIDGen.generate(),
                        title: titleController.text,
                        description: descriptionController.text,
                        date: DateTime.now().toString());
                    context.read<TodoBloc>().add(AddTodo(Todo: todo));
                    Navigator.pop(context);
                  },
                  child: const Text('Add')),
            ],
          ),
        ],
      ),
    );
  }
}