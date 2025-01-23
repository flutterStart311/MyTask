import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mytodoapp_frontend/models/todo_model.dart';
import 'package:mytodoapp_frontend/models/user_model.dart';
import 'package:mytodoapp_frontend/services/home_services.dart';
import 'package:mytodoapp_frontend/services/todo_services.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoServices _todoServices = TodoServices();
  final HomeServices _homeServices = HomeServices();

  TodoBloc() : super(TodoInitial()) {
    on<ToDoAddEvent>(toDoAddEvent);
    on<ToDoInitialFetchEvent>(toDoInitialFetchEvent);
    on<ToDoEditEvent>(toDoEditEvent);
    on<ToDoDeleteEvent>(toDoDeleteEvent);
  }

  FutureOr<void> toDoAddEvent(
      ToDoAddEvent event, Emitter<TodoState> emit) async {
    try {
      emit(ToDoAddingState());
      await _todoServices.addTodoToDatabase(event.todoModel);
      emit(ToDoAddedSucessState());
    } catch (e) {
      emit(ToDoAddingErrorState(error: e.toString()));
    }
  }

  FutureOr<void> toDoInitialFetchEvent(
      ToDoInitialFetchEvent event, Emitter<TodoState> emit) async {
    try {
      emit(ToDoFetchingState());
      await _todoServices.getAllToDos();
      await _todoServices.getAllCompletedToDos();
      await _homeServices.getUser();
      emit(ToDoFetchSuccessState(
          allTodos: _todoServices.allToDos,
          user: _homeServices.user!,
          completedTasks: _todoServices.completedTodos));
    } catch (e) {
      emit(ToDoFetchingErrorState(error: e.toString()));
    }
  }

  FutureOr<void> toDoEditEvent(
      ToDoEditEvent event, Emitter<TodoState> emit) async {
    try {
      emit(ToDoEditingState());
      await _todoServices.todoEdit(event.editedTodo);
      emit(ToDoEditSuccessState());
    } catch (e) {
      emit(ToDoAddingErrorState(error: e.toString()));
    }
  }

  FutureOr<void> toDoDeleteEvent(
      ToDoDeleteEvent event, Emitter<TodoState> emit) async {
    try {
      emit(ToDoEditingState());
      await _todoServices.todoDelete(event.todoID);
      emit(TodoDeleteSuccessState());
    } catch (e) {
      emit(TodoDeleteErrorState(error: e.toString()));
    }
  }
}
