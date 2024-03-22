import 'package:flutter/material.dart';
import 'package:picup/util/constants.dart';

class AppTextfield extends StatelessWidget {
  AppTextfield(
      {required this.label,
      required this.hint,
      required this.controller,
      this.obscureText = false,
      this.validator,
      this.height,
      this.width,
      this.ontab,
      this.enabled,
      super.key});
  final String label;
  final String hint;
  final TextEditingController controller;
  bool obscureText;
  String? Function(String?)? validator;
  double? height;
  double? width;
  Function? ontab;
  bool? enabled;

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
        SizedBox(
          height: height,
          width: width,
          child: TextFormField(
            enableInteractiveSelection: enabled,
            onTap: () {
              if (ontab != null) {
                ontab!();
              }
            },
            validator: validator,
            controller: controller,
            cursorColor: ColorConstants.PRIMARY_500,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              hintText: hint,
              filled: true,
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.shade200,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              errorStyle: TextBodyConstants.bold12
                  .copyWith(color: ColorConstants.ERROR_COLOR),
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
        ),
      ],
    );
  }
}
