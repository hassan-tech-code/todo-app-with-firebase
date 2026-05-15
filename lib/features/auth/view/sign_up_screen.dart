import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_app_class/core/widgets/text_widgets.dart';
import 'package:todo_app_class/features/auth/view/sign_in_screen.dart';
import 'package:todo_app_class/features/auth/view/widgets/auth_header_widget.dart';
import 'package:todo_app_class/features/auth/view/widgets/custom_elevated_button.dart';
import 'package:todo_app_class/features/auth/view/widgets/custom_textfield_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  dynamic myFirebaseSignUp(String name, String email, String password) async {
    try {
      showDialog(
        context: context,
        builder: (context) =>
            Center(child: CircularProgressIndicator(color: Colors.grey)),
      );
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => FirebaseFirestore.instance
                .collection('users')
                .doc(value.user?.uid)
                .set({'name': name, 'email': email}),
          );
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
      toastification.show(
        //backgroundColor: Colors.green,
        title: Text('Account created successfully'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    } on FirebaseAuthException catch (ex) {
      if (context.mounted) Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(ex.code.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          AuthHeaderWidget(
            headerText: 'Sign Up',
            subHeaderText: 'Please sign up to get started',
            isBackButtonVisible: true,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.0),
                      SmallText(text: 'NAME', myTextColor: Colors.black),
                      SizedBox(height: 7),
                      CustomTextFieldAuth(
                        myController: nameController,
                        myHintText: 'Enter your name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 17.0),
                      SmallText(text: 'EMAIL', myTextColor: Colors.black),
                      SizedBox(height: 7),
                      CustomTextFieldAuth(
                        myController: emailController,
                        myHintText: 'example@gmail.com',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 17),
                      SmallText(text: 'PASSWORD', myTextColor: Colors.black),
                      SizedBox(height: 7),
                      CustomTextFieldAuth(
                        myController: passwordController,
                        myHintText: 'Enter your password',
                        isPasswordField: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 17),
                      SmallText(
                        text: 'RE-TYPE PASSWORD',
                        myTextColor: Colors.black,
                      ),
                      SizedBox(height: 7),
                      CustomTextFieldAuth(
                        myController: confirmPasswordController,
                        myHintText: 'confirm password',
                        isPasswordField: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password again to confirm';
                          } else if (value != passwordController.text) {
                            return 'Password and confirm password should be same';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      CustomElevatedButtonAuth(
                        buttonText: 'SIGN UP',
                        onPressedFunction: () {
                          if (formkey.currentState!.validate()) {
                            myFirebaseSignUp(
                              nameController.text.toString(),
                              emailController.text.toString(),
                              passwordController.text.toString(),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
