import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomSearch extends StatelessWidget {

  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;

  bool? isPasswordField;

  CustomSearch({
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.isPasswordField
  });

  @override
  Widget build(BuildContext context) {

    bool _isPasswordField = isPasswordField ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0,10),
                  blurRadius: 50,
                  color: secondaryColor.withOpacity(0.1)
              ),
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            obscureText: _isPasswordField,
            onSubmitted: onSubmitted,
            textInputAction: textInputAction,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText ?? "Hint Text...",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                )
            ),
            // style: Constants.regularDarkText,
          ),
        ),
      ),
    );
  }
}

