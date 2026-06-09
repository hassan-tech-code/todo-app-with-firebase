import 'package:flutter/material.dart';

class CustomElevatedButtonAuth extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressedFunction;
  final bool isLoading;
  const CustomElevatedButtonAuth({
    super.key,
    required this.buttonText,
    required this.onPressedFunction,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : Text(
              buttonText,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
    );
  }
}
