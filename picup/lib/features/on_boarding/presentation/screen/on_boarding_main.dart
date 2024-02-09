import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picup/common/presentation/app_button.dart';
import 'package:picup/features/on_boarding/presentation/widget/onboarding_page.dart';
import 'package:picup/util/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final isLostPageOnboardingProvider = StateProvider<bool>((ref) {
  return false;
});

final pageControllerProvider = Provider.autoDispose<PageController>((ref) {
  final PageController pageController = PageController();
  return pageController;
});

class OnBoardingMain extends ConsumerWidget {
  const OnBoardingMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController pageController = ref.watch(pageControllerProvider);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              if (value == 2) {
                ref.read(isLostPageOnboardingProvider.notifier).state = true;
              } else {
                ref.read(isLostPageOnboardingProvider.notifier).state = false;
              }
            },
            controller: pageController,
            children: const [
              OnboardingPage(
                title: "Welcome",
                imagePath: 'assets/images/fist.svg',
                description:
                    '''Lorem ipsum dolor sit amet consectetur. Lacus tortor massa lectus aliquet consectetur at. Nisl vitae ipsum in risus lacus ipsum.
                    ''',
              ),
              OnboardingPage(
                title: "Hard",
                imagePath: 'assets/images/second.svg',
                description:
                    'Lorem ipsum dolor sit amet consectetur. Lacus tortor massa lectus aliquet consectetur at. Nisl vitae ipsum in risus lacus ipsum.',
              ),
              OnboardingPage(
                title: "Join",
                imagePath: 'assets/images/third.svg',
                description:
                    'Lorem ipsum dolor sit amet consectetur. Lacus tortor massa lectus aliquet consectetur at. Nisl vitae ipsum in risus lacus ipsum.',
              ),
            ],
          ),
          Align(
              alignment: const Alignment(0, 0.8),
              child: ref.watch(isLostPageOnboardingProvider)
                  ? AppButton(
                      onTap: () {
                        context.go("/auth");
                      },
                      text: "Start My Jouney")
                  : AppButton(
                      variation: AppButtonVariation.secondary,
                      onTap: () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      text: "Next")),
          Align(
              alignment: const Alignment(0, 0.9),
              child: SmoothPageIndicator(
                controller: ref.watch(pageControllerProvider), // PageController
                count: 3,
                // forcing the indicator to use a specific direction

                effect: const WormEffect(
                  dotColor: Colors.white,
                  activeDotColor: ColorConstants.PRIMARY_300,
                ),
              ))
        ],
      ),
    );
  }
}
