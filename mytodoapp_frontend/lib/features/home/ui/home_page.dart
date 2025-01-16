import 'package:flutter/material.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';
import 'package:mytodoapp_frontend/widgets/custom_todo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Saturday, Feb 20 2022',
              style: TextStyle(
                color: AppColors.dateTextColor,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
            Spacer(),
            Image.asset('assets/images/notification.png'),
          ],
        ),
      ),
      body: Container(
        height: screenHeight - AppBar().preferredSize.height,
        width: screenWidth,
        child: Column(
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
                    'Welcome Phillip',
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
                          value: 0.8,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          backgroundColor: AppColors.progressBarBGColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '80%',
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
              height: screenHeight - (AppBar().preferredSize.height + 274),
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
                    height:
                        screenHeight - (AppBar().preferredSize.height + 299),
                    child: Column(
                      children: [
                        CustomTodoCard(
                          cardTitle: 'Work Out',
                          isTaskCompleted: true,
                        ),
                        CustomTodoCard(
                          cardTitle: 'Work 2 Out',
                          isTaskCompleted: true,
                        ),
                        CustomTodoCard(
                          cardTitle: 'Work 3 Out',
                          isTaskCompleted: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.accentColor,
        onPressed: () {},
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
