import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:picup/common/presentation/app_button.dart';
import 'package:picup/util/constants.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage(
      {required this.imagePath,
      required this.title,
      required this.description,
      super.key});
  final String imagePath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(imagePath),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextHeadersContatns.h1
                        .copyWith(color: ColorConstants.PRIMARY_50),
                  ),
                  Text(
                    description,
                    style: TextBodyConstants.bold20.copyWith(
                      color: ColorConstants.PRIMARY_100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
