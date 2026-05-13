import 'package:flutter/material.dart';
import 'package:todo_app_class/core/widgets/text_widgets.dart';
import 'package:todo_app_class/features/auth/view/widgets/custom_back_icon.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String headerText;
  final String subHeaderText;
  final bool isBackButtonVisible;

  const AuthHeaderWidget({
    super.key,
    required this.headerText,
    required this.subHeaderText,
    this.isBackButtonVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 50.0),
          isBackButtonVisible
              ? Align(alignment: Alignment.topLeft, child: CustomBackIcon())
              : SizedBox(height: 40.0),
          MediumText(text: headerText, myTextColor: Colors.white),
          const SizedBox(height: 16.0),
          SmallText(text: subHeaderText, myTextColor: Colors.white),
        ],
      ),
    );
  }
}
