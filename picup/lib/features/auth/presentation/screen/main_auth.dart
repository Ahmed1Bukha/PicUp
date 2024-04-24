import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:picup/common/presentation/app_button.dart';
import 'package:picup/util/app_spacing.dart';
import 'package:picup/util/constants.dart';

class MainAuth extends ConsumerWidget {
  const MainAuth({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  "PicUp",
                  style: TextHeadersContatns.h1.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )
                    .animate()
                    .slideY(
                      duration: Durations.extralong1,
                      curve: Curves.easeInOut,
                    )
                    .fadeIn(),
              ),
              const SizedBox(),
              // SvgPicture.asset(
              //   "assets/icons/App Icon (3).svg",
              //   width: 350,
              // ),
              const Image(
                image: AssetImage("assets/icons/App Icon (7).png"),
              )
                  .animate()
                  .slideY(
                    duration: Durations.long4,
                    curve: Curves.easeInOut,
                    delay: Duration(milliseconds: 500),
                  )
                  .fadeIn(
                    delay: Duration(milliseconds: 500),
                  ),
              Column(
                children: [
                  Text(
                    "Organize your photos with ease!",
                    style:
                        TextBodyConstants.bold20.copyWith(color: Colors.white),
                  ),
                  AppSpacing.kSpaceY6,
                  Hero(
                    tag: "login",
                    child: SizedBox(
                        width: 300,
                        child: AppButton(
                            onTap: () {
                              context.go("/auth/login");
                            },
                            text: "Login")),
                  ),
                  AppSpacing.kSpaceY5,
                  Hero(
                    tag: "register",
                    child: SizedBox(
                        width: 300,
                        child: AppButton(
                          onTap: () {
                            context.go("/auth/register");
                          },
                          text: "Register",
                          variation: AppButtonVariation.secondary,
                        )),
                  )
                ],
              )
                  .animate()
                  .slideY(
                    duration: Durations.extralong1,
                    curve: Curves.easeInOut,
                    delay: Duration(milliseconds: 500),
                  )
                  .fadeIn(delay: Duration(milliseconds: 500)),
            ],
          ),
        ),
      ),
    );
  }
}
