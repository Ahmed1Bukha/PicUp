import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:picup/features/settings/presentation/providers/fetch_username_provider.dart';
import 'package:picup/util/constants.dart';

class ProfileWidget extends ConsumerWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fetchUsernameProvider).when(
      data: (data) {
        return InfoProfile(
          name: data ?? "NA",
        );
      },
      loading: () {
        return const CircularProgressIndicator();
      },
      error: (error, stack) {
        return InfoProfile(
          name: "NA",
        );
      },
    );
  }
}

class InfoProfile extends StatelessWidget {
  InfoProfile({super.key, required this.name});

  String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Profile",
          textAlign: TextAlign.center,
          style: TextHeadersContatns.h4.copyWith(
              fontWeight: FontWeight.bold, color: ColorConstants.PRIMARY_50),
        ),
        //TODO: Add user name here:
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: ColorConstants.PRIMARY_100),
          child: Center(
              child: Text(
            name.substring(0, 2),
            style: TextHeadersContatns.h3.copyWith(
                fontWeight: FontWeight.bold, color: ColorConstants.PRIMARY_500),
          )),
        )
      ],
    );
  }
}
