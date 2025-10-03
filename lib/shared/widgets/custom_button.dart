import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.shadowColor,
    required this.text,
    required this.onPressed,
    this.hasPrefixIcon = false,
    this.icon,
  });

  final Color backgroundColor;
  final Color shadowColor;
  final String text;
  final void Function() onPressed;
  final bool hasPrefixIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 55.0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasPrefixIcon
                ? Row(
                    children: [
                      Icon(icon, size: 24, color: Apptheme.primary),
                      SizedBox(width: 8),
                    ],
                  )
                : const SizedBox(),
            AutoSizeText(
              text,
              minFontSize: FontSizeManager.bodySmall,
              style: TextStyle(
                fontSize: FontSizeManager.bodyLarge,
                fontWeight: FontWeightManager.semiBold,
                color: Apptheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
