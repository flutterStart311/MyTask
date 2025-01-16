import 'package:flutter/material.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';

class ViewTodo extends StatelessWidget {
  const ViewTodo({super.key});

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
          'View Task',
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
              height: 10,
            ),
            Text(
              'Routine Exercise',
              style: TextStyle(
                color: AppColors.fontColorBlack,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                fontSize: 14,
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
              height: 10,
            ),
            Text(
              'Routine exercise every morning with sports, either running, or swimming, or jogging, or badminton, futsal, or similar sports. Work out to form a better body and live a healthier life. hopefully all this can be achieved.',
              style: TextStyle(
                color: AppColors.fontColorBlack,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
