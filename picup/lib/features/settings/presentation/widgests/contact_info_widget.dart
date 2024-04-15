import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:picup/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(_url) async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }

    return Column(
      children: [
        Text(
          "You can find me @:",
          style:
              TextHeadersContatns.h3.copyWith(color: ColorConstants.PRIMARY_50),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () async {
                  final Uri _url = Uri.parse('https://twitter.com/NotBukha');
                  await _launchUrl(_url);
                },
                icon: SvgPicture.asset("assets/icons/uil_twitter.svg")),
            IconButton(
                onPressed: () async {
                  final Uri _url = Uri.parse(
                      'https://www.linkedin.com/in/ahmed-bukhamsin-2174aa245/');
                  await _launchUrl(_url);
                },
                icon: SvgPicture.asset("assets/icons/mdi_linkedin.svg")),
            IconButton(
                onPressed: () async {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'ahmedbukha@hotmail.com',
                    query: 'subject=PicUp inquery',
                  );

                  await _launchUrl(emailLaunchUri);
                },
                icon:
                    SvgPicture.asset("assets/icons/mdi_microsoft-outlook.svg"))
          ],
        )
      ],
    );
  }
}
