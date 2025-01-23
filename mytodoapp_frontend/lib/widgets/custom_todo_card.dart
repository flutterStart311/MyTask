import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';
import 'package:mytodoapp_frontend/features/home/ui/home_page.dart';
import 'package:mytodoapp_frontend/features/todo/bloc/todo_bloc.dart';
import 'package:mytodoapp_frontend/models/todo_model.dart';

class CustomTodoCard extends StatefulWidget {
  final TodoModel todo;
  final VoidCallback viewTodoBtn;
  final VoidCallback editFunction;
  final VoidCallback deleteFunction;
  const CustomTodoCard({
    super.key,
    required this.todo,
    required this.viewTodoBtn,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  State<CustomTodoCard> createState() => _CustomTodoCardState();
}

class _CustomTodoCardState extends State<CustomTodoCard> {
  bool? _selctedValue = false;

  final TodoBloc _todoBloc = TodoBloc();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _selctedValue = widget.todo.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<TodoBloc, TodoState>(
      bloc: _todoBloc,
      listener: (context, state) {
        if (state is ToDoEditingState) {
          isEditing = true;
        } else if (state is ToDoEditSuccessState) {
          isEditing = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          width: screenWidth,
          height: 70,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                value: _selctedValue,
                onChanged: (value) {
                  setState(() {
                    _selctedValue = value;
                  });

                  TodoModel edittedTodo = TodoModel(
                    todoID: widget.todo.todoID,
                    title: widget.todo.title,
                    description: widget.todo.description,
                    isCompleted: _selctedValue!,
                  );

                  _todoBloc.add(ToDoEditEvent(editedTodo: edittedTodo));
                },
              ),
              GestureDetector(
                onTap: () {
                  widget.viewTodoBtn();
                },
                child: Text(
                  widget.todo.title,
                  style: TextStyle(
                    color: _selctedValue != null && _selctedValue == true
                        ? AppColors.fontColorBlack
                        : AppColors.accentColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    decoration: _selctedValue != null && _selctedValue == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              Spacer(),
              _selctedValue != null && _selctedValue == true
                  ? SizedBox()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.editFunction();
                          },
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.deleteFunction();
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
