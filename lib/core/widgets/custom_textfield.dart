import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final IconData? myPrefixIcon;
  final IconData? mySuffixIcon;
  final TextEditingController myController;
  final String myHintText;
  const CustomTextField({
    super.key,
    required this.myHintText,
    required this.myController,
    this.myPrefixIcon,
    this.mySuffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePassword = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13.0),
      child: Padding(
        padding: EdgeInsets.only(
          left: 13.0,
          right: 13.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: TextFormField(
          maxLines: null,
          controller: widget.myController,
          obscureText: hidePassword,
          decoration: InputDecoration(
            prefixIcon: widget.myPrefixIcon != null
                ? Icon(widget.myPrefixIcon, color: Colors.grey)
                : null,
            suffixIcon: widget.mySuffixIcon != null
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(widget.mySuffixIcon),
                    color: Colors.grey,
                  )
                : null,
            // filled: true,
            // fillColor: Colors.grey.shade200,
            hintText: widget.myHintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
