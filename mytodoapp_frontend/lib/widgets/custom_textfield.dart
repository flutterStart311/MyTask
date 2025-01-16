import 'package:flutter/material.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String lableText;
  final Color borderColor;
  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.lableText,
      required this.borderColor});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        label: Text(
          widget.lableText,
          style: TextStyle(
            color: AppColors.labelTextColor,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
