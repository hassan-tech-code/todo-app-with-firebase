import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_class/core/widgets/text_widgets.dart';
import 'package:todo_app_class/features/auth/view/widgets/auth_header_widget.dart';
import 'package:todo_app_class/features/auth/view/widgets/custom_elevated_button.dart';
import 'package:todo_app_class/features/auth/view/widgets/custom_textfield_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String statusText = '';
  Color statusTextColor = Colors.transparent;
  dynamic myFirebaseForgotPassword(String email) async {
    if (email.isEmpty) {
      setState(() {
        statusText = 'Please enter your email';
        statusTextColor = Colors.red;
      });
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        setState(() {
          statusText = 'Password reset email sent';
          statusTextColor = Colors.green;
        });
      } on FirebaseAuthException catch (ex) {
        setState(() {
          statusText = ex.code.toString();
          statusTextColor = Colors.red;
        });
      }
    }
  }

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          AuthHeaderWidget(
            headerText: 'Forgot Password',
            subHeaderText: 'Enter your email to reset your password',
            isBackButtonVisible: true,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                  SmallText(text: 'Email'),
                  SizedBox(height: 13),
                  CustomTextFieldAuth(
                    myHintText: 'Enter your email',
                    myController: emailController,
                  ),
                  SizedBox(height: 10),
                  SmallText(text: statusText, myTextColor: statusTextColor),
                  SizedBox(height: 10),

                  CustomElevatedButtonAuth(
                    buttonText: 'Send Password reset email',
                    onPressedFunction: () {
                      myFirebaseForgotPassword(emailController.text.toString());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
