import 'package:flutter/material.dart';

import '../../data/models/todo.dart';

class PopupMenu extends StatelessWidget {
  final Todos todo;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback edittodoCallback;
  final VoidCallback restoretodoCallback;

  const PopupMenu({
    Key? key,
    required this.todo,
    required this.cancelOrDeleteCallback,
    required this.likeOrDislikeCallback,
    required this.edittodoCallback,
    required this.restoretodoCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: todo.isDeleted == false
            ? ((context) => [
                  PopupMenuItem(
                      onTap: null,
                      child: TextButton.icon(
                          onPressed: edittodoCallback,
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'))),
                  PopupMenuItem(
                    onTap: likeOrDislikeCallback,
                    child: TextButton.icon(
                        onPressed: null,
                        icon: todo.isFavorite == false
                            ? const Icon(Icons.bookmark_add_outlined)
                            : const Icon(Icons.bookmark_remove),
                        label: todo.isFavorite == false
                            ? const Text('Add to Bookmarks')
                            : const Text('Remove from Bookmarks')),
                  ),
                  PopupMenuItem(
                      onTap: cancelOrDeleteCallback,
                      child: TextButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete')))
                ])
            : (context) => [
                  PopupMenuItem(
                      onTap: restoretodoCallback,
                      child: TextButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.restore_from_trash),
                          label: const Text('Restore'))),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.delete_forever),
                        label: const Text('Delete Forever')),
                    onTap: cancelOrDeleteCallback,
                  )
                ]);
  }
}