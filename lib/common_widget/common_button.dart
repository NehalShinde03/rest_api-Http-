import 'package:flutter/material.dart';
import 'package:http_apis/common_widget/common_text.dart';

class CommonButton extends StatelessWidget {

  final String? buttonText;
  final VoidCallback? onPressed;

  const CommonButton({super.key, this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: CommonText(text: buttonText),
    );
  }
}
