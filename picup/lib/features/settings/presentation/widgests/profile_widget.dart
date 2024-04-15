import 'package:flutter/material.dart';
import 'package:picup/util/constants.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Profile",
          textAlign: TextAlign.center,
          style: TextHeadersContatns.h3.copyWith(
              fontWeight: FontWeight.bold, color: ColorConstants.PRIMARY_50),
        ),
        //TODO: Add user name here:
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: ColorConstants.PRIMARY_100),
          child: Center(
              child: Text(
            "SA",
            style: TextHeadersContatns.h3.copyWith(
                fontWeight: FontWeight.bold, color: ColorConstants.PRIMARY_500),
          )),
        )
      ],
    );
  }
}
