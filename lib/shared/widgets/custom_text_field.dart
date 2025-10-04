import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      cursorColor: Apptheme.silver,
      cursorWidth: 2,
      decoration: InputDecoration(
        hint: Text(
          hintText,
          style: GoogleFonts.roboto(
            color: Apptheme.secondaryText.withValues(alpha: 0.5),
            fontSize: FontSizeManager.caption,
            fontWeight: FontWeightManager.regular,
          ),
        ),
      ),
      style: GoogleFonts.roboto(
        color: Apptheme.secondaryText,
        fontSize: FontSizeManager.caption,
        fontWeight: FontWeightManager.regular,
      ),
    );
  }
}
