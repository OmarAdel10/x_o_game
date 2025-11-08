import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class SliderComponentsWidget extends StatefulWidget {
  final int currentIndex;
  final List<String> sliderLabels;
  const SliderComponentsWidget({
    super.key,
    required this.currentIndex,
    required this.sliderLabels,
  });

  @override
  State<SliderComponentsWidget> createState() => _SliderComponentsWidgetState();
}

class _SliderComponentsWidgetState extends State<SliderComponentsWidget> {
  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    final difficultyModeContainerEmojis = ['😊', '🤔', '😈'];
    final difficultyModeContainerQuotes = [
      (localization.Ill_go_easy_on_you),
      (localization.This_should_be_fun),
      (localization.You_asked_for_it),
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.sliderLabels
              .map(
                (label) => Text(
                  label,
                  style: GoogleFonts.roboto(
                    color: Apptheme.silver,
                    fontSize: FontSizeManager.tiny,
                    fontWeight: FontWeightManager.light,
                  ),
                ),
              )
              .toList(),
        ),

        const SizedBox(height: 16),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Apptheme.deepDarkNavy,
            borderRadius: BorderRadius.circular(8),
          ),
          child:
              Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        difficultyModeContainerEmojis[widget.currentIndex],
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(
                        widget.sliderLabels[widget.currentIndex],
                        style: GoogleFonts.roboto(
                          color: Apptheme.silver,
                          fontSize: FontSizeManager.bodyLarge,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                      Text(
                        difficultyModeContainerQuotes[widget.currentIndex],
                        style: GoogleFonts.roboto(
                          color: Apptheme.silver,
                          fontSize: FontSizeManager.caption,
                          fontWeight: FontWeightManager.light,
                        ),
                      ),
                    ],
                  )
                  .animate(key: ValueKey(widget.currentIndex))
                  .scale(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 200),
                  )
                  .fadeIn(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  ),
        ),
      ],
    );
  }
}
