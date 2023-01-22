import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc_exports.dart';
import '../../data/models/todo.dart';
import '../pages/edit_todo_screen.dart';
import 'popup_menu.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key? key,
    required this.Todo,
  }) : super(key: key);

  final Todos Todo;

  void _removeOrDeleteTodo(BuildContext context, Todos Todo) {
    Todo.isDeleted!
        ? context.read<TodoBloc>().add(DeleteTodo(Todo: Todo))
        : context.read<TodoBloc>().add(RemoveTodo(Todo: Todo));
  }

  void _editTodo(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: ((context) {
          return SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
              child: EditTodoScreen(oldTodo: Todo),
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Todo.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Todo.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              decoration: Todo.isDone!
                                  ? TextDecoration.lineThrough
                                  : null)),
                      Text(DateFormat()
                          .add_yMMMd()
                          .add_Hms()
                          .format(DateTime.parse(Todo.date))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: Todo.isDone,
                onChanged: Todo.isDeleted == false
                    ? (value) {
                        ctx.read<TodoBloc>().add(UpdateTodo(Todo: Todo));
                      }
                    : null,
              ),
              PopupMenu(
                cancelOrDeleteCallback: () => _removeOrDeleteTodo(ctx, Todo),
                todo: Todo,
                likeOrDislikeCallback: () => ctx
                    .read<TodoBloc>()
                    .add(MarkFavoriteOrUnFavoriteTodo(Todo: Todo)),
                edittodoCallback: () {
                  Navigator.of(ctx).pop();
                  _editTodo(ctx);
                },
                restoretodoCallback: () =>
                    ctx.read<TodoBloc>().add(RestoreTodo(Todo: Todo)),
              )
            ],
          )
        ],
      ),
    );
  }
}
