import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/home/statistics/data/models/recent_games_model.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class RecentGamesContainerItem extends StatelessWidget {
  final RecentGamesModel model;

  const RecentGamesContainerItem({super.key, required this.model});

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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        model.modeName,
                        style: GoogleFonts.roboto(
                          color: Apptheme.silver,
                          fontSize: FontSizeManager.bodySmall,
                          fontWeight: FontWeightManager.regular,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${model.gameDate.day} / ${model.gameDate.month} / ${model.gameDate.year}',
                    style: GoogleFonts.roboto(
                      color: Apptheme.silver.withValues(alpha: 0.6),
                      fontSize: FontSizeManager.tiny,
                      fontWeight: FontWeightManager.light,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                model.gameResult,
                style: GoogleFonts.roboto(
                  color: model.gameResultColor,
                  fontSize: FontSizeManager.bodySmall,
                  fontWeight: FontWeightManager.sectionTitles,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
