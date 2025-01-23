part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class ToDoAddEvent extends TodoEvent {
  final TodoModel todoModel;
  ToDoAddEvent({required this.todoModel});
}

class ToDoInitialFetchEvent extends TodoEvent {}

class ToDoEditEvent extends TodoEvent {
  final TodoModel editedTodo;
  ToDoEditEvent({required this.editedTodo});
}

class ToDoDeleteEvent extends TodoEvent {
  final String todoID;
  ToDoDeleteEvent({required this.todoID});
}
