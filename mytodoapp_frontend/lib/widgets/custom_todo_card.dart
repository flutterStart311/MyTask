import 'package:flutter/material.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';

class CustomTodoCard extends StatefulWidget {
  final String cardTitle;
  final bool isTaskCompleted;
  const CustomTodoCard(
      {super.key, required this.cardTitle, required this.isTaskCompleted});

  @override
  State<CustomTodoCard> createState() => _CustomTodoCardState();
}

class _CustomTodoCardState extends State<CustomTodoCard> {
  int _selctedRadioValue = -1;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
          Radio(
            value: widget.isTaskCompleted ? 1 : 0,
            groupValue: _selctedRadioValue,
            onChanged: (value) {
              setState(() {
                _selctedRadioValue = value!;
              });
            },
          ),
          Text(
            widget.cardTitle,
            style: TextStyle(
              color: widget.isTaskCompleted
                  ? AppColors.fontColorBlack
                  : AppColors.accentColor,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
          Spacer(),
          widget.isTaskCompleted
              ? SizedBox()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      height: 5,
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ],
                ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
