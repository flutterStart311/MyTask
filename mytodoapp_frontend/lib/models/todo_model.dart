class TodoModel {
  final String todoID;
  final String title;
  final String description;
  final bool isCompleted;

  TodoModel({
    required this.todoID,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'todoID': todoID,
      'Title': title,
      'Description': description,
      'isCompleted': isCompleted,
    };
  }
}
