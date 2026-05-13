import 'package:flutter/material.dart';

class CustomTextFieldAuth extends StatefulWidget {
  TextEditingController myController = TextEditingController();
  bool isPasswordField;
  final String myHintText;
  CustomTextFieldAuth({
    super.key,
    required this.myHintText,
    this.isPasswordField = false,
    required this.myController,
  });

  @override
  State<CustomTextFieldAuth> createState() => _CustomTextFieldAuthState();
}

class _CustomTextFieldAuthState extends State<CustomTextFieldAuth> {
  bool hidePassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: widget.myController,
      obscureText: hidePassword,
      decoration: InputDecoration(
        suffixIcon: widget.isPasswordField
            ? IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: Icon(
                  hidePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade200,

        hintText: widget.myHintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
