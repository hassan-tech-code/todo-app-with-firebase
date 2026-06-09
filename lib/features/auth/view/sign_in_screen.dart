import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_class/core/constants/app_assets.dart';
import 'package:todo_app_class/core/widgets/text_widgets.dart';
import 'package:todo_app_class/features/auth/view/forgot_password.dart';
import 'package:todo_app_class/features/auth/view/sign_up_screen.dart';
import 'package:todo_app_class/features/auth/view/widgets/auth_header_widget.dart';
import 'package:todo_app_class/features/auth/view/widgets/custom_elevated_button.dart';
import 'package:todo_app_class/features/auth/view/widgets/custom_textfield_auth.dart';
import 'package:todo_app_class/features/auth/view/widgets/social_auth_button.dart';
import 'package:todo_app_class/features/auth/view_model/auth_view_model.dart';
import 'package:todo_app_class/features/home_screen/view/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerInstance = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthHeaderWidget(
            headerText: 'Log In',
            subHeaderText: 'Please sign in to your existing account',
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.0),
                      SmallText(text: 'EMAIL', myTextColor: Colors.black),
                      SizedBox(height: 10),
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
                      SizedBox(height: 20),
                      SmallText(text: 'PASSWORD', myTextColor: Colors.black),
                      SizedBox(height: 10),
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
                      SizedBox(height: 6),

                      ///remember me and forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              SmallText(
                                text: 'Remember me',
                                myTextColor: Colors.grey,
                                myFontSize: 14,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              /// Navigate to the forgot password screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: SmallText(
                              text: 'Forgot password?',
                              myTextColor: Colors.redAccent,
                              myFontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 17),

                      ///sign in button
                      CustomElevatedButtonAuth(
                        isLoading: providerInstance.loading,
                        buttonText: 'LOG IN',

                        onPressedFunction: () async {
                          if (formKey.currentState!.validate()) {
                            await providerInstance.signIn(
                              emailController.text.toString(),
                              passwordController.text.toString(),
                            );
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallText(
                            text: 'Don\'t have an account?',
                            myTextColor: Colors.grey.shade600,
                            myFontSize: 15,
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
                            child: SmallText(
                              text: 'SIGN UP',
                              myTextColor: Colors.redAccent,
                              myFontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: SmallText(
                          text: 'Or',
                          myTextColor: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: 20),
                          SocialAuthButton(
                            myBackgroundColor: Colors.purple,
                            iconPath: AppAssets.facebookIcon,
                          ),
                          SizedBox(width: 20),
                          SocialAuthButton(
                            myBackgroundColor: Colors.blue,
                            iconPath: AppAssets.googleIcon,
                          ),
                          SizedBox(width: 20),
                          SocialAuthButton(
                            myBackgroundColor: Colors.black,
                            iconPath: AppAssets.appleIcon,
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                      SizedBox(height: 35),
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
