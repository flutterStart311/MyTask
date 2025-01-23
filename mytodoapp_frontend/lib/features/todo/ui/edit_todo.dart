import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';
import 'package:mytodoapp_frontend/features/home/ui/home_page.dart';
import 'package:mytodoapp_frontend/features/todo/bloc/todo_bloc.dart';
import 'package:mytodoapp_frontend/models/todo_model.dart';

class EditTodo extends StatefulWidget {
  final TodoModel todo;
  const EditTodo({super.key, required this.todo});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TodoBloc _todoBloc = TodoBloc();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.description;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        toolbarHeight: 120,
        centerTitle: true,
        title: Text(
          'Edit Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
        ),
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 45,
                width: 45,
                margin: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: AppColors.accentColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.accentColor,
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        bloc: _todoBloc,
        listener: (context, state) {
          if (state is ToDoEditingState) {
            isLoading = true;
          } else if (state is ToDoEditSuccessState) {
            isLoading = false;
            _titleController.clear();
            _descriptionController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'ToDo Edited Success',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: AppColors.accentColor,
              ),
            );
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                ((Route<dynamic> roues) => false));
          } else if (state is ToDoEditingErrorState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            width: screenWidth,
            height: screenHeight - 120,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColors.textFieldBorderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColors.textFieldBorderColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    minLines: 5,
                    maxLines: 8,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColors.textFieldBorderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColors.textFieldBorderColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  isLoading
                      ? SizedBox(
                          height: 55,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            TodoModel edittedTodo = TodoModel(
                              todoID: widget.todo.todoID,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              isCompleted: widget.todo.isCompleted,
                            );

                            _todoBloc
                                .add(ToDoEditEvent(editedTodo: edittedTodo));
                          },
                          child: Container(
                            width: screenWidth,
                            height: 55,
                            decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Save Task',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
