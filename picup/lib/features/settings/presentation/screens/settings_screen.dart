import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:picup/common/presentation/app_button.dart';
import 'package:picup/features/settings/presentation/controllers/settings_controller.dart';
import 'package:picup/features/settings/presentation/widgests/contact_info_widget.dart';
import 'package:picup/features/settings/presentation/widgests/profile_widget.dart';
import 'package:picup/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScereen extends ConsumerWidget {
  const SettingsScereen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final controller = ref.watch(settingsControllerProvider);
    final controllerMethod = ref.read(settingsControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: TextHeadersContatns.h3.copyWith(
              fontWeight: FontWeight.bold, color: ColorConstants.PRIMARY_50),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Center(
            child: ProfileWidget(),
          ),
          Column(
            children: [
              AppButton(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Signout"),
                      content: Text("Are you sure you want to signout?"),
                      actions: [
                        TextButton(
                            onPressed: () => context.pop(),
                            child: Text("Cancel")),
                        controller is AsyncLoading
                            ? const CircularProgressIndicator()
                            : TextButton(
                                onPressed: () async {
                                  final res = await controllerMethod.signOut();
                                  res.fold(
                                      (l) => SnackBar(
                                          content: Text(
                                              "Something went wrong. Try again")),
                                      (r) => context.go("/auth"));
                                },
                                child: Text("Signout"))
                      ],
                    ),
                  );
                },
                text: "Signout",
                variation: AppButtonVariation.secondary,
              ),
              AppButton(
                onTap: () => null,
                text: "Delete Account",
                variation: AppButtonVariation.warning,
              ),
            ],
          ),
          const ContactInfoWidget()
        ],
      ),
    );
  }
}
