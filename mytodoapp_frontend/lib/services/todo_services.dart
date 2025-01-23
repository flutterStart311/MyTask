import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytodoapp_frontend/models/todo_model.dart';

class TodoServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  List<TodoModel> allToDos = [];
  List<TodoModel> completedTodos = [];

  Future<void> addTodoToDatabase(TodoModel todoModel) async {
    await _firestore
        .collection("Users")
        .doc(_auth.currentUser!.uid)
        .collection("ToDos")
        .doc(todoModel.todoID)
        .set(todoModel.toJson());
  }

  Future<void> getAllToDos() async {
    allToDos.clear();
    QuerySnapshot querySnapshot = await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .collection('ToDos')
        .get();

    for (var docs in querySnapshot.docs) {
      TodoModel todoModelGetting = TodoModel(
        todoID: docs['todoID'],
        title: docs['Title'],
        description: docs['Description'],
        isCompleted: docs['isCompleted'],
      );

      allToDos.add(todoModelGetting);
    }
  }

  Future<void> getAllCompletedToDos() async {
    completedTodos.clear();
    QuerySnapshot querySnapshot = await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .collection('ToDos')
        .get();

    for (var docs in querySnapshot.docs) {
      TodoModel todoModelGetting = TodoModel(
        todoID: docs['todoID'],
        title: docs['Title'],
        description: docs['Description'],
        isCompleted: docs['isCompleted'],
      );

      if (todoModelGetting.isCompleted == true) {
        completedTodos.add(todoModelGetting);
      }
    }
  }

  Future<void> todoEdit(TodoModel editedTodo) async {
    await _firestore
        .collection("Users")
        .doc(_auth.currentUser!.uid)
        .collection('ToDos')
        .doc(editedTodo.todoID)
        .update(editedTodo.toJson());
  }

  Future<void> todoDelete(String deleteTodoID) async {
    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .collection('ToDos')
        .doc(deleteTodoID)
        .delete();
  }
}
