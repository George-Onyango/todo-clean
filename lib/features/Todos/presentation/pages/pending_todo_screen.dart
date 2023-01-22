import 'package:flutter/material.dart';
import 'package:todo/features/Todos/data/models/todo.dart';

import '../bloc/bloc_exports.dart';
import '../widgets/todo_list.dart';

class PendingTodosScreen extends StatefulWidget {
  const PendingTodosScreen({Key? key}) : super(key: key);

  static const id = "todos_screen";

  @override
  State<PendingTodosScreen> createState() => _PendingTodosScreenState();
}

class _PendingTodosScreenState extends State<PendingTodosScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodosState>(
      builder: (context, state) {
        List<Todos> todo = state.pendingTodos;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${todo.length} Pending | ${state.completedTodos.length} Completed',
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