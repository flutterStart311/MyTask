import 'package:flutter/material.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';

class EditTodo extends StatefulWidget {
  const EditTodo({super.key});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
            Container(
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
          ],
        ),
        backgroundColor: AppColors.accentColor,
      ),
      body: Container(
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
            Container(
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
          ],
        ),
      ),
    );
  }
}
