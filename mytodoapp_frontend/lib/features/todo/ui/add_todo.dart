import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';
import 'package:mytodoapp_frontend/features/home/ui/home_page.dart';
import 'package:mytodoapp_frontend/features/todo/bloc/todo_bloc.dart';
import 'package:mytodoapp_frontend/models/todo_model.dart';
import 'package:mytodoapp_frontend/widgets/custom_button.dart';
import 'package:uuid/uuid.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TodoBloc todoBloc = TodoBloc();

  bool isLoading = false;

  String todoUniqueID = '';

  @override
  void initState() {
    super.initState();
    todoUniqueID = Uuid().v4();
    print('Unique ID: $todoUniqueID');
  }

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
          'Add Task',
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
        bloc: todoBloc,
        listener: (context, state) {
          if (state is ToDoAddingState) {
            isLoading = true;
          } else if (state is ToDoAddedSucessState) {
            isLoading = false;
            _titleController.clear();
            _descriptionController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'ToDo Added Success',
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
          } else if (state is ToDoAddingErrorState) {
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
                          width: screenWidth,
                          height: 55,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (_titleController.text.isEmpty ||
                                _descriptionController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please enter title and description',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              TodoModel model = TodoModel(
                                todoID: todoUniqueID,
                                title: _titleController.text,
                                description: _descriptionController.text,
                                isCompleted: false,
                              );

                              todoBloc.add(ToDoAddEvent(todoModel: model));
                            }
                          },
                          child: CustomButton(
                            btnWidth: screenWidth,
                            btnText: 'Create Task',
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
