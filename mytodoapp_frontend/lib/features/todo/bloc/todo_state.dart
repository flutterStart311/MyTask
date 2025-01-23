part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

class ToDoAddingState extends TodoState {}

class ToDoAddedSucessState extends TodoState {}

class ToDoAddingErrorState extends TodoState {
  final String error;
  ToDoAddingErrorState({required this.error});
}

class ToDoFetchingState extends TodoState {}

class ToDoFetchSuccessState extends TodoState {
  final List<TodoModel> allTodos;
  final UserModel user;
  final List<TodoModel> completedTasks;
  ToDoFetchSuccessState(
      {required this.allTodos,
      required this.user,
      required this.completedTasks});
}

class ToDoFetchingErrorState extends TodoState {
  final String error;
  ToDoFetchingErrorState({required this.error});
}

class ToDoEditingState extends TodoState {}

class ToDoEditSuccessState extends TodoState {}

class ToDoEditingErrorState extends TodoState {
  final String error;
  ToDoEditingErrorState({required this.error});
}

class TodoDeletingState extends TodoState {}

class TodoDeleteSuccessState extends TodoState {}

class TodoDeleteErrorState extends TodoState {
  final String error;
  TodoDeleteErrorState({required this.error});
}
