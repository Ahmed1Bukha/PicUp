import 'package:flutter/material.dart';
import 'package:picup/util/constants.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: ColorConstants.PRIMARY_100,
    );
  }
}
