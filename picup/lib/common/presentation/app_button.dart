import 'package:flutter/material.dart';
import 'package:picup/common/presentation/primary_button.dart';
import 'package:picup/common/presentation/secondary_button.dart';
import 'package:picup/common/presentation/warning_button.dart';

enum AppButtonVariation { primary, secondary, warning }

class AppButton extends StatelessWidget {
  AppButton(
      {required this.onTap,
      required this.text,
      this.variation = AppButtonVariation.primary,
      super.key});
  final Function onTap;
  final String text;
  AppButtonVariation variation;

  @override
  Widget build(BuildContext context) {
    switch (variation) {
      case AppButtonVariation.primary:
        return PrimaryButton(
          onTap: () => onTap,
          text: text,
        );

      case AppButtonVariation.secondary:
        return SecondaryButton(
          onTap: () => onTap,
          text: text,
        );

      case AppButtonVariation.warning:
        return WarningButton(
          onTap: () => onTap,
          text: text,
        );
    }
  }
}
