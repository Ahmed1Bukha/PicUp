import 'package:flutter/material.dart';
import 'package:picup/util/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({required this.onTap, required this.text, super.key});
  final Function onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateProperty.all<Color>(ColorConstants.PRIMARY_400),
        backgroundColor:
            MaterialStateProperty.all<Color>(ColorConstants.PRIMARY_300),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: onTap(),
      child: Text(
        text,
        style: TextHeadersContatns.h3.copyWith(
            fontWeight: FontWeight.bold, color: ColorConstants.PRIMARY_50),
      ),
    );
  }
}
