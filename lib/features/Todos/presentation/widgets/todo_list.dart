import 'package:flutter/material.dart';
import 'package:todo/features/Todos/data/models/todo.dart';

import 'todo_tile.dart';

class TodosList extends StatelessWidget {
  const TodosList({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final List<Todos> todos;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: todos
              .map((todos) => ExpansionPanelRadio(
                  value: todos.id,
                  headerBuilder: (context, isExpanded) => TodoTile(Todo: todos),
                  body: ListTile(
                    title: SelectableText.rich(TextSpan(children: [
                      const TextSpan(
                        text: 'Text\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: todos.title),
                      const TextSpan(
                        text: '\n\nDescription\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: todos.description),
                    ])),
                  )))
              .toList(),
        ),
      ),
    );
  }
}
