import 'package:flutter/material.dart';
import 'package:todo/features/Todos/data/models/todo.dart';
import 'package:todo/features/Todos/presentation/widgets/todo_list.dart';

import '../bloc/bloc_exports.dart';

class CompletedTodosScreen extends StatefulWidget {
  const CompletedTodosScreen({Key? key}) : super(key: key);

  static const id = "todos_screen";

  @override
  State<CompletedTodosScreen> createState() => _CompletedTodosScreenState();
}

class _CompletedTodosScreenState extends State<CompletedTodosScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodosState>(
      builder: (context, state) {
        List<Todos> todo = state.completedTodos;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${todo.length} Todos',
                ),
              ),
            ),
            TodosList(todos: todo)
          ],
        );
      },
    );
  }
}