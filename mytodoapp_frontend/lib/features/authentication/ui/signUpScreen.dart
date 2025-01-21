import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodoapp_frontend/contants/colors.dart';
import 'package:mytodoapp_frontend/features/authentication/bloc/auth_bloc.dart';
import 'package:mytodoapp_frontend/features/authentication/ui/loginScreen.dart';
import 'package:mytodoapp_frontend/models/user_model.dart';
import 'package:mytodoapp_frontend/widgets/custom_button.dart';
import 'package:mytodoapp_frontend/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthBloc _authBloc = AuthBloc();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is SignUpInProgressState) {
            isLoading = true;
          } else if (state is SignUpSucessState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'SignUp Success',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: AppColors.accentColor,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          } else if (state is SignUpErrorState) {
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
                  flex: 2,
                  child: Center(
                    child: Image.asset(
                      'assets/images/signUpImage.png',
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.signUpAccentColor,
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
                            'SignUp',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: AppColors.fontColorBlack,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CustomTextfield(
                            controller: _nameController,
                            lableText: 'Name',
                            borderColor: Colors.white,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextfield(
                            controller: _emailController,
                            lableText: 'Email',
                            borderColor: Colors.white,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextfield(
                            controller: _passwordController,
                            lableText: 'Password',
                            borderColor: Colors.white,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          //Button
                          isLoading
                              ? SizedBox(
                                  height: 55,
                                  width: screenWidth,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    final user = UserModel(
                                      userID: '',
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      fcmToken: '',
                                    );

                                    _authBloc.add(SignUpEvent(userModel: user));
                                  },
                                  child: CustomButton(
                                      btnWidth: screenWidth,
                                      btnText: 'Sign Up'),
                                ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Text(
                                'Already have an account?',
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
                                'Login',
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
