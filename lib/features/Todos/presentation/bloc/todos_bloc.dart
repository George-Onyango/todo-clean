import 'dart:async';
import '../../data/models/todo.dart';
import 'package:equatable/equatable.dart';
import './bloc_exports.dart';
part 'todos_event.dart';
part 'todos_state.dart';

class TodoBloc extends HydratedBloc<TodosEvent, TodosState> {
  TodoBloc() : super(const TodosState()) {
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<MarkFavoriteOrUnFavoriteTodo>(_onMarkFavoriteOrUnFavoriteTodo);
    on<EditTodo>(_onEditTodo);
    on<RestoreTodo>(_onRestoreTodo);
    on<DeleteAllTodos>(_onDeleteAllTodo);
  }

  FutureOr<void> _onAddTodo(AddTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    emit(TodosState(
      pendingTodos: List.from(state.pendingTodos)..add(event.Todo),
      completedTodos: state.completedTodos,
      favoriteTodos: state.favoriteTodos,
      removedTodos: state.removedTodos,
    ));
  }

  FutureOr<void> _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    final Todo = event.Todo;
    List<Todos> pendingTodo = state.pendingTodos;
    List<Todos> completedTodo = state.completedTodos;
    List<Todos> favoriteTodo = state.favoriteTodos;

    if (Todo.isDone == false) {
      if (Todo.isFavorite == false) {
        pendingTodo = List.from(pendingTodo)..remove(Todo);
        completedTodo.insert(0, Todo.copyWith(isDone: true));
      } else {
        var TodoIndex = favoriteTodo.indexOf(Todo);
        pendingTodo = List.from(pendingTodo)..remove(Todo);
        completedTodo.insert(0, Todo.copyWith(isDone: true));
        favoriteTodo = List.from(favoriteTodo)
          ..remove(Todo)
          ..insert(TodoIndex, Todo.copyWith(isDone: true));
      }
    } else {
      if (Todo.isFavorite == false) {
        completedTodo = List.from(completedTodo)..remove(Todo);
        pendingTodo = List.from(pendingTodo)
          ..insert(0, Todo.copyWith(isDone: false));
      } else {
        var TodoIndex = favoriteTodo.indexOf(Todo);
        completedTodo = List.from(completedTodo)..remove(Todo);
        pendingTodo = List.from(pendingTodo)
          ..insert(0, Todo.copyWith(isDone: false));
        favoriteTodo = List.from(favoriteTodo)
          ..remove(Todo)
          ..insert(TodoIndex, Todo.copyWith(isDone: false));
      }
    }
    emit(TodosState(
      pendingTodos: state.pendingTodos,
      completedTodos: state.completedTodos,
      favoriteTodos: state.favoriteTodos,
      removedTodos: state.removedTodos,
    ));
  }

  FutureOr<void> _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    emit(TodosState(
        pendingTodos: state.pendingTodos,
        completedTodos: state.completedTodos,
        favoriteTodos: state.favoriteTodos,
        removedTodos: List.from(state.removedTodos)..remove(event.Todo)));
  }

  FutureOr<void> _onRemoveTodo(RemoveTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    emit(TodosState(
        pendingTodos: List.from(state.pendingTodos)..remove(event.Todo),
        completedTodos: List.from(state.completedTodos)..remove(event.Todo),
        favoriteTodos: List.from(state.favoriteTodos)..remove(event.Todo),
        removedTodos: List.from(state.removedTodos)
          ..add(event.Todo.copyWith(isDeleted: true))));
  }

  @override
  TodosState? fromJson(Map<String, dynamic> json) {
    return TodosState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TodosState state) {
    return state.toMap();
  }

  FutureOr<void> _onMarkFavoriteOrUnFavoriteTodo(
      MarkFavoriteOrUnFavoriteTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    List<Todos> pendingTodo = state.pendingTodos;
    List<Todos> completedTodo = state.completedTodos;
    List<Todos> favoriteTodo = state.favoriteTodos;

    if (event.Todo.isDone == false) {
      if (event.Todo.isFavorite == false) {
        var TodoIndex = pendingTodo.indexOf(event.Todo);
        pendingTodo = List.from(pendingTodo)
          ..remove(event.Todo)
          ..insert(TodoIndex, event.Todo.copyWith(isFavorite: true));
        favoriteTodo.insert(0, event.Todo.copyWith(isFavorite: true));
      } else {
        var TodoIndex = pendingTodo.indexOf(event.Todo);
        pendingTodo = List.from(pendingTodo)
          ..remove(event.Todo)
          ..insert(TodoIndex, event.Todo.copyWith(isFavorite: false));
        favoriteTodo.remove(event.Todo);
      }
    } else {
      if (event.Todo.isFavorite == false) {
        var TodoIndex = completedTodo.indexOf(event.Todo);
        completedTodo = List.from(completedTodo)
          ..remove(event.Todo)
          ..insert(TodoIndex, event.Todo.copyWith(isFavorite: true));
        favoriteTodo.insert(0, event.Todo.copyWith(isFavorite: true));
      } else {
        var TodoIndex = completedTodo.indexOf(event.Todo);
        completedTodo = List.from(completedTodo)
          ..remove(event.Todo)
          ..insert(TodoIndex, event.Todo.copyWith(isFavorite: false));
        favoriteTodo.remove(event.Todo);
      }
    }
    emit(TodosState(
      pendingTodos: pendingTodo,
      completedTodos: completedTodo,
      favoriteTodos: favoriteTodo,
      removedTodos: state.removedTodos,
    ));
  }

  FutureOr<void> _onEditTodo(EditTodo event, Emitter<TodosState> emit) async {
    final state = this.state;
    List<Todos> favoriteTodo = state.favoriteTodos;
    if (event.oldTodo.isFavorite == true) {
      favoriteTodo
        ..remove(event.oldTodo)
        ..insert(0, event.newTodo);
    }
    emit(
      TodosState(
        pendingTodos: List.from(state.pendingTodos)
          ..remove(event.oldTodo)
          ..insert(0, event.newTodo),
        completedTodos: state.completedTodos..remove(event.oldTodo),
        favoriteTodos: favoriteTodo,
        removedTodos: state.removedTodos,
      ),
    );
  }

  FutureOr<void> _onRestoreTodo(
      RestoreTodo event, Emitter<TodosState> emit) async {
    final state = this.state;
    emit(
      TodosState(
        removedTodos: List.from(state.removedTodos)..remove(event.Todo),
        pendingTodos: List.from(state.pendingTodos)
          ..insert(
              0,
              event.Todo.copyWith(
                isDeleted: false,
                isDone: false,
                isFavorite: false,
              )),
        completedTodos: state.completedTodos,
        favoriteTodos: state.favoriteTodos,
      ),
    );
  }

  FutureOr<void> _onDeleteAllTodo(
      DeleteAllTodos event, Emitter<TodosState> emit) async {
    final state = this.state;
    emit(
      TodosState(
        removedTodos: List.from(state.removedTodos)..clear(),
        pendingTodos: state.pendingTodos,
        completedTodos: state.completedTodos,
        favoriteTodos: state.favoriteTodos,
      ),
    );
  }
}