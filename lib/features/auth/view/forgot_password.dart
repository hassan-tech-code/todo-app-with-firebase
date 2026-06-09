import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_class/core/widgets/text_widgets.dart';
import 'package:todo_app_class/features/auth/view/widgets/auth_header_widget.dart';
import 'package:todo_app_class/features/auth/view/widgets/custom_elevated_button.dart';
import 'package:todo_app_class/features/auth/view/widgets/custom_textfield_auth.dart';
import 'package:todo_app_class/features/auth/view_model/auth_view_model.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerReference = context.watch<AuthViewModel>();
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
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallText(text: 'Email'),
                      SizedBox(height: 13),
                      CustomTextFieldAuth(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                        myHintText: 'Enter your email',
                        myController: emailController,
                      ),

                      SmallText(
                        text: providerReference.statusText,
                        myTextColor: providerReference.statusTextColor,
                      ),
                      SizedBox(height: 4),

                      CustomElevatedButtonAuth(
                        buttonText: 'Send Password reset email',
                        onPressedFunction: () {
                          if (formkey.currentState!.validate()) {
                            providerReference.forogotPassword(
                              emailController.text.toString().trim(),
                            );
                          }
                        },
                      ),
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
