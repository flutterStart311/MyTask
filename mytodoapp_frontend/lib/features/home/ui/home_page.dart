import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';
import 'package:mytodoapp_frontend/features/todo/bloc/todo_bloc.dart';
import 'package:mytodoapp_frontend/features/todo/ui/add_todo.dart';
import 'package:mytodoapp_frontend/features/todo/ui/edit_todo.dart';
import 'package:mytodoapp_frontend/features/notification/ui/notification_screen.dart';
import 'package:mytodoapp_frontend/features/todo/ui/view_todo.dart';
import 'package:mytodoapp_frontend/models/todo_model.dart';
import 'package:mytodoapp_frontend/models/user_model.dart';
import 'package:mytodoapp_frontend/widgets/custom_todo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoBloc _todoBloc = TodoBloc();

  bool isLoading = true;

  List<TodoModel> allTodos = [];
  List<TodoModel> allCompletedTodos = [];

  UserModel? user;

  @override
  void initState() {
    super.initState();
    _todoBloc.add(ToDoInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    //Delete Conformation
    void deleteConfirmationDialog(String todoID, TodoBloc todoBloC) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Conformation'),
            content: Text('Are you sure to delete?'),
            actions: [
              TextButton(
                onPressed: () {
                  todoBloC.add(ToDoDeleteEvent(todoID: todoID));
                  Navigator.pop(context);
                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              DateFormat('EEEE, MMM d, yyyy').format(DateTime.now()),
              style: TextStyle(
                color: AppColors.dateTextColor,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
              child: Image.asset('assets/images/notification.png'),
            ),
          ],
        ),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        bloc: _todoBloc,
        listener: (context, state) {
          if (state is ToDoFetchingState) {
            isLoading = true;
          } else if (state is ToDoFetchSuccessState) {
            isLoading = false;
            allTodos = state.allTodos;
            allCompletedTodos = state.completedTasks;
            user = state.user;
          } else if (state is ToDoFetchingErrorState) {
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
          } else if (state is TodoDeleteSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'ToDo Deleted Success',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: AppColors.accentColor,
              ),
            );
            _todoBloc.add(ToDoInitialFetchEvent());
          } else if (state is TodoDeleteErrorState) {
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
          return SizedBox(
            height: screenHeight - AppBar().preferredSize.height,
            width: screenWidth,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: 250,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Welcome ${user?.name}',
                              style: TextStyle(
                                color: AppColors.fontColorBlack,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              'Have a nice day !',
                              style: TextStyle(
                                color: AppColors.dateTextColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              'Today Progress',
                              style: TextStyle(
                                color: AppColors.fontColorBlack,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: screenWidth,
                              height: 80,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/menu.png'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(
                                    'Progress',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  LinearProgressIndicator(
                                    value: (allCompletedTodos.length /
                                        allTodos.length),
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                    backgroundColor:
                                        AppColors.progressBarBGColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${((allCompletedTodos.length / allTodos.length) * 100).toStringAsFixed(0)}%',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth,
                        height: screenHeight -
                            (AppBar().preferredSize.height + 274),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                              child: Text(
                                'Daily Tasks',
                                style: TextStyle(
                                  color: AppColors.fontColorBlack,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: screenHeight -
                                  (AppBar().preferredSize.height + 309),
                              child: allTodos.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No any Todo',
                                        style: TextStyle(
                                          color: AppColors.fontColorBlack,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: allTodos.length,
                                      itemBuilder: (context, index) {
                                        return CustomTodoCard(
                                          viewTodoBtn: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ViewTodo(
                                                  todoModel: allTodos[index],
                                                ),
                                              ),
                                            );
                                          },
                                          deleteFunction: () {
                                            deleteConfirmationDialog(
                                                allTodos[index].todoID,
                                                _todoBloc);
                                          },
                                          editFunction: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditTodo(
                                                  todo: allTodos[index],
                                                ),
                                              ),
                                            );
                                          },
                                          todo: allTodos[index],
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.accentColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodo()));
        },
        label: Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Add Task',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
