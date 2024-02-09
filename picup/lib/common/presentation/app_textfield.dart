import 'package:flutter/material.dart';
import 'package:picup/util/constants.dart';

class AppTextfield extends StatelessWidget {
  AppTextfield(
      {required this.label,
      required this.hint,
      required this.controller,
      this.obscureText = false,
      super.key});
  final String label;
  final String hint;
  final TextEditingController controller;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextBodyConstants.bold16
              .copyWith(color: ColorConstants.PRIMARY_200),
        ),
        TextField(
          controller: controller,
          cursorColor: ColorConstants.PRIMARY_500,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            focusColor: ColorConstants.PRIMARY_300,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorConstants.PRIMARY_200,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorConstants.PRIMARY_200,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        ),
      ],
    );
  }
}
