import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialAuthButton extends StatelessWidget {
  final Color myBackgroundColor;
  final String iconPath;
  const SocialAuthButton({
    super.key,
    required this.myBackgroundColor,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: myBackgroundColor,
      ),
      child: IconButton(onPressed: () {}, icon: SvgPicture.asset(iconPath)),
    );
  }
}
