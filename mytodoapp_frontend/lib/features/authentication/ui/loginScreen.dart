import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';
import 'package:mytodoapp_frontend/features/authentication/bloc/auth_bloc.dart';
import 'package:mytodoapp_frontend/features/authentication/ui/signUpScreen.dart';
import 'package:mytodoapp_frontend/features/home/ui/home_page.dart';
import 'package:mytodoapp_frontend/widgets/custom_button.dart';
import 'package:mytodoapp_frontend/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  final String fcmToken;
  const LoginScreen({super.key, required this.fcmToken});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthBloc _authBloc = AuthBloc();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.loginBGColorColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is SignInProgressState) {
            isLoading = true;
          } else if (state is SignInSuccessState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Login Success',
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
                (Route<dynamic> routes) => false);
          } else if (state is SignInErrorState) {
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
          return SafeArea(
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
                    child: SingleChildScrollView(
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
                          isLoading
                              ? SizedBox(
                                  height: 55,
                                  width: screenWidth,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    _authBloc.add(
                                      SignInEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        fcmToken: widget.fcmToken,
                                      ),
                                    );
                                  },
                                  child: CustomButton(
                                    btnWidth: screenWidth,
                                    btnText: 'Login',
                                  ),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(
                                        fcmToken: widget.fcmToken,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: AppColors.accentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
