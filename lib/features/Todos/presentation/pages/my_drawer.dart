import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import 'recycle_bin.dart';
import 'tabs_screen.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            color: Colors.grey,
            child: Text(
              'Todo Drawer',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          BlocBuilder<TodoBloc, TodosState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(TabsScreen.id),
                child: ListTile(
                  leading: const Icon(Icons.folder_special),
                  title: const Text('My Todos'),
                  trailing: Text(
                      '${state.pendingTodos.length} | ${state.completedTodos.length}'),
                ),
              );
            },
          ),
          const Divider(),
          BlocBuilder<TodoBloc, TodosState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                child: ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Bin'),
                  trailing: Text('${state.removedTodos.length}'),
                ),
              );
            },
          ),
          BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state) {
              return Switch(
                  value: state.switchValue,
                  onChanged: ((newValue) {
                    print(newValue);
                    if (newValue) {
                      context.read<SwitchBloc>().add(SwitchOnEvent());
                    } else {
                      context.read<SwitchBloc>().add(SwitchOffEvent());
                    }
                  }));
            },
          )
        ],
      )),
    );
  }
}