import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picup/common/presentation/app_button.dart';
import 'package:picup/common/presentation/app_devider.dart';
import 'package:picup/common/presentation/app_progress_indicator.dart';
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

final isAuthErrorLoginProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
final _formKey = GlobalKey<FormState>();

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "login",
                  child: Text(
                    "Login",
                    style: TextHeadersContatns.h1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Welcome back my friend!",
                  style: TextHeadersContatns.h4.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                const AppDevider(),
                AppSpacing.kSpaceY12,
                AppTextfield(
                  controller: ref.watch(emailContorllerProvider),
                  label: "Email",
                  hint: "example@something.com",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                AppSpacing.kSpaceY8,
                AppTextfield(
                  controller: ref.watch(passwordContorllerProvider),
                  label: "Password",
                  hint: "password123",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                AppSpacing.kSpaceY4,
                Visibility(
                    visible: ref.watch(isAuthErrorLoginProvider),
                    child: Text(
                      "Email or password is wrong",
                      style:
                          TextBodyConstants.bold14.copyWith(color: Colors.red),
                    )),
                AppSpacing.kSpaceY12,
                ref.watch(authenticationNotifierProvider) is AsyncLoading
                    ? const AppProgressIndicator()
                    : SizedBox(
                        width: 300,
                        child: AppButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(isAuthErrorLoginProvider.notifier)
                                    .state = false;
                                print("helllo");
                                final res = await ref
                                    .read(
                                        authenticationNotifierProvider.notifier)
                                    .login(
                                        email: ref
                                            .watch(emailContorllerProvider)
                                            .text,
                                        password: ref
                                            .watch(passwordContorllerProvider)
                                            .text);
                                res.fold(
                                    (l) => ref
                                        .read(isAuthErrorLoginProvider.notifier)
                                        .state = true, (r) {
                                  context.go("/");
                                });
                              }
                            },
                            text: "Log In"),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
