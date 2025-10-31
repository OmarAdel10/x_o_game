import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class BotChallengeContainerItem extends StatelessWidget {
  const BotChallengeContainerItem({
    super.key,
    required this.modeText,
    required this.winingPercentNumber,
    required this.totalGamesInThisMode,
    required this.totalWiningsInThisMode,
  });

  final String modeText;
  final int winingPercentNumber;
  final int totalGamesInThisMode;
  final int totalWiningsInThisMode;

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);

    return Card(
      color: Apptheme.deepDarkNavy,
      elevation: 1,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              Text(
                modeText,
                style: GoogleFonts.roboto(
                  color: Apptheme.silver,
                  fontSize: FontSizeManager.bodySmall,
                  fontWeight: FontWeightManager.sectionTitles,
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '$winingPercentNumber% ',
                        style: GoogleFonts.roboto(
                          color: Apptheme.silver,
                          fontSize: FontSizeManager.smallNumber,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                      Text(
                        localization.win_rate,
                        style: GoogleFonts.roboto(
                          color: Apptheme.silver,
                          fontSize: FontSizeManager.tiny,
                          fontWeight: FontWeightManager.light,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$totalWiningsInThisMode/$totalGamesInThisMode ${localization.wins}',
                    style: GoogleFonts.roboto(
                      color: Apptheme.silver.withValues(alpha: 0.6),
                      fontSize: FontSizeManager.tiny,
                      fontWeight: FontWeightManager.light,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
