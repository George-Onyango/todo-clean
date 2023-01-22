part of 'todos_bloc.dart';


class TodosState extends Equatable {
  final List<Todos> pendingTodos;
  final List<Todos> completedTodos;
  final List<Todos> favoriteTodos;
  final List<Todos> removedTodos;

  const TodosState({
    this.pendingTodos = const <Todos>[],
    this.completedTodos = const <Todos>[],
    this.favoriteTodos = const <Todos>[],
    this.removedTodos = const <Todos>[],
  });

  @override
  List<Object> get props => [
        pendingTodos,
        completedTodos,
        favoriteTodos,
        removedTodos,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTodos': pendingTodos.map((x) => x.toMap()).toList(),
      'completedTodos': pendingTodos.map((x) => x.toMap()).toList(),
      'favoriteTodos': pendingTodos.map((x) => x.toMap()).toList(),
      'removedTodos': pendingTodos.map((x) => x.toMap()).toList(),
    };
  }

  factory TodosState.fromMap(Map<String, dynamic> map) {
    return TodosState(
      pendingTodos: List<Todos>.from(
        (map['pendingTodos'])?.map<Todos>(
          (x) => Todos.fromMap(x),
        ),
      ),
      completedTodos: List<Todos>.from(
        (map['completedTodos'])?.map<Todos>(
          (x) => Todos.fromMap(x),
        ),
      ),
      favoriteTodos: List<Todos>.from(
        (map['favoriteTodos'])?.map<Todos>(
          (x) => Todos.fromMap(x),
        ),
      ),
      removedTodos: List<Todos>.from(
        (map['removedTodos'])?.map<Todos>(
          (x) => Todos.fromMap(x),
        ),
      ),
    );
  }
}

