import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:picup/common/presentation/app_button.dart';
import 'package:picup/common/presentation/app_textfield.dart';
import 'package:picup/features/auth/presentation/controller/auth_controller.dart';
import 'package:picup/util/app_spacing.dart';
import 'package:picup/util/constants.dart';

final emailContorllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

final passwordContorllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextHeadersContatns.h1
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            AppTextfield(
              controller: ref.watch(emailContorllerProvider),
              label: "Email",
              hint: "example@something.com",
            ),
            AppSpacing.kSpaceY4,
            AppTextfield(
              controller: ref.watch(passwordContorllerProvider),
              label: "Password",
              hint: "password123",
              obscureText: true,
            ),
            AppSpacing.kSpaceY4,
            AppButton(
                onTap: () async {
                  print("helllo");
                  final res = await ref
                      .read(authenticationNotifierProvider.notifier)
                      .login(
                          email: ref.watch(emailContorllerProvider).text,
                          password: ref.watch(passwordContorllerProvider).text);
                  res.fold((l) => print("gg"), (r) => print("pog"));
                },
                text: "Log Me In")
          ],
        ),
      ),
    );
  }
}
