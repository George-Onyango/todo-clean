import 'package:flutter/material.dart';
import 'package:todo/features/Todos/data/models/todo.dart';

import '../bloc/bloc_exports.dart';
import '../widgets/todo_list.dart';


class FavoriteTodoScreen extends StatefulWidget {
  const FavoriteTodoScreen({Key? key}) : super(key: key);

  static const id = "todos_screen";

  @override
  State<FavoriteTodoScreen> createState() => _FavoriteTodoScreenState();
}

class _FavoriteTodoScreenState extends State<FavoriteTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodosState>(
      builder: (context, state) {
        List<Todos> todo = state.favoriteTodos;
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