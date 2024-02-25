import 'package:flutter/material.dart';
import 'package:picup/util/constants.dart';

class AppDevider extends StatelessWidget {
  const AppDevider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Divider(
          thickness: 3,
          color: ColorConstants.PRIMARY_50,
        ));
  }
}
