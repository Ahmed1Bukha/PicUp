import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picup/common/presentation/app_button.dart';
import 'package:picup/util/app_spacing.dart';
import 'package:picup/util/constants.dart';

class MainAuth extends ConsumerWidget {
  const MainAuth({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                "PicUp",
                style: TextHeadersContatns.h1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(),
            Column(
              children: [
                Text(
                  "Begin your journey with PicUp!",
                  style: TextBodyConstants.bold20.copyWith(color: Colors.white),
                ),
                AppSpacing.kSpaceY6,
                SizedBox(
                    width: 300,
                    child: AppButton(
                        onTap: () {
                          context.go("/auth/login");
                        },
                        text: "Login")),
                AppSpacing.kSpaceY5,
                SizedBox(
                    width: 300,
                    child: AppButton(
                      onTap: () {},
                      text: "Register",
                      variation: AppButtonVariation.secondary,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
