import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';
import 'package:mytodoapp_frontend/widgets/custom_button.dart';
import 'package:mytodoapp_frontend/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.loginBGColorColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: SizedBox(
                    width: screenWidth - 100,
                    child:
                        Lottie.asset('assets/animations/loginAnimation.json'),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: AppColors.fontColorBlack,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Welcome Back to',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: AppColors.labelTextColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'MyTask',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: AppColors.accentColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextfield(
                        controller: _emailController,
                        lableText: 'Email',
                        borderColor: AppColors.textFieldBorderColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextfield(
                        controller: _passwordController,
                        lableText: 'Password',
                        borderColor: AppColors.textFieldBorderColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        btnWidth: screenWidth,
                        btnText: 'Login',
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Text(
                            'Don’t have an account?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              color: AppColors.fontColorBlack,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'SignUp',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: AppColors.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
