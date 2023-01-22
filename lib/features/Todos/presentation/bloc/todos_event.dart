part of 'todos_bloc.dart';


abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class AddTodo extends TodosEvent {
  final Todos Todo;

  const AddTodo({
    required this.Todo,
  });

  @override
  List<Object> get props => [Todo];
}

class UpdateTodo extends TodosEvent {
  final Todos Todo;

  const UpdateTodo({
    required this.Todo,
  });

  @override
  List<Object> get props => [Todo];
}

class RemoveTodo extends TodosEvent {
  final Todos Todo;

  const RemoveTodo({
    required this.Todo,
  });

  @override
  List<Object> get props => [Todo];
}

class DeleteTodo extends TodosEvent {
  final Todos Todo;

  const DeleteTodo({
    required this.Todo,
  });

  @override
  List<Object> get props => [Todo];
}

class MarkFavoriteOrUnFavoriteTodo extends TodosEvent {
  final Todos Todo;

  const MarkFavoriteOrUnFavoriteTodo({
    required this.Todo,
  });

  @override
  List<Object> get props => [Todo];
}

class EditTodo extends TodosEvent {
  final Todos oldTodo;
  final Todos newTodo;

  const EditTodo({
    required this.oldTodo,
    required this.newTodo,
  });

  @override
  List<Object> get props => [
        oldTodo,
        newTodo,
      ];
}

class RestoreTodo extends TodosEvent {
  final Todos Todo;
  const RestoreTodo({
    required this.Todo,
  });

  @override
  List<Object> get props => [Todo];
}

class DeleteAllTodos extends TodosEvent {}
