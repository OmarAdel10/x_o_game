import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class OverallStatsContainerItem extends StatelessWidget {
  const OverallStatsContainerItem({
    super.key,
    required this.statNumber,
    required this.statText,
    this.statNumberColor = Apptheme.silver,
  });

  final int statNumber;
  final String statText;
  final Color? statNumberColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Apptheme.deepDarkNavy,
      elevation: 1,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Text(
                '$statNumber',
                style: GoogleFonts.roboto(
                  color: statNumberColor,
                  fontSize: FontSizeManager.mediumNumber,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              Text(
                statText,
                style: GoogleFonts.roboto(
                  color: Apptheme.silver,
                  fontSize: FontSizeManager.tiny,
                  fontWeight: FontWeightManager.light,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
