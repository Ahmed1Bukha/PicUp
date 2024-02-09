import 'package:flutter/material.dart';
import 'package:picup/util/constants.dart';

class WarningButton extends StatelessWidget {
  const WarningButton({required this.onTap, required this.text, super.key});
  final Function onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: ColorConstants.PRIMARY_300,
      color: Colors.white,
      onPressed: onTap(),
      child: Text(
        text,
        style: TextHeadersContatns.h3.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
